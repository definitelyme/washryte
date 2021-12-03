import 'package:washryte/core/domain/entities/entities.dart';

enum MediaContentType {
  post,
  story,
  forum,
}

abstract class MediaDecorator {
  const MediaDecorator();

  UniqueId<String?> get id;
  MediaField get url;
  MediaField get video;
  MediaField get thumbnail;
  MediaContentType get contentType;
  DateTime? get createdAt;
  DateTime? get updatedAt;
}

extension MediaContentTypeX on MediaContentType {
  T? fold<T>({
    T Function()? post,
    T Function()? story,
    T Function()? forum,
  }) {
    switch (this) {
      case MediaContentType.post:
        return post?.call();
      case MediaContentType.story:
        return story?.call();
      case MediaContentType.forum:
        return forum?.call();
    }
  }
}
