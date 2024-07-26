class Subcription {
  int? subId;
  String? subName;
  int? subPrice;
  String? subdesc;

  Subcription(
      {this.subId, this.subName, this.subPrice, this.subdesc});

  Subcription.fromJson(Map<String, dynamic> json) {
    subId = json['subId'];
    subName = json['subName'];
    subPrice = json['subPrice'];
    subdesc = json['subdesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subId'] = this.subId;
    data['subName'] = this.subName;
    data['subPrice'] = this.subPrice;
    data['subdesc'] = this.subdesc;
    return data;
  }
}