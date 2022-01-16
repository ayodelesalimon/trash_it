class OperatorModel {
  int? companyId;
  String? companyName;

  OperatorModel({this.companyId, this.companyName});

  OperatorModel.fromJson(Map<String, dynamic> json) {
    companyId = json['company_id'];
    companyName = json['company_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['company_id'] = this.companyId;
    data['company_name'] = this.companyName;
    return data;
  }
}