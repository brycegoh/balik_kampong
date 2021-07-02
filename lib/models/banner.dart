class Banner {
  int id;
  String url, imageUrl;

  Banner({
    required this.id,
    required this.url,
    required this.imageUrl,
  });

  factory Banner.fromJson(Map<String, dynamic> json) {
    return Banner(
      id: json['id'],
      imageUrl: json['image_url'],
      url: json['url'],
    );
  }
}
