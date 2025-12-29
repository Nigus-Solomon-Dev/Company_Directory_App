import 'dart:convert';
List<CompanyList> companyListFromJson(String str) {
  List<dynamic> jsonList = json.decode(str);
  List<CompanyList> companyList = jsonList.map((jsonItem) {
    return CompanyList.fromJson(jsonItem);
  }).toList();
  return companyList;
}

class CompanyList {
  int id;
  String name;
  String address;
  String zip;
  String country;
  int employeeCount;
  String industry;
  int marketCap;
  String domain;
  String logo;
  String ceoName;

  CompanyList({
    required this.id,
    required this.name,
    required this.address,
    required this.zip,
    required this.country,
    required this.employeeCount,
    required this.industry,
    required this.marketCap,
    required this.domain,
    required this.logo,
    required this.ceoName,
  });

  factory CompanyList.fromJson(Map<String, dynamic> json) => CompanyList(
    id: json["id"],
    name: json["name"],
    address: json["address"],
    zip: json["zip"],
    country: json["country"],
    employeeCount: json["employeeCount"],
    industry: json["industry"],
    marketCap: json["marketCap"],
    domain: json["domain"],
    logo: json["logo"],
    ceoName: json["ceoName"],
  );
}
