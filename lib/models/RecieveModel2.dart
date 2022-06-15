class RecieveModel2 {
  var name;
  var metatype;
  var comment;
  var translationid;
  var errors;

  RecieveModel2(
      {this.name,
        this.metatype,
        this.comment,
        this.translationid,
        this.errors,
        });

  RecieveModel2.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    metatype = json['metatype'];
    comment = json['comment'];
    translationid = json['translationid'];
    errors = json['errors'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['metatype'] = this.metatype;
    data['comment'] = this.comment;
    data['translationid'] = this.translationid;
    data['errors'] = this.errors;

    return data;
  }
}

