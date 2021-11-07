class ItemGroupModel {
  final String imageurl;
  final String title;
  final String id;
  ItemGroupModel({this.imageurl, this.title, this.id});

  factory ItemGroupModel.fromJson(Map<String, dynamic> json) {
    return ItemGroupModel(
      id: json['id'],
      imageurl: json['image'],
      title: json['etitle'],
    );
  }
}
