class WardModel {
  int? wardId;
  String? wardName;

  WardModel({this.wardId, this.wardName});

  WardModel.fromJson(Map<String, dynamic> json) {
    wardId = json['ward_id'];
    wardName = json['ward_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ward_id'] = this.wardId;
    data['ward_name'] = this.wardName;
    return data;
  }
}