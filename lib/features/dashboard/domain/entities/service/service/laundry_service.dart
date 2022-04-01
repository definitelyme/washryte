library laundry_service.dart;

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:washryte/core/domain/entities/entities.dart';

part 'laundry_service.freezed.dart';

@freezed
@immutable
class LaundryService with _$LaundryService {
  const LaundryService._();

  const factory LaundryService({
    required UniqueId<String?> id,
    required BasicTextField<String?> name,
    required AmountField<int> quantity,
    required AmountField<double> price,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _LaundryService;
}
