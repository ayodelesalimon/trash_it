class ErrorModel {
  int? statusCode;
  String? status;
  Message? message;
  String? responseType;
  int? isValid;

  ErrorModel(
      {this.statusCode,
      this.status,
      this.message,
      this.responseType,
      this.isValid});

  ErrorModel.fromJson(Map<String, dynamic> json) {
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
  String? failed;

  Message({this.failed});

  Message.fromJson(Map<String, dynamic> json) {
    failed = json['failed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['failed'] = this.failed;
    return data;
  }
}