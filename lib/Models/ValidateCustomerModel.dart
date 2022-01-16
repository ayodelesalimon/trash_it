class ValidateCustomerModel {
  int? statusCode;
  String? status;
  Message? message;
  String? responseType;
  int? isValid;

  ValidateCustomerModel(
      {this.statusCode,
      this.status,
      this.message,
      this.responseType,
      this.isValid});

  ValidateCustomerModel.fromJson(Map<String, dynamic> json) {
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
  Company? company;
  String? customerId;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? propertyType;
  Ward? ward;
  LocalGovt? localGovt;

  Message(
      {this.company,
      this.customerId,
      this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.propertyType,
      this.ward,
      this.localGovt});

  Message.fromJson(Map<String, dynamic> json) {
    company = json['company_id'];
    customerId = json['customer_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    propertyType = json['property_type'];
     company = json['company'] != null ? new Company.fromJson(json['company']) : null;
    ward = json['ward'] != null ? new Ward.fromJson(json['ward']) : null;
    localGovt = json['local_govt'] != null
        ? new LocalGovt.fromJson(json['local_govt'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customerId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['property_type'] = this.propertyType;
    if (this.ward != null) {
      data['ward'] = this.ward!.toJson();
    }
      if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    if (this.localGovt != null) {
      data['local_govt'] = this.localGovt!.toJson();
    }
    return data;
  }
}

class Ward {
  int? wardId;
  String? wardName;

  Ward({this.wardId, this.wardName});

  Ward.fromJson(Map<String, dynamic> json) {
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

class LocalGovt {
  int? lgId;
  String? lgName;

  LocalGovt({this.lgId, this.lgName});

  LocalGovt.fromJson(Map<String, dynamic> json) {
    lgId = json['lg_id'];
    lgName = json['lg_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lg_id'] = this.lgId;
    data['lg_name'] = this.lgName;
    return data;
  }
}
class Company {
  String? companyId;
  String? companyName;

  Company({this.companyId, this.companyName});

  Company.fromJson(Map<String, dynamic> json) {
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