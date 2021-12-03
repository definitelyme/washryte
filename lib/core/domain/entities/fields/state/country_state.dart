library country_state.dart;

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:washryte/core/domain/entities/entities.dart';

part 'country_state.freezed.dart';

@freezed
@immutable
class CountryState with _$CountryState {
  const CountryState._();

  const factory CountryState({
    required UniqueId<String?> id,
    required BasicTextField<String?> name,
    Country? country,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) = _ProvinceState;

  static List<CountryState> get dummies => [
        CountryState(
          id: UniqueId.fromExternal(null),
          name: BasicTextField('Lagos'),
        ),
        //
        CountryState(
          id: UniqueId.fromExternal(null),
          name: BasicTextField('Anambra'),
        ),
        //
        CountryState(
          id: UniqueId.fromExternal(null),
          name: BasicTextField('Enugu'),
        ),
        //
        CountryState(
          id: UniqueId.fromExternal(null),
          name: BasicTextField('Kogi'),
        ),
        //
        CountryState(
          id: UniqueId.fromExternal(null),
          name: BasicTextField('Rivers'),
        ),
      ];
}
