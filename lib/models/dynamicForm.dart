// {
//   form_id: 1,
//   table: ... ,
//   form: [

//     {
//       header: ....,

//      field: ... ,

//       type: ...,

//       widgets: [
//         {
//           key: ...,
//           value: ...,
//         }
//       ],

//       validation: [
//         {
//           key: ... ,
//           value: ... ,
//         }
//       ]

//     }

//   ]
// }

class DynamicForm {
  int formId;
  List<FormSection> form;
  String table;

  DynamicForm({
    required this.formId,
    required this.form,
    required this.table,
  });

  factory DynamicForm.fromJson(Map<String, dynamic> json) {
    return DynamicForm(
      formId: json['form_id'],
      table: json['table'],
      form: List<FormSection>.from(
          json["form"].map((value) => FormSection.fromJson(value))),
    );
  }
}

class FormSection {
  String header, type, field;
  List<KeyValuePair> widgets;
  List<KeyValuePair> validations;

  FormSection({
    required this.header,
    required this.field,
    required this.type,
    required this.widgets,
    required this.validations,
  });

  factory FormSection.fromJson(Map<String, dynamic> json) {
    return FormSection(
      header: json.containsKey("header") ? json["header"] : null,
      type: json['type'],
      field: json['field'],
      widgets: List<KeyValuePair>.from(
          json["widgets"].map((value) => KeyValuePair.fromJson(value))),
      validations: json.containsKey("validation")
          ? List<KeyValuePair>.from(
              json["validation"].map((value) => KeyValuePair.fromJson(value)))
          : [],
    );
  }
}

class KeyValuePair {
  String key;
  dynamic value;
  KeyValuePair({
    required this.key,
    required this.value,
  });
  factory KeyValuePair.fromJson(Map<String, dynamic> json) {
    return KeyValuePair(
      key: json["key"],
      value: json.containsKey("value") ? json["value"] : null,
    );
  }
}
