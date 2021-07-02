class Emergency {
  int id, countryId;
  String category, name, contact;

  Emergency(
      {required this.id,
      required this.countryId,
      required this.category,
      required this.name,
      required this.contact});

  factory Emergency.fromJson(Map<String, dynamic> json) {
    return Emergency(
      id: json['id'],
      countryId: json['country_id'],
      category: json['category'],
      name: json['name'],
      contact: json['contact'],
    );
  }
}
