class FAQModel {
  int? statusCode;
  String? status;
  List<Message>? message;
  String? responseType;
  int? isValid;

  FAQModel(
      {this.statusCode,
      this.status,
      this.message,
      this.responseType,
      this.isValid});

  FAQModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    status = json['status'];
    if (json['message'] != null) {
      message = <Message>[];
      json['message'].forEach((v) {
        message!.add(new Message.fromJson(v));
      });
    }
    responseType = json['response_type'];
    isValid = json['is_valid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['status'] = this.status;
    if (this.message != null) {
      data['message'] = this.message!.map((v) => v.toJson()).toList();
    }
    data['response_type'] = this.responseType;
    data['is_valid'] = this.isValid;
    return data;
  }
}

class Message {
  String? title;
  String? body;

  Message({this.title, this.body});

  Message.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }
}