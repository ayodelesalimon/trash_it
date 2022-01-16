class LoginModel {
  int? statusCode;
  String? status;
  Message? message;
  String? responseType;
  int? isValid;

  LoginModel(
      {this.statusCode,
      this.status,
      this.message,
      this.responseType,
      this.isValid});

  LoginModel.fromJson(Map<String, dynamic> json) {
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
  String? message;
  String? accessToken;
  String? tokenType;

  Message({this.message, this.accessToken, this.tokenType});

  Message.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    accessToken = json['access_token'];
    tokenType = json['token_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    return data;
  }
}