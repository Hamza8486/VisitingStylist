class GetTimeModel {
  bool? status;
  List<TimeModelData>? data;
  String? message;

  GetTimeModel({this.status, this.data, this.message});

  GetTimeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <TimeModelData>[];
      json['data'].forEach((v) {
        data!.add(new TimeModelData.fromJson(v));
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

class TimeModelData {
  int? id;
  int? userId;
  String? day;
  String? start;
  String? end;
  String? createdAt;
  String? updatedAt;

  TimeModelData(
      {this.id,
        this.userId,
        this.day,
        this.start,
        this.end,
        this.createdAt,
        this.updatedAt});

  TimeModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    day = json['day'];
    start = json['start'];
    end = json['end'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['day'] = this.day;
    data['start'] = this.start;
    data['end'] = this.end;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
