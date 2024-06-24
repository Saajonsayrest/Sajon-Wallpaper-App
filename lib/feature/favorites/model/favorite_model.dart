class FavoriteModel {
  int id;
  String imageUrl;
  bool isFavorite;

  FavoriteModel({
    required this.id,
    required this.imageUrl,
    this.isFavorite = false,
  });

  FavoriteModel copyWith({
    int? id,
    String? imageUrl,
    bool? isFavorite,
  }) {
    return FavoriteModel(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      id: json['id'],
      imageUrl: json['imageUrl'],
      isFavorite: json['isFavorite'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'isFavorite': isFavorite,
    };
  }
}
