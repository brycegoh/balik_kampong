import 'package:balik_kampong/widgets/default.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:provider/provider.dart';

import '../../utility/constants.dart';
import '../../utility/screensize.dart';
import '../../widgets/layout.dart';
import '../../widgets/default.dart';
import '../../models/country.dart';
import '../../models/interest.dart';
import '../../models/user.dart';
import '../../services/supaCountries.dart';
import '../../services/supaInterest.dart';
import '../../provider/user.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({Key? key}) : super(key: key);

  @override
  _OnboardScreenState createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  late Future _init;
  late List<Country> countries = [];
  late List<Interest> interests = [];
  bool isSubmitting = false;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  String? selectedCountry, firstName, lastName;
  int? countryId;
  List<String> selectedInterests = [];

  @override
  void initState() {
    _initForm();
    super.initState();
  }

  Future _initForm() async {
    List<Country> countriesFromSupa = await SupaCountries.getCountries();
    List<Interest> interestFromSupa = await SupaInterest.getInterests();
    print(interestFromSupa);
    setState(() {
      selectedCountry = null;
      countries = countriesFromSupa;
      interests = interestFromSupa;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: Container(
          padding: EdgeInsets.fromLTRB(
            23,
            30,
            23,
            30,
          ),
          child: KampongPaddedSafeArea(
              child: KampongColumnStartCenter(
            children: [
              _basicNameTextFields(),
              _countrySelector(),
              _chipsWrapInterstSelector(),
              KampongButton(
                text: "Submit",
                isLoading: isSubmitting,
                onPressed: () async {
                  setState(() {
                    isSubmitting = true;
                  });
                  bool success = await userProvider.onboardUser({
                    "country_name": selectedCountry,
                    "first_name": firstNameController.text,
                    "last_name": lastNameController.text,
                    "interest": selectedInterests,
                    "country_id": countryId!,
                    "is_onboard": true,
                  });

                  if (success) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/home', (route) => false);
                  } else {
                    setState(() {
                      isSubmitting = false;
                    });
                  }
                },
              ),
            ],
          ))),
    );
  }

  Widget _countrySelector() {
    return KampongColumnStartStart(
      children: [
        Text(
          "Which Kampong are you at?",
          style: KampongFonts.subHeader,
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 10, 0, 30),
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: ShapeDecoration(
              color: KampongColors.slab,
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1.0, style: BorderStyle.solid),
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              )),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              isExpanded: true,
              hint: Text("Where are you located?"),
              value: selectedCountry,
              icon: const Icon(TablerIcons.arrow_down),
              elevation: 20,
              menuMaxHeight: ScreenSize.safeAreaHeight(context) * 0.3,
              style: KampongFonts.countryDropDown,
              dropdownColor: KampongColors.slab,
              items: countries.map((Country e) {
                return DropdownMenuItem(
                  value: e.name,
                  child: Text(e.name),
                );
              }).toList(),
              onChanged: (String? newValue) {
                int? id;
                for (var i = 0; i < countries.length; i++) {
                  if (countries[i].name == newValue) {
                    id = countries[i].id;
                    break;
                  }
                }
                setState(() {
                  selectedCountry = newValue;
                  countryId = countries
                      .firstWhere((element) => element.name == newValue)
                      .id;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _chipsWrapInterstSelector() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 30),
      child: KampongColumnStartStart(
        children: [
          KampongColumnSpaceBetweenStretch(
            children: [
              Text(
                "What interests you?",
                style: KampongFonts.subHeader,
              ),
              Wrap(
                alignment: WrapAlignment.start,
                direction: Axis.horizontal,
                spacing: 10,
                runSpacing: 10,
                children: interests.map((e) {
                  return KampongInptChips(
                    onSelected: (bool selected) {
                      List<String> copyList = [...selectedInterests];
                      if (!selectedInterests.contains(e.name)) {
                        copyList.add(e.name);
                      } else {
                        copyList.remove(e.name);
                      }
                      setState(() {
                        selectedInterests = copyList;
                      });
                    },
                    isSelected: selectedInterests.contains(e.name),
                    label: e.name,
                    isEnabled: true,
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _basicNameTextFields() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 5, 0, 30),
      child: KampongColumnStartStart(
        children: [
          Text(
            "About you",
            style: KampongFonts.subHeader,
          ),
          KampongTextField(
            labelText: "First Name",
            controller: firstNameController,
            margin: EdgeInsets.symmetric(vertical: 3),
          ),
          KampongTextField(
            labelText: "Last Name",
            controller: lastNameController,
            margin: EdgeInsets.symmetric(vertical: 3),
          ),
        ],
      ),
    );
  }
}
