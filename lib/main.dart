import 'package:company_directory_app/controllers/favorite_controller.dart';
import 'package:company_directory_app/controllers/feedback_controller.dart';
import 'package:company_directory_app/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final controllerFavorite = Get.put(FavoriteController());
  final controllerFeedback = Get.put(FeedbackController());
  await controllerFeedback.loadFeedbacks();
  await controllerFavorite.loadFavorites();

  runApp(GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage()));
}
