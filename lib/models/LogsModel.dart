class LogsModel {
  String id;
  String idd;
  String updateon;
  String whichtable;
  String nameofuser;
  String comment;
  String commentdata;
  String commentto;
  String replyto;
  String createdon;

  LogsModel(
      {this.id,
      this.idd,
      this.updateon,
      this.whichtable,
      this.nameofuser,
      this.comment,
      this.commentdata,
      this.commentto,
      this.replyto,
      this.createdon});

  LogsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idd = json['idd'];
    updateon = json['updateon'];
    whichtable = json['whichtable'];
    nameofuser = json['nameofuser'];
    comment = json['comment'];
    commentdata = json['commentdata'];
    commentto = json['commentto'];
    replyto = json['replyto'];
    createdon = json['createdon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['idd'] = this.idd;
    data['updateon'] = this.updateon;
    data['whichtable'] = this.whichtable;
    data['nameofuser'] = this.nameofuser;
    data['comment'] = this.comment;
    data['commentdata'] = this.commentdata;
    data['commentto'] = this.commentto;
    data['replyto'] = this.replyto;
    data['createdon'] = this.createdon;
    return data;
  }
}
