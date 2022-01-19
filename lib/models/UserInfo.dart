class UserInfoModel {
  String id;
  String employeecode;
  String employeename;
  String qidno;
  String familyid;
  String username;
  String uRolecode;
  String workingin;
  String employeeCompany;
  String mobileno;
  String emailid;

  UserInfoModel(
      {this.id,
      this.employeecode,
      this.employeename,
      this.qidno,
      this.familyid,
      this.employeeCompany,
      this.username,
      this.uRolecode,
      this.workingin,
      this.mobileno,
      this.emailid});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeecode = json['employeecode'];
    employeename = json['employeename'];
    qidno = json['qidno'];
    familyid = json['familyid'];
    username = json['username'];
    uRolecode = json['u_rolecode'];
    workingin = json['workingin'];
    employeeCompany = json['employeewhichcompany'];
    mobileno = json['mobileno'];
    emailid = json['emailid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['employeecode'] = this.employeecode;
    data['employeename'] = this.employeename;
    data['qidno'] = this.qidno;
    data['familyid'] = this.familyid;
    data['username'] = this.username;
    data['employeewhichcompany'] = this.employeeCompany;
    data['u_rolecode'] = this.uRolecode;
    data['workingin'] = this.workingin;
    data['mobileno'] = this.mobileno;
    data['emailid'] = this.emailid;
    return data;
  }
}
