import 'dart:async';
import 'package:balik_kampong/models/community.dart';
import 'package:balik_kampong/services/supaClient.dart';
import 'package:provider/provider.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:supabase/supabase.dart' as supa;

import 'package:balik_kampong/services/supaCommunities.dart';
import 'package:balik_kampong/utility/constants.dart';
import 'package:balik_kampong/widgets/layout.dart';
import 'package:flutter/material.dart';

import '../helper/loading.dart';
import '../../provider/user.dart';
import '../../utility/screensize.dart';
import '../../widgets/default.dart';

class BrowseCommunitiesScreen extends StatefulWidget {
  const BrowseCommunitiesScreen({Key? key}) : super(key: key);

  @override
  _BrowseCommunitiesScreenState createState() =>
      _BrowseCommunitiesScreenState();
}

class _BrowseCommunitiesScreenState extends State<BrowseCommunitiesScreen> {
  late Future _loadCommunities;
  Timer? _debounce;
  late final supa.RealtimeSubscription? sub;

  late List<Community> communities;
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    if (_debounce != null) {
      _debounce!.cancel();
    }
    if (sub != null) {
      SupaClient.removeSub(sub!);
    }

    super.dispose();
  }

  @override
  void initState() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    int countryId = userProvider.user!.countryId;

    _loadCommunities = _getAllCommunties(countryId);

    super.initState();
  }

  Future _getAllCommunties(int countryId) async {
    sub = SupaClient.subscribeToTable(
      table: 'communities',
      onInsert: ({newRecord}) {
        Community newCommunity = Community.fromJson(newRecord);
        List<Community> copy = communities = [...communities];
        copy.add(newCommunity);
        setState(() {
          communities = copy;
        });
      },
    );
    List<Community> allCommunities =
        await SupaCommunities.getAllCommunities(countryId: countryId);
    communities = allCommunities;
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    int countryId = userProvider.user!.countryId;
    return FutureBuilder(
      future: _loadCommunities,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingScreen();
        } else {
          return Scaffold(
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: KampongPaddedSafeArea(
                child: KampongFullScreenContainer(
                  child: KampongColumnStartStart(
                    children: [
                      KampongRowSpaceBetweenCenter(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 11.5),
                            child: Text("Communities Near You",
                                style: KampongFonts.header),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: IconButton(
                              icon: Icon(TablerIcons.plus),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, '/dynamicform?formId=1');
                              },
                            ),
                          )
                        ],
                      ),
                      _searchBar(context, countryId),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 11.5),
                          child: _scrollingCommunitiesSection(communities),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget _searchBar(context, countryId) {
    return Container(
      height: ScreenSize.safeAreaHeight(context) * 0.05,
      width: ScreenSize.safeAreaWidth(context) * 1,
      padding: EdgeInsets.symmetric(vertical: 2),
      margin: EdgeInsets.symmetric(horizontal: 11.5, vertical: 7),
      child: KampongRowCenterCenter(
        children: [
          Flexible(
            flex: 8,
            child: TextField(
              decoration: InputDecoration(hintText: "Search"),
              controller: searchController,
              onChanged: (text) {
                if (_debounce?.isActive ?? false) {
                  _debounce!.cancel();
                }
                _debounce = Timer(const Duration(milliseconds: 500), () async {
                  List<Community> allCommunties =
                      await SupaCommunities.getAllCommunities(
                    countryId: countryId,
                    search: searchController.text,
                  );
                  setState(() {
                    communities = allCommunties;
                  });
                });
              },
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(left: 2),
              height: ScreenSize.safeAreaHeight(context) * 0.08,
              child: IconButton(
                icon: Icon(TablerIcons.filter),
                onPressed: () {},
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _scrollingCommunitiesSection(List<Community> community) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: community.length,
      itemBuilder: (context, index) {
        return KampongBrowsingCommunityTile(
          community: community[index],
        );
      },
    );
  }
}

class KampongBrowsingCommunityTile extends StatefulWidget {
  final Community community;
  const KampongBrowsingCommunityTile({Key? key, required this.community})
      : super(key: key);

  @override
  _KampongBrowsingCommunityTileState createState() =>
      _KampongBrowsingCommunityTileState();
}

class _KampongBrowsingCommunityTileState
    extends State<KampongBrowsingCommunityTile> {
  int count = 0;

  @override
  void initState() {
    SupaCommunities.getNumOFParticipantsPerCommunity(
      communityId: widget.community.id,
    ).then((value) {
      setState(() {
        count = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = ScreenSize.safeAreaHeight(context) * 0.3;
    double width = ScreenSize.safeAreaWidth(context) * 1;
    return Container(
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      margin: EdgeInsets.symmetric(vertical: 1),
      height: height,
      width: width,
      child: KampongColumnStartStart(
        children: [
          Container(
            margin: EdgeInsets.only(top: 2),
            height: height * 0.6,
            width: width,
            decoration: new BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                image: new DecorationImage(
                  fit: BoxFit.cover,
                  image: new NetworkImage(
                    widget.community.imageUrl,
                  ),
                )),
          ),
          Container(
            margin: EdgeInsets.only(top: 5, bottom: 5),
            height: height * 0.11,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: widget.community.interestTags.map((String tag) {
                return Container(
                  margin: EdgeInsets.only(left: 5),
                  child: KampongChips(tag: tag),
                );
              }).toList(),
            ),
          ),
          KampongRowSpaceBetweenCenter(
            children: [
              KampongColumnStartStart(
                children: [
                  Text(widget.community.name, style: KampongFonts.header),
                  Text(widget.community.subheader,
                      style: KampongFonts.subHeader),
                ],
              ),
              Text(count.toString() +
                  " " +
                  "${count == 1 ? "Member" : "Members"}"),
            ],
          )
        ],
      ),
    );
  }
}
