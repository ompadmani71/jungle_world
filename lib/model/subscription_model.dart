import 'dart:convert';

List<SubscriptionModel> subscriptionModelFromJson(String str) => List<SubscriptionModel>.from(json.decode(str).map((x) => SubscriptionModel.fromJson(x)));


class SubscriptionModel {
  final int id;
  final String title;
  final String price;
  final String image;

  SubscriptionModel(
      {required this.id,
      required this.title,
      required this.price,
      required this.image});

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) => SubscriptionModel(
    id: json["id"],
    title: json["title"],
    price: json["price"],
    image: json["image"],
  );

}
