import 'dart:async';
import 'package:balik_kampong/models/food.dart';
import 'package:provider/provider.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:supabase/supabase.dart' as supa;

import 'package:balik_kampong/services/supaFood.dart';
import 'package:balik_kampong/utility/constants.dart';
import 'package:balik_kampong/widgets/layout.dart';
import 'package:flutter/material.dart';

import '../helper/loading.dart';
import '../../services/supaClient.dart';
import '../../provider/user.dart';
import '../../provider/fontSize.dart';
import '../../utility/screensize.dart';
import '../../widgets/default.dart';
import '../../models/user.dart';
import '../../models/review.dart';

class BrowseFoodScreen extends StatefulWidget {
  const BrowseFoodScreen({Key? key}) : super(key: key);

  @override
  _BrowseFoodScreenState createState() => _BrowseFoodScreenState();
}

class _BrowseFoodScreenState extends State<BrowseFoodScreen> {
  late Future _loadFood;
  Timer? _debounce;
  late final supa.RealtimeSubscription? sub;

  late List<Food> foodList;
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

    _loadFood = _getAllFood(countryId);

    super.initState();
  }

  Future _getAllFood(int countryId) async {
    sub = SupaClient.subscribeToTable(
      table: 'food',
      onInsert: ({newRecord}) {
        Food newFood = Food.fromJson(newRecord);

        List<Food> copy = [...foodList];
        copy.add(newFood);
        setState(() {
          foodList = copy;
        });
      },
    );
    List<Food> allFood = await SupaFood.getAllFood(countryId: countryId);
    foodList = allFood;
  }

  @override
  Widget build(BuildContext context) {
    final fontProvider = Provider.of<FontProvider>(context, listen: true);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    int countryId = userProvider.user!.countryId;
    return FutureBuilder(
      future: _loadFood,
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
                          Flexible(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 11.5),
                              child: Text(
                                "Food just like home",
                                style: Theme.of(context).textTheme.headline1,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: IconButton(
                              icon: Icon(TablerIcons.plus),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, '/dynamicform?formId=3');
                              },
                            ),
                          )
                        ],
                      ),
                      _searchBar(context, countryId),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 11.5),
                          child: _scrollingFoodSection(foodList),
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
                  List<Food> allFood = await SupaFood.getAllFood(
                    countryId: countryId,
                    search: searchController.text,
                  );
                  setState(() {
                    foodList = allFood;
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

  Widget _scrollingFoodSection(List<Food> foods) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: foods.length,
      itemBuilder: (context, index) {
        return KampongBrowsingFoodTile(
          food: foods[index],
        );
      },
    );
  }
}

class KampongBrowsingFoodTile extends StatefulWidget {
  final Food food;
  const KampongBrowsingFoodTile({Key? key, required this.food})
      : super(key: key);

  @override
  _KampongBrowsingFoodTileState createState() =>
      _KampongBrowsingFoodTileState();
}

class _KampongBrowsingFoodTileState extends State<KampongBrowsingFoodTile> {
  UserData? userReview;
  Review? review;

  @override
  void initState() {
    SupaFood.getLatestReview(foodId: widget.food.id).then((res) {
      setState(() {
        userReview = res["user"];
        review = res["review"];
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final fontProvider = Provider.of<FontProvider>(context, listen: true);
    double height = ScreenSize.safeAreaHeight(context) *
        0.3 *
        fontProvider.multiplier *
        1.2;
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
            height: height * 0.5,
            width: width,
            decoration: new BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                image: new DecorationImage(
                  fit: BoxFit.cover,
                  image: new NetworkImage(
                    widget.food.imageUrl,
                  ),
                )),
          ),
          KampongRowSpaceBetweenCenter(
            children: [
              Flexible(
                child: KampongColumnStartStart(
                  children: [
                    Text(widget.food.name,
                        style: Theme.of(context).textTheme.headline1),
                  ],
                ),
              ),
            ],
          ),
          Container(
            height: height * 0.12,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: widget.food.interestTags.map((String tag) {
                return Container(
                  margin: EdgeInsets.only(left: 5),
                  child: KampongChips(tag: tag),
                );
              }).toList(),
            ),
          ),
          KampongRowStartCenter(
            children: [
              userReview != null
                  ? Container(
                      padding: EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(userReview!.imageUrl!),
                      ),
                    )
                  : Container(),
              review != null
                  ? Expanded(
                      child: Text(
                        review!.review,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    )
                  : Container(),
            ],
          )
        ],
      ),
    );
  }
}
