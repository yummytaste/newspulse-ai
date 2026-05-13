class FirebaseShortModel {
  final String id;
  final String title;
  final String description;
  final String category;
  final String videoUrl;
  final String thumbnailUrl;

  final int views;
  final int likes;
  final int shares;

  final bool isActive;

  FirebaseShortModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.views,
    required this.likes,
    required this.shares,
    required this.isActive,
  });

  factory FirebaseShortModel.fromMap(
      String id,
      Map<String, dynamic> map,
      ) {
    return FirebaseShortModel(
      id: id,

      title: map['title'] ?? '',

      description:
      map['description'] ?? '',

      category: map['category'] ?? '',

      videoUrl: map['videoUrl'] ?? '',

      thumbnailUrl:
      map['thumbnailUrl'] ?? '',

      views: map['views'] ?? 0,

      likes: map['likes'] ?? 0,

      shares: map['shares'] ?? 0,

      isActive:
      map['isActive'] ?? true,
    );
  }
}