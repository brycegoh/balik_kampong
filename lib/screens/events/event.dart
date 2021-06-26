import 'package:balik_kampong/services/supaEvents.dart';
import 'package:balik_kampong/widgets/default.dart';
import 'package:flutter/material.dart';

import '../../widgets/layout.dart';
import './browseEvent.dart';
import '../../utility/constants.dart';
import '../../utility/screensize.dart';
import '../../widgets/appBar.dart';
import '../../models/event.dart';
import '../helper/loading.dart';

class EventScreen extends StatefulWidget {
  final int eventId;
  const EventScreen({Key? key, required this.eventId}) : super(key: key);

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  late final Future _init;
  late final Event event;
  late final int count;

  @override
  void initState() {
    _init = _loadEvent();
    super.initState();
  }

  Future _loadEvent() async {
    event = await SupaEvents.getEventById(widget.eventId);
    count =
        await SupaEvents.getNumOFParticipantsPerEvents(eventId: widget.eventId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kampongDefaultAppBar(),
      body: FutureBuilder(
        future: _init,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingScreen();
          } else {
            return KampongPaddedSafeArea(
              child: KampongFullScreenContainer(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 11.5),
                  child: KampongColumnStartStart(
                    children: [
                      KampongBrowsingEventTile(
                        event: event,
                        isClickable: false,
                      ),
                      Text(
                        count.toString() + " people attending",
                        style: KampongFonts.labelDesc,
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
