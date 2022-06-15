class Sbsinventoryqtys {
  String? link;

  Sbsinventoryqtys({this.link});

  Sbsinventoryqtys.fromJson(Map<String, dynamic> json) {
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['link'] = this.link;
    return data;
  }
}
