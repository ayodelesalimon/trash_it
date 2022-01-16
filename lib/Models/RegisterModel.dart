class RegisterModel {
  int? statusCode;
  String? status;
  Message? message;
  String? responseType;
  int? isValid;

  RegisterModel(
      {this.statusCode,
      this.status,
      this.message,
      this.responseType,
      this.isValid});

  RegisterModel.fromJson(Map<String, dynamic> json) {
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
  String? success;
 List<String>? customerId;


  Message({this.success, this.customerId});

  Message.fromJson(Map<String, dynamic> json) {
    success = json['success'];
   //  customerId = json['customer_id'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
   // data['customer_id'] = this.customerId;
    return data;
  }
}