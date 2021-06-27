class UserData {
  String authId;
  int id;
  int countryId;
  String firstName, lastName, countryName;
  String? imageUrl;
  List<String> interest;
  bool isOnboard;
  String contact;

  UserData({
    required this.countryName,
    required this.authId,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.interest,
    this.imageUrl = "",
    required this.countryId,
    this.isOnboard = false,
    required this.contact,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      authId: json['auth_id'],
      countryName: json["country_name"],
      countryId: json["country_id"],
      firstName: json['first_name'],
      isOnboard: json["is_onboard"],
      lastName: json['last_name'],
      imageUrl: json['image_url'],
      interest: List<String>.from(json["interest"].map((value) => value)),
      contact: json["contact"],
    );
  }
}
