import 'package:company_directory_app/controllers/feedback_controller.dart';
import 'package:company_directory_app/models/feedback_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedBackPage extends StatefulWidget {
  const FeedBackPage({super.key});

  @override
  State<FeedBackPage> createState() => _FeedBackPageState();
}

class _FeedBackPageState extends State<FeedBackPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final feedBack = Get.find<FeedbackController>();

  void _submit() async {
    final feedback = FeedBackModel(
      name: _nameController.text,
      email: _emailController.text,
      message: _messageController.text,
      date: DateTime.now(),
    );
    await feedBack.saveFeedback(feedback);
    _nameController.clear();
    _emailController.clear();
    _messageController.clear();
    Get.snackbar('feedback', 'success');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding:  EdgeInsets.all(30.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
          Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),

          ),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.history, color: Colors.blue[700]),
                  SizedBox(width: 10),
                  Text(
                    'Previous Feedbacks',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800],
                    ),
                  ),
                ],
              ),
              ],),),
              SizedBox(height: 10),

            Obx(() {
              if (feedBack.feedbacks.isEmpty) {
                return Text('No feedbacks yet. Be the first!');
              }
              return Container(
                height: 300,
                child: ListView.builder(
                   itemCount: feedBack.feedbacks.length,
                    itemBuilder:  (context, index){
                      final feedback = feedBack.feedbacks[index];
                     return Card(
                         elevation: 1,
                         child: Padding(
                           padding:  EdgeInsets.all(12.0),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Row(
                                 children: [
                                   Text(
                                     feedback.name,
                                     style: TextStyle(
                                       fontWeight: FontWeight.bold,
                                       color: Colors.blue[800],
                                     ),
                                   ),
                                   SizedBox(width: 10,),
                                   Text(
                                     '${feedback.date.day}/${feedback.date.month}',
                                     style: TextStyle(
                                       fontSize: 12,
                                       color: Colors.grey,
                                     ),
                                   ),
                                 ],
                               ),
                               SizedBox(height: 5,),
                               Text(
                                 feedback.email,
                                 style: TextStyle(
                                   fontSize: 13,
                                   color: Colors.blue[600],
                                 ),
                               ),
                               SizedBox(height: 8),
                               Text(
                                 feedback.message,
                                 style: TextStyle(fontSize: 14),
                               ),
                             ],
                           ),
                         ),


                     );
                    }

                ),
              );


            }),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  labelText: 'Your Name',
                  prefixIcon: Icon(Icons.person, color: Colors.blue[700]),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter your name';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 30),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: Icon(Icons.email,color: Colors.blue[700]),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'You must enter your email address';
                  } else if (!GetUtils.isEmail(value)) {
                    return 'Enter your valid email';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 30),
              TextFormField(
                controller: _messageController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(56),

                  labelText: 'Your Feedback',
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  if (value!.isEmpty || value.length <= 8) {
                    return 'Your Feedback Must Be Greater than 8 character';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _submit();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700],
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text('submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
