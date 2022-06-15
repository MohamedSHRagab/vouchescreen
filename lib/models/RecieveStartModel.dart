class RecieveStartModel {
  String? name;
  String? metatype;
  String? comment;
  String? translationid;
  Null? errors;
  List<Data>? data;

  RecieveStartModel(
      {this.name,
        this.metatype,
        this.comment,
        this.translationid,
        this.errors,
        this.data});

  RecieveStartModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    metatype = json['metatype'];
    comment = json['comment'];
    translationid = json['translationid'];
    errors = json['errors'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['metatype'] = this.metatype;
    data['comment'] = this.comment;
    data['translationid'] = this.translationid;
    data['errors'] = this.errors;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  var sid;

  Data({this.sid});

  Data.fromJson(Map<String, dynamic> json) {
    sid = json['sid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sid'] = this.sid;
    return data;
  }
}