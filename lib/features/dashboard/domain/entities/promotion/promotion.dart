library promotion.dart;

import 'package:washryte/core/domain/entities/entities.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:washryte/features/dashboard/domain/entities/index.dart';
import 'package:washryte/utils/utils.dart';

part 'promotion.freezed.dart';

@freezed
@immutable
class Promotion extends MediaDecorator with _$Promotion {
  const Promotion._();

  const factory Promotion({
    required UniqueId<String?> id,
    required MediaField url,
    required AttachmentMime mime,
    required MediaField streamUrl,
    required BasicTextField<String?> description,
    DateTime? stopShowingAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Promotion;

  factory Promotion.blank() => Promotion(
        id: UniqueId.fromExternal(null),
        url: MediaField(null),
        mime: AttachmentMime.unknown,
        streamUrl: MediaField(null),
        description: BasicTextField(null),
      );

  static List<Promotion> get dummies => [
        Promotion(
          id: UniqueId.v4(),
          url: MediaField('${AppAssets.carouselImg1}'),
          mime: AttachmentMime.png,
          streamUrl: MediaField(null),
          description: BasicTextField('Get 15% off, on your first monthly wash'),
        ),
        Promotion(
          id: UniqueId.v4(),
          url: MediaField('${AppAssets.carouselImg2}'),
          mime: AttachmentMime.png,
          streamUrl: MediaField(null),
          description: BasicTextField('Our most popular wash'),
        ),
      ];
}
