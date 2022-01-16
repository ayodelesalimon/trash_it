class UserProfileModel {
  int? statusCode;
  String? status;
  Message? message;
  String? responseType;
  int? isValid;

  UserProfileModel(
      {this.statusCode,
      this.status,
      this.message,
      this.responseType,
      this.isValid});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    status = json['status'];
    message =
        json['message'] != null ? new Message.fromJson(json['message']) : null;
    responseType = json['response_type'];
    isValid = json['is_valid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['status'] = this.status;
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    data['response_type'] = this.responseType;
    data['is_valid'] = this.isValid;
    return data;
  }
}

class Message {
  String? firstName;
  String? lastName;
  String? email;
  String? customerId;
  String? phone;
  String? companyName;
  String? propertyType;
  String? ward;
  String? localGovt;

  Message(
      {this.firstName,
      this.lastName,
      this.email,
      this.customerId,
      this.phone,
      this.companyName,
      this.propertyType,
      this.ward,
      this.localGovt});

  Message.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    customerId = json['customer_id'];
    phone = json['phone'];
    companyName = json['company_name'];
    propertyType = json['property_type'];
    ward = json['ward'];
    localGovt = json['local_govt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['customer_id'] = this.customerId;
    data['phone'] = this.phone;
    data['company_name'] = this.companyName;
    data['property_type'] = this.propertyType;
    data['ward'] = this.ward;
    data['local_govt'] = this.localGovt;
    return data;
  }
}