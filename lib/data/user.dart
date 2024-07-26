import './Subcription.dart';

class User {
  int? userId;
  String? username;
  String? password;
  String? email;
  String? role;
  String? status;
  int? subcriptionId;
  String? expiredDate;
  Subcription? subcription;

  User(
      {this.userId,
        this.username,
        this.password,
        this.email,
        this.role,
        this.status,
        this.subcriptionId,
        this.expiredDate,
        this.subcription});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    username = json['username'];
    password = json['password'];
    email = json['email'];
    role = json['role'];
    status = json['status'];
    subcriptionId = json['subcriptionId'];
    expiredDate = json['expiredDate'];
    subcription = json['subcription'] != null
        ? new Subcription.fromJson(json['subcription'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['username'] = this.username;
    data['password'] = this.password;
    data['email'] = this.email;
    data['role'] = this.role;
    data['status'] = this.status;
    data['subcriptionId'] = this.subcriptionId;
    data['expiredDate'] = this.expiredDate;
    if (this.subcription != null) {
      data['subcription'] = this.subcription!.toJson();
    }
    return data;
  }
}