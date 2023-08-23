class PaymentModel {
  bool? status;
  List<UserPaymentDate>? date;
  String? message;

  PaymentModel({this.status, this.date, this.message});

  PaymentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['date'] != null) {
      date = <UserPaymentDate>[];
      json['date'].forEach((v) {
        date!.add(new UserPaymentDate.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.date != null) {
      data['date'] = this.date!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class UserPaymentDate {
  int? id;
  int? userId;
  int? bookingId;
  String? transactionId;
  String? amount;
  String? time;
  String? createdAt;
  String? updatedAt;
  Booking? booking;

  UserPaymentDate(
      {this.id,
        this.userId,
        this.bookingId,
        this.time,
        this.transactionId,
        this.amount,
        this.createdAt,
        this.updatedAt,
        this.booking});

  UserPaymentDate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    time = json['time'];
    bookingId = json['booking_id'];
    transactionId = json['transaction_id'];
    amount = json['amount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    booking =
    json['booking'] != null ? new Booking.fromJson(json['booking']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['time'] = this.time;
    data['user_id'] = this.userId;
    data['booking_id'] = this.bookingId;
    data['transaction_id'] = this.transactionId;
    data['amount'] = this.amount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.booking != null) {
      data['booking'] = this.booking!.toJson();
    }
    return data;
  }
}

class Booking {
  int? id;
  int? userId;
  var stylistId;
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
  String? description;
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
