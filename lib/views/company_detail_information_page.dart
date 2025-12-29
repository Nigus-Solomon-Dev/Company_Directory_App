import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:company_directory_app/controllers/favorite_controller.dart';
import 'package:company_directory_app/models/company_list_model.dart';

class CompanyDetailInformationPage extends StatelessWidget {
  final CompanyList company;

  const CompanyDetailInformationPage({super.key, required this.company});

  @override
  Widget build(BuildContext context) {
    final FavoriteController fav = Get.find<FavoriteController>();
    return Scaffold(
      backgroundColor: Colors.white12,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Obx(
              () => IconButton(
                onPressed: () => fav.toggleFavorite(company.id),
                icon: Icon(
                  fav.isFavorite(company.id)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color:
                      fav.isFavorite(company.id)
                          ? Colors.blueAccent
                          : Colors.blueGrey,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                company.name,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 10),
            Text(
              company.industry,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
              ),
            ),

            SizedBox(height: 30),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailWithIcon(Icons.person, 'CEO', company.ceoName),
                  _buildDetailWithIcon(Icons.location_on, 'Address', company.address,),
                  _buildDetailWithIcon(Icons.flag, 'Country', company.country),
                  _buildDetailWithIcon(Icons.people, 'Employees', '${company.employeeCount}',),
                  _buildDetailWithIcon(Icons.language, 'Website', company.domain,),
                ],
              ),
            ),SizedBox(height: 22,),
            ElevatedButton(onPressed: () {
              Get.back();
            },
              child:Text('Back'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: EdgeInsets.all(16),
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget _buildDetailWithIcon(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.blue[700], size: 22),
          ),
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(value, style: TextStyle(fontSize: 16, color: Colors.black)),
            ],
          ),
        ],
      ),
    );
  }
}
