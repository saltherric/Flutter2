import '../../model/comment/comment.dart';

class CommentDto {
  static const String messageKey = 'message';
  static const String createdAtKey = 'createdAt';

  static Comment fromJson(
    String id,
    String artistId,
    Map<String, dynamic> json,
  ) {
    assert(json[messageKey] is String);

    DateTime createdAt = DateTime.now();
    if (json[createdAtKey] is String) {
      createdAt = DateTime.tryParse(json[createdAtKey]) ?? DateTime.now();
    }

    return Comment(
      id: id,
      artistId: artistId,
      message: json[messageKey],
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toJson(Comment comment) {
    return {
      messageKey: comment.message,
      createdAtKey: comment.createdAt.toIso8601String(),
    };
  }
}
