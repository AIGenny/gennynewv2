import 'dart:convert';

class OutfitModel {
  List<String> imageLinks;
  final String title;
  final String purchaseUrl;
  final String description;
  String? id;

  OutfitModel({
    this.id,
    required this.imageLinks,
    required this.title,
    required this.purchaseUrl,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'imageLinks': imageLinks,
      'title': title,
      'purchaseUrl': purchaseUrl,
      'description': description,
      'id': id,
    };
  }

  factory OutfitModel.fromMap(Map<String, dynamic> map) {
    return OutfitModel(
      id: map['id'],
      imageLinks: map['imageLinks'],
      title: map['title'],
      purchaseUrl: map['purchaseUrl'],
      description: map['description'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OutfitModel.fromJson(String source) =>
      OutfitModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
