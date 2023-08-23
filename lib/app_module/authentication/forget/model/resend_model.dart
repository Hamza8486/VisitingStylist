class ResendModel {
  bool? status;
  int? id;
  String? message;

  ResendModel({this.status, this.id, this.message});

  ResendModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    id = json['id'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['id'] = this.id;
    data['message'] = this.message;
    return data;
  }
}
