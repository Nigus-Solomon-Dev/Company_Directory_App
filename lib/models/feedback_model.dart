import 'dart:convert';
class FeedBackModel{
  String name;
  String email;
  String message;
  DateTime date;

  FeedBackModel({
    required this.name,
    required this.email,
    required this.message,
    required this.date,});
  factory FeedBackModel.fromjson(Map<String,dynamic>json){
    return FeedBackModel(
      name: json['name'] as String,
      email: json['email']  as String,
      message: json['message'] as String ,
      date: DateTime.parse(json['date'] as String ),

    );}
    Map<String, dynamic> toJson() {
      return {
        'name': name,
        'email': email,
        'message': message,
        'date': date.toIso8601String(),
      };
    }

}