import 'dart:convert';

class OutfitModel {
  List<String> imageLinks;
  List<String> purchaseUrls;
  final String title;
  final String description;
  String? id, size, outfitType;
  int? color;
  List<String>? tags;

  OutfitModel({
    this.id,
    required this.imageLinks,
    required this.title,
    required this.purchaseUrls,
    required this.description,
    this.size,
    this.color,
    this.outfitType,
    this.tags,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'imageLinks': imageLinks,
      'title': title,
      'purchaseUrls': purchaseUrls,
      'description': description,
      'id': id,
      'size': size,
      'color': color,
      'outfitType': outfitType,
      'tags': tags,
    };
  }

  factory OutfitModel.fromMap(Map<String, dynamic> map) {
    List<String> urls = [];
    if (map['purchaseUrls'] != null) {
      urls = List<String>.from(map['purchaseUrls']);
    }
    return OutfitModel(
      id: map['id'],
      imageLinks: List<String>.from((map['imageLinks'])),
      title: map['title'],
      purchaseUrls: urls,
      description: map['description'],
      size: map['size'],
      color: map['color'],
      outfitType: map['outfitType'],
      tags: List<String>.from(map['tags'] ?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory OutfitModel.fromJson(String source) =>
      OutfitModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
