import 'dart:convert';

class CatPhoto {
  final String id;
  final String url;

  const CatPhoto({
    required this.id,
    required this.url,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'url': url,
    };
  }

  static CatPhoto fromMap(Map<String, dynamic> map) {
    return CatPhoto(
      id: map['id'],
      url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());

  static CatPhoto fromJson(String source) =>
      fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CatPhoto(id: $id, url: $url)';
  }
}
