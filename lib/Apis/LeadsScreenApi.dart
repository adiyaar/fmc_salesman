import 'dart:convert';
import 'package:http/http.dart' as http;

// Get the bottom description


class LeadDetailView {
  String id;
  String leadid;
  String seq;
  String code;
  String description;
  String unit;
  String qty;
  String notes;

  LeadDetailView(
      {this.id,
      this.leadid,
      this.seq,
      this.code,
      this.description,
      this.unit,
      this.qty,
      this.notes});

  LeadDetailView.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leadid = json['leadid'];
    seq = json['seq'];
    code = json['code'];
    description = json['description'];
    unit = json['unit'];
    qty = json['qty'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['leadid'] = this.leadid;
    data['seq'] = this.seq;
    data['code'] = this.code;
    data['description'] = this.description;
    data['unit'] = this.unit;
    data['qty'] = this.qty;
    data['notes'] = this.notes;
    return data;
  }
}





class CustomerContact {
  String id;
  String customerid;
  String department;
  String name;
  String telephone;
  String mobile;
  String whatsapp;
  String email;
  String qatarid;
  String fax;

  CustomerContact(
      {this.id,
      this.customerid,
      this.department,
      this.name,
      this.telephone,
      this.mobile,
      this.whatsapp,
      this.email,
      this.qatarid,
      this.fax});

  CustomerContact.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerid = json['customerid'];
    department = json['department'];
    name = json['name'];
    telephone = json['telephone'];
    mobile = json['mobile'];
    whatsapp = json['whatsapp'];
    email = json['email'];
    qatarid = json['qatarid'];
    fax = json['fax'];
  }

 Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customerid'] = this.customerid;
    data['department'] = this.department;
    data['name'] = this.name;
    data['telephone'] = this.telephone;
    data['mobile'] = this.mobile;
    data['whatsapp'] = this.whatsapp;
    data['email'] = this.email;
    data['qatarid'] = this.qatarid;
    data['fax'] = this.fax;
    return data;
  }
}