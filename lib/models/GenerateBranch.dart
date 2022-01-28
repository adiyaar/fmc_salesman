  

class CustomerBranch {
  String id;
  String customerid;
  String contactperson;
  String mobileno;
  String branchaddress;
  String latitude;
  String longitude;
  String branchname;

  CustomerBranch(
      {this.id,
      this.customerid,
      this.contactperson,
      this.mobileno,
      this.branchaddress,
      this.latitude,
      this.longitude,
      this.branchname});

  CustomerBranch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerid = json['customerid'];
    contactperson = json['contactperson'];
    mobileno = json['mobileno'];
    branchaddress = json['branchaddress'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    branchname = json['branchname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customerid'] = this.customerid;
    data['contactperson'] = this.contactperson;
    data['mobileno'] = this.mobileno;
    data['branchaddress'] = this.branchaddress;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['branchname'] = this.branchname;
    return data;
  }

  static List<CustomerBranch> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => CustomerBranch.fromJson(item)).toList();
  }

  @override
  String toString() => branchname;
}
