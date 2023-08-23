class StylishPaymentModel {
  bool? status;
  List<StylishPaymentAllData>? data;
  String? message;

  StylishPaymentModel({this.status, this.data, this.message});

  StylishPaymentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <StylishPaymentAllData>[];
      json['data'].forEach((v) {
        data!.add(new StylishPaymentAllData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class StylishPaymentAllData {
  int? id;
  int? userId;
  int? bookingId;
  var transactionId;
  String? amount;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? time;
  Booking? booking;

  StylishPaymentAllData(
      {this.id,
        this.userId,
        this.bookingId,
        this.transactionId,
        this.amount,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.time,
        this.booking});

  StylishPaymentAllData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    bookingId = json['booking_id'];
    transactionId = json['transaction_id'];
    amount = json['amount'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    time = json['time'];
    booking =
    json['booking'] != null ? new Booking.fromJson(json['booking']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['booking_id'] = this.bookingId;
    data['transaction_id'] = this.transactionId;
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['time'] = this.time;
    if (this.booking != null) {
      data['booking'] = this.booking!.toJson();
    }
    return data;
  }
}

class Booking {
  int? id;
  int? userId;
  int? stylistId;
  String? address;
  String? lat;
  String? long;
  String? date;
  String? start;
  String? end;
  int? total;
  int? amount;
  String? status;
  int? paymentStatus;
  var description;
  String? createdAt;
  String? updatedAt;

  Booking(
      {this.id,
        this.userId,
        this.stylistId,
        this.address,
        this.lat,
        this.long,
        this.date,
        this.start,
        this.end,
        this.total,
        this.amount,
        this.status,
        this.paymentStatus,
        this.description,
        this.createdAt,
        this.updatedAt});

  Booking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    stylistId = json['stylist_id'];
    address = json['address'];
    lat = json['lat'];
    long = json['long'];
    date = json['date'];
    start = json['start'];
    end = json['end'];
    total = json['total'];
    amount = json['amount'];
    status = json['status'];
    paymentStatus = json['payment_status'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['stylist_id'] = this.stylistId;
    data['address'] = this.address;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['date'] = this.date;
    data['start'] = this.start;
    data['end'] = this.end;
    data['total'] = this.total;
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['payment_status'] = this.paymentStatus;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
