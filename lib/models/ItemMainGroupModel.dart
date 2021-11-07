class ItemMainGroupModel {
  final String imageUrl;
  final String title;
  final String id;
  ItemMainGroupModel({this.imageUrl,this.title,this.id});

  factory ItemMainGroupModel.fromJson(Map<String, dynamic> json) {
    return ItemMainGroupModel(
      id:json['id'],
      imageUrl: json['image'],
      title:json['etitle'],

    );
  }
}