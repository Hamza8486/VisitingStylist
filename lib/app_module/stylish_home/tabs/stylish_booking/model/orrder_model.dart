class GetOrderModels {
  bool? status;
  List<OrderStylishData>? data;
  String? message;

  GetOrderModels({this.status, this.data, this.message});

  GetOrderModels.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <OrderStylishData>[];
      json['data'].forEach((v) {
        data!.add(new OrderStylishData.fromJson(v));
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

class OrderStylishData {
  int? id;
  int? bookingId;
  int? stylistId;
  String? createdAt;
  String? updatedAt;
  Booking? booking;

  OrderStylishData(
      {this.id,
        this.bookingId,
        this.stylistId,
        this.createdAt,
        this.updatedAt,
        this.booking});

  OrderStylishData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['booking_id'];
    stylistId = json['stylist_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    booking =
    json['booking'] != null ? new Booking.fromJson(json['booking']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['booking_id'] = this.bookingId;
    data['stylist_id'] = this.stylistId;
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
  List<Services>? services;
  Client? client;

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
        this.updatedAt,
        this.services,
        this.client});

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
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
    client =
    json['client'] != null ? new Client.fromJson(json['client']) : null;
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
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    if (this.client != null) {
      data['client'] = this.client!.toJson();
    }
    return data;
  }
}

class Services {
  int? id;
  int? categoryId;
  String? name;
  int? price;
  String? description;
  String? image;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  Services(
      {this.id,
        this.categoryId,
        this.name,
        this.price,
        this.description,
        this.image,
        this.createdAt,
        this.updatedAt,
        this.pivot});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['name'] = this.name;
    data['price'] = this.price;
    data['description'] = this.description;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? bookingId;
  int? serviceId;

  Pivot({this.bookingId, this.serviceId});

  Pivot.fromJson(Map<String, dynamic> json) {
    bookingId = json['booking_id'];
    serviceId = json['service_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['booking_id'] = this.bookingId;
    data['service_id'] = this.serviceId;
    return data;
  }
}

class Client {
  int? id;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? emailVerifiedAt;
  String? address;
  String? lat;
  String? long;
  String? postCode;
  String? type;
  int? status;
  String? image;
  String? provider;
  String? providerId;
  String? createdAt;
  String? updatedAt;
  String? stripeId;
  var pmType;
  var pmLastFour;
  var trialEndsAt;

  Client(
      {this.id,
        this.firstName,
        this.lastName,
        this.phone,
        this.email,
        this.emailVerifiedAt,
        this.address,
        this.lat,
        this.long,
        this.postCode,
        this.type,
        this.status,
        this.image,
        this.provider,
        this.providerId,
        this.createdAt,
        this.updatedAt,
        this.stripeId,
        this.pmType,
        this.pmLastFour,
        this.trialEndsAt});

  Client.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    address = json['address'];
    lat = json['lat'];
    long = json['long'];
    postCode = json['post_code'];
    type = json['type'];
    status = json['status'];
    image = json['image'];
    provider = json['provider'];
    providerId = json['provider_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    stripeId = json['stripe_id'];
    pmType = json['pm_type'];
    pmLastFour = json['pm_last_four'];
    trialEndsAt = json['trial_ends_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['address'] = this.address;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['post_code'] = this.postCode;
    data['type'] = this.type;
    data['status'] = this.status;
    data['image'] = this.image;
    data['provider'] = this.provider;
    data['provider_id'] = this.providerId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['stripe_id'] = this.stripeId;
    data['pm_type'] = this.pmType;
    data['pm_last_four'] = this.pmLastFour;
    data['trial_ends_at'] = this.trialEndsAt;
    return data;
  }
}
