import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/layout.dart';
import '../../widgets/default.dart';
import '../../utility/constants.dart';
import '../../utility/screensize.dart';
import '../../models/emergency.dart';
import '../../services/supaEmergency.dart';

class SosScreen extends StatefulWidget {
  final int countryId;
  const SosScreen({Key? key, required this.countryId}) : super(key: key);

  @override
  _SosScreenState createState() => _SosScreenState();
}

class _SosScreenState extends State<SosScreen> {
  late Future _initContacts;
  late final List<Emergency> contacts;

  @override
  void initState() {
    _initContacts = _getContacts(widget.countryId);
    super.initState();
  }

  Future<void> _getContacts(int countryId) async {
    List<Emergency> x = await SupaEmergency.getEmergency(countryId);
    setState(() {
      contacts = x;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kampongDefaultAppBar(),
      body: FutureBuilder(
        future: _initContacts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          } else {
            List<Emergency> medical = contacts
                .where((element) => element.category == "Medical Hotline")
                .toList();
            List<Emergency> embassy = contacts
                .where((element) => element.category == "Embassy Hotline")
                .toList();
            List<Emergency> police = contacts
                .where((element) => element.category == "Police Hotline")
                .toList();
            List<Emergency> mental = contacts
                .where((element) =>
                    element.category ==
                    "Singapore Association for Mental Health")
                .toList();

            return KampongPaddedSafeArea(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 11.5),
                height: ScreenSize.safeAreaHeight(context),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Emergency Hotlines',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Medical Hotlines',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                    ...medical.map((e) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: KampongRowSpaceBetweenCenter(children: [
                          Flexible(
                            flex: 1,
                            child: Text(e.name,
                                style: Theme.of(context).textTheme.headline6),
                          ),
                          Flexible(
                            flex: 1,
                            child: TextButton(
                              onPressed: () async {
                                if (e.name == "Email") {
                                  String _url =
                                      'mailto://${e.contact}?subject=Enquiry&body=Dear Staff,';
                                  await launch(_url);
                                } else {
                                  String _url =
                                      'tel://${e.contact.replaceAll(" ", "")}';
                                  await launch(_url);
                                }
                              },
                              child: Text(e.contact,
                                  style: Theme.of(context).textTheme.bodyText2),
                            ),
                          ),
                        ]),
                      );
                    }),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Embassy Hotlines',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                    ...embassy.map((e) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: KampongRowSpaceBetweenCenter(children: [
                          Flexible(
                            flex: 1,
                            child: Text(e.name,
                                style: Theme.of(context).textTheme.headline6),
                          ),
                          Flexible(
                            flex: 1,
                            child: TextButton(
                              onPressed: () async {
                                if (e.name == "Email") {
                                  String _url =
                                      'mailto://${e.contact}?subject=Enquiry&body=Dear Staff,';
                                  await launch(_url);
                                } else {
                                  String _url =
                                      'tel://${e.contact.replaceAll(" ", "")}';
                                  await launch(_url);
                                }
                              },
                              child: Text(e.contact,
                                  style: Theme.of(context).textTheme.bodyText2),
                            ),
                          ),
                        ]),
                      );
                    }),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Police Hotlines',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                    ...police.map((e) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: KampongRowSpaceBetweenCenter(children: [
                          Flexible(
                            flex: 1,
                            child: Text(e.name,
                                style: Theme.of(context).textTheme.headline6),
                          ),
                          Flexible(
                            flex: 1,
                            child: TextButton(
                              onPressed: () async {
                                if (e.name == "Email") {
                                  String _url =
                                      'mailto://${e.contact}?subject=Enquiry&body=Dear Staff,';
                                  await launch(_url);
                                } else {
                                  String _url =
                                      'tel://${e.contact.replaceAll(" ", "")}';
                                  await launch(_url);
                                }
                              },
                              child: Text(e.contact,
                                  style: Theme.of(context).textTheme.bodyText2),
                            ),
                          ),
                        ]),
                      );
                    }),
                    Text(
                      'Mental Wellness Hotlines',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Singapore Association for Mental Health',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                    ...mental.map((e) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: KampongRowSpaceBetweenCenter(children: [
                          Flexible(
                            flex: 1,
                            child: Text(e.name,
                                style: Theme.of(context).textTheme.headline6),
                          ),
                          Flexible(
                            flex: 1,
                            child: TextButton(
                              onPressed: () async {
                                if (e.name == "Email") {
                                  String _url = 'mailto:${e.contact}';
                                  await launch(_url);
                                } else {
                                  String _url =
                                      'tel://${e.contact.replaceAll(" ", "")}';
                                  await launch(_url);
                                }
                              },
                              child: Text(e.contact,
                                  style: Theme.of(context).textTheme.bodyText2),
                            ),
                          ),
                        ]),
                      );
                    }),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
