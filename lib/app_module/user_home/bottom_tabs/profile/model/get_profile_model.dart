class GetProfileModel {
  bool? status;
  Data? data;
  String? message;

  GetProfileModel({this.status, this.data, this.message});

  GetProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? id;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? emailVerifiedAt;
  String? address;
 var lat;
  var long;
  String? postCode;
  String? type;
  int? status;
  String? image;
  String? provider;
  String? providerId;
  String? createdAt;
  String? updatedAt;
  var stripeId;
  var pmType;
  var pmLastFour;
  var trialEndsAt;

  Data(
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

  Data.fromJson(Map<String, dynamic> json) {
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
