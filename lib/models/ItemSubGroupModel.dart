class ItemSubGroupModel {
  final String imageurl;
  final String title;
  final String id;
  ItemSubGroupModel({this.imageurl, this.title, this.id});

  factory ItemSubGroupModel.fromJson(Map<String, dynamic> json) {
    return ItemSubGroupModel(
      id: json['id'],
      imageurl: json['image'],
      title: json['etitle'],
    );
  }
}
