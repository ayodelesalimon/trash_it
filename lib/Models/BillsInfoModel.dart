class BillsModel {
  int? statusCode;
  String? status;
  List<Message>? message;
  String? responseType;
  int? isValid;

  BillsModel(
      {this.statusCode,
      this.status,
      this.message,
      this.responseType,
      this.isValid});

  BillsModel.fromJson(Map<String, dynamic> json) {
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
  int? billId;
  String? customerIdCode;
  String? propertyType;
  String? billingAddress;
  String? invoiceNumber;
  String? currency;
  int? total;
  String? paidStatus;
  String? invoiceDate;
  String? dueDate;
  String? note;

  Message(
      {this.billId,
      this.customerIdCode,
      this.propertyType,
      this.billingAddress,
      this.invoiceNumber,
      this.currency,
      this.total,
      this.paidStatus,
      this.invoiceDate,
      this.dueDate,
      this.note});

  Message.fromJson(Map<String, dynamic> json) {
    billId = json['bill_id'];
    customerIdCode = json['customer_id_code'];
    propertyType = json['property_type'];
    billingAddress = json['billing_address'];
    invoiceNumber = json['invoice_number'];
    currency = json['currency'];
    total = json['total'];
    paidStatus = json['paid_status'];
    invoiceDate = json['invoice_date'];
    dueDate = json['due_date'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bill_id'] = this.billId;
    data['customer_id_code'] = this.customerIdCode;
    data['property_type'] = this.propertyType;
    data['billing_address'] = this.billingAddress;
    data['invoice_number'] = this.invoiceNumber;
    data['currency'] = this.currency;
    data['total'] = this.total;
    data['paid_status'] = this.paidStatus;
    data['invoice_date'] = this.invoiceDate;
    data['due_date'] = this.dueDate;
    data['note'] = this.note;
    return data;
  }
}