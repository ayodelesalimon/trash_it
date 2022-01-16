class LgaModel {
  int? lgaId;
  String? lgaName;

  LgaModel({this.lgaId, this.lgaName});

  LgaModel.fromJson(Map<String, dynamic> json) {
    lgaId = json['lga_id'];
    lgaName = json['lga_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lga_id'] = this.lgaId;
    data['lga_name'] = this.lgaName;
    return data;
  }
}