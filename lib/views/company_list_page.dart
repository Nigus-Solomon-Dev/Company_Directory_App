import 'package:company_directory_app/controllers/favorite_controller.dart';
import 'package:company_directory_app/models/company_list_model.dart';
import 'package:company_directory_app/views/company_detail_information_page.dart';
import 'package:flutter/material.dart';
import 'package:company_directory_app/service/company_list_service.dart';
import 'package:get/get.dart';

class CompanyListPage extends StatefulWidget {
  const CompanyListPage({super.key});

  @override
  State<CompanyListPage> createState() => _CompanyListPageState();
}

class _CompanyListPageState extends State<CompanyListPage> {
  final fav = Get.find<FavoriteController>();
  List<CompanyList>? companyList;
  bool isloaded = false;

  getList() async {
    companyList = await CompanyListService().getCompanyList();
    // CompanyList(id: 1, name: "Tech Corp", ceoName: "John Doe", ...),
    if (companyList != null) {
      setState(() {
        isloaded = true;
      });
    }
  }
  @override
  void initState() {
    super.initState();
    getList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Company List',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
      ),
      body: Visibility(
        visible: isloaded == true,
        child: ListView.builder(
          itemCount: companyList?.length ?? 0,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              elevation: 2,
              child: InkWell(
                onTap: () {
                  Get.to(
                    () => CompanyDetailInformationPage(
                      company: companyList![index],
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 20, 0, 20),
                  child: Row(
                   children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                        child: Icon(
                          Icons.business,
                          color: Colors.blue[700],
                          size: 30,
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Container(
                          height: 50,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${companyList![index].name}',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey[900],
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'CE0 :companyList![index].ceoName',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                  fontStyle: FontStyle.italic,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Obx(
                        () => IconButton(
                          onPressed: () {
                            fav.toggleFavorite(companyList![index].id);
                          },
                          icon: Icon(
                            fav.isFavorite(companyList![index].id)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color:
                                fav.isFavorite(companyList![index].id)
                                    ? Colors.blue[700]
                                    : Colors.grey,
                            size: 28,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        replacement: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
