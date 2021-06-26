class Review {
  int id, foodId, userId;
  String review, dateCreated;

  Review(
      {required this.id,
      required this.foodId,
      required this.userId,
      required this.review,
      required this.dateCreated});

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      foodId: json['food_id'],
      userId: json['user_id'],
      review: json['review'],
      dateCreated: json['date_created'],
    );
  }
}
