import 'package:company_directory_app/models/company_list_model.dart';
import 'package:http/http.dart' as http;

class CompanyListService {
  Future<List<CompanyList>?> getCompanyList() async {
    try {
      final response = await http.get(
        Uri.parse('https://fake-json-api.mock.beeceptor.com/companies'),
      );
      if (response.statusCode == 200) {
        return companyListFromJson(response.body);
      }else{
        return null;
      }
    } catch (e) {
      print('error catch');
    }
  }
}
