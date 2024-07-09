class User {
  int? userId;
  String? username;
  String? password;
  String? email;
  String? role;
  String? status;

  User(
      {this.userId,
        this.username,
        this.password,
        this.email,
        this.role,
        this.status});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    username = json['username'];
    password = json['password'];
    email = json['email'];
    role = json['role'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['username'] = this.username;
    data['password'] = this.password;
    data['email'] = this.email;
    data['role'] = this.role;
    data['status'] = this.status;
    return data;
  }
}