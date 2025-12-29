import 'dart:convert';

import 'package:company_directory_app/models/feedback_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeedbackController extends GetxController{
  var feedbacks=<FeedBackModel>[].obs;

  Future<void>loadFeedbacks()async{
    final prefs=await SharedPreferences.getInstance();
    final saved=prefs.getStringList('feedback')?? [];

    final loadFeadbacks=saved.map((jsonString){
      final json=jsonDecode(jsonString);
      return FeedBackModel.fromjson(json);}).toList();

         feedbacks.value=loadFeadbacks;

    }
  Future<void>saveFeedback(FeedBackModel feedback)async{
    final prefs = await SharedPreferences.getInstance();
    feedbacks.add(feedback);
    final feedbacksAsString = feedbacks.map((fb) {
      return jsonEncode(fb.toJson());
    }).toList();
    await prefs.setStringList('feedback', feedbacksAsString);
  }
  }

