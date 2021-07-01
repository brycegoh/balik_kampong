import 'package:balik_kampong/widgets/default.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:jiffy/jiffy.dart';

import '../../utility/constants.dart';
import '../../utility/screensize.dart';
import '../../widgets/layout.dart';
import '../../widgets/default.dart';
import '../../models/country.dart';
import '../../models/interest.dart';
import '../../models/dynamicForm.dart';
import '../../services/supaCountries.dart';
import '../../services/supaForm.dart';
import '../../provider/user.dart';

class DynamicFormScreen extends StatefulWidget {
  final int formId;
  const DynamicFormScreen({Key? key, required this.formId}) : super(key: key);

  @override
  _DynamicFormScreenState createState() => _DynamicFormScreenState();
}

class _DynamicFormScreenState extends State<DynamicFormScreen> {
  late Future _init;
  late DynamicForm formConfig;
  late Map<int, dynamic> errors = {};
  Map<int, Map<int, TextEditingController>> controllers = {};
  bool isSubmitting = false;

  // errors = {
  //   section_index: {
  //     widget_index: String
  //   }
  // }

  @override
  void initState() {
    _init = _initForm(widget.formId);
    super.initState();
  }

  Future _initForm(int formId) async {
    var response = await SupaForm.getFormById(formId);

    Map<int, Map<int, TextEditingController>> tempController = {};
    DynamicForm form = response["data"];
    int sectionIndex = 0;
    form.form.forEach((element) {
      if (element.type == 'textfield') {
        int widgetIndex = 0;
        element.widgets.forEach((e) {
          if (!tempController.containsKey(sectionIndex)) {
            tempController[sectionIndex] = {};
          }
          tempController[sectionIndex]![widgetIndex] = TextEditingController();
          widgetIndex++;
        });
      }
      sectionIndex++;
    });

    if (response["success"]) {
      setState(() {
        formConfig = response["data"];
        controllers = tempController;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    int userId = userProvider.user!.id;
    int countryId = userProvider.user!.countryId;
    return Scaffold(
      appBar: kampongDefaultAppBar(),
      body: Container(
        padding: EdgeInsets.fromLTRB(
          23,
          30,
          23,
          30,
        ),
        child: KampongPaddedSafeArea(
          child: Container(
            height: ScreenSize.safeAreaHeight(context) * 0.9,
            width: ScreenSize.safeAreaWidth(context) * 0.9,
            child: KampongColumnCenterStart(
              children: [
                FutureBuilder(
                  future: _init,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container();
                    } else {
                      return Flexible(
                        flex: 10,
                        child: ListView.builder(
                          physics: AlwaysScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: formConfig.form.length,
                          itemBuilder: (context, sectionIndex) {
                            FormSection section = formConfig.form[sectionIndex];
                            return dynamicFormMap(section, sectionIndex);
                          },
                        ),
                      );
                    }
                  },
                ),
                Flexible(
                  flex: 1,
                  child: KampongRowCenterCenter(
                    children: [
                      _submitButton(widget.formId, userId, countryId),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _submitButton(int formId, int userId, int countryId) {
    return KampongButton(
      text: "Submit",
      isLoading: isSubmitting,
      onPressed: () async {
        setState(() {
          isSubmitting = true;
        });

        Map<int, dynamic> errorMap = {};
        int sectionIndex = 0;

        controllers.keys.forEach((int sectionId) {
          controllers[sectionId]!
              .forEach((int widgetId, TextEditingController control) {
            formConfig.form[sectionId].widgets[widgetId].value = control.text;
          });
        });

        formConfig.form.forEach((FormSection section) {
          String widgetType = section.type;
          section.validations.forEach((KeyValuePair validation) {
            int widgetIndex = 0;
            String type = validation.key;
            int value = validation.value;

            switch (type) {
              case "gt":
                if (widgetType == "textfield") {
                  section.widgets.forEach((element) {
                    if (!(element.value.length > value)) {
                      if (!errorMap.containsKey(sectionIndex)) {
                        errorMap[sectionIndex] = {};
                      }
                      errorMap[sectionIndex]![widgetIndex] =
                          "Need to be more than $value characters";
                    }
                    widgetIndex++;
                  });
                } else if (widgetType == "chips") {
                  int numOfTrue = section.widgets
                      .where((element) => element.value == true)
                      .length;
                  if (!(numOfTrue > value)) {
                    errorMap[sectionIndex] =
                        "Need to select more than $value options";
                  }
                } else if (widgetType == 'datetime') {
                  if (section.widgets[0].value == null ||
                      section.widgets[0].value == false) {
                    errorMap[sectionIndex] = "Select a date";
                  } else if (!Jiffy(section.widgets[0].value)
                      .isAfter(Jiffy())) {
                    errorMap[sectionIndex] =
                        "Need to select a date later than ${Jiffy().format("dd/MM/yyyy HH:mm")}";
                  }
                }
            }
          });
          sectionIndex++;
        });

        if (errorMap.keys.length > 0) {
          setState(() {
            errors = errorMap;
            isSubmitting = false;
          });
        } else {
          Map<String, bool> response =
              await SupaForm.submitForm(formConfig, userId, countryId);

          if (response["success"]!) {
            Navigator.maybePop(context);
            setState(() {
              isSubmitting = false;
            });
          } else {
            setState(() {
              isSubmitting = false;
            });
          }
        }
      },
    );
  }

  Widget dynamicFormMap(FormSection section, int sectionIndex) {
    String type = section.type;
    String header = section.header;
    List<KeyValuePair> widgets = section.widgets;

    switch (type) {
      case "textfield":
        int counter = 0;
        return Container(
          margin: EdgeInsets.fromLTRB(0, 5, 0, 30),
          child: KampongColumnStartStart(
            children: [
              header != null
                  ? Text(
                      header,
                      style: KampongFonts.subHeader,
                    )
                  : Container(),
              ...widgets.map((KeyValuePair e) {
                int widgetIndex = counter;
                counter++;

                return _inputErrorDecorator(
                  errorText: errors.containsKey(sectionIndex)
                      ? (errors.containsKey(widgetIndex)
                          ? errors[sectionIndex]![widgetIndex]
                          : null)
                      : null,
                  child: KampongTextField(
                    labelText: e.key,
                    controller: controllers[sectionIndex]![widgetIndex]!,
                    margin: EdgeInsets.symmetric(vertical: 3),
                  ),
                );
              }).toList()
            ],
          ),
        );

      case "chips":
        int counter = 0;
        return _inputErrorDecorator(
          errorText:
              errors.containsKey(sectionIndex) ? errors[sectionIndex] : null,
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 10, 0, 30),
            child: KampongColumnStartStart(
              children: [
                KampongColumnSpaceBetweenStretch(
                  children: [
                    Text(
                      header,
                      style: KampongFonts.subHeader,
                    ),
                    Wrap(
                      alignment: WrapAlignment.start,
                      direction: Axis.horizontal,
                      spacing: 10,
                      runSpacing: 10,
                      children: widgets.map((KeyValuePair e) {
                        int widgetIndex = counter;
                        counter++;
                        return KampongInptChips(
                          onSelected: (bool selected) {
                            setState(() {
                              formConfig.form[sectionIndex].widgets[widgetIndex]
                                      .value =
                                  !formConfig.form[sectionIndex]
                                      .widgets[widgetIndex].value;
                            });
                          },
                          isSelected: formConfig
                              .form[sectionIndex].widgets[widgetIndex].value,
                          label: e.key,
                          isEnabled: true,
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );

      case "datetime":
        int counter = 0;
        Future<String> getTimeZone(context) async {
          Locale myLocale = Localizations.localeOf(context);
          // String sysTimezone = DateTime.now().timeZoneName;
          return myLocale.countryCode!;
        }

        return Container(
          margin: EdgeInsets.fromLTRB(0, 5, 0, 30),
          child: KampongColumnStartStart(
            children: [
              header != null
                  ? Text(
                      header,
                      style: KampongFonts.subHeader,
                    )
                  : Container(),
              ...widgets.map((KeyValuePair e) {
                int widgetIndex = counter;
                counter++;
                return FutureBuilder(
                  future: getTimeZone(context),
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return _loadingDateTime();
                    } else {
                      return _inputErrorDecorator(
                        errorText: errors.containsKey(sectionIndex)
                            ? errors[sectionIndex]
                            : null,
                        child: KampongColumnStartCenter(
                          children: [
                            OutlinedButton(
                              onPressed: () => _triggerDateTimePicker(
                                  context, sectionIndex, widgetIndex),
                              child: KampongRowStartCenter(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.all(10),
                                    padding: EdgeInsets.only(bottom: 5),
                                    child: Icon(TablerIcons.calendar, size: 23),
                                  ),
                                  Text(e.value != null &&
                                          e.value != false &&
                                          e.value != true
                                      ? Jiffy(e.value)
                                          .format("dd/MM/yyyy HH:mm")
                                      : "Choose a date"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                );
              }).toList()
            ],
          ),
        );

      default:
        return Container();
    }
  }

  Widget _inputErrorDecorator(
      {required Widget child, required String? errorText}) {
    return InputDecorator(
      decoration: InputDecoration(
        errorText: errorText,
        border: errorText != null ? OutlineInputBorder() : InputBorder.none,
        contentPadding: EdgeInsets.only(left: 2, bottom: 2, top: 2, right: 2),
      ),
      child: child,
    );
  }

  Widget _loadingDateTime() {
    return KampongRowCenterCenter(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: null,
            child: KampongRowSpaceAroundCenter(
              children: [
                Icon(TablerIcons.calendar),
                Text("Loading date"),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _triggerDateTimePicker(context, int sectionIndex, int widgetIndex) {
    DatePicker.showDateTimePicker(
      context,
      showTitleActions: true,
      onConfirm: (DateTime date) {
        String newDate = Jiffy(date).format();
        setState(() {
          formConfig.form[sectionIndex].widgets[widgetIndex].value = newDate;
        });
      },
      currentTime: DateTime.now(),
      locale: LocaleType.en,
    );
  }
}
