// ignore_for_file: unused_local_variable

import 'package:washryte/core/domain/entities/entities.dart';
import 'package:washryte/core/presentation/managers/managers.dart';
import 'package:washryte/features/dashboard/domain/entities/index.dart';
import 'package:washryte/utils/utils.dart';
import 'package:washryte/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StreetSearchDelegate extends MaterialFullSearch<PlacePrediction?> {
  late List<PlacePrediction?> _items;

  void Function(PlacePrediction?) onSelected;
  final BaseAddressCubit _cubit;
  String? language;
  double? latitude;
  double? longitude;
  double? radius;
  // Generate new session tokens here
  String sessionToken = UniqueId<String>.v4().value!;

  StreetSearchDelegate({
    this.language = 'en',
    this.radius,
    String? label = 'Start typing..',
    double? longitude,
    double? latitude,
    ThemeData? theme,
    required this.onSelected,
    required BaseAddressCubit cubit,
    bool itemStartsWith = true,
    bool itemEndsWith = false,
  })  : _cubit = cubit,
        super(
          hint: const Center(
            child: Text('Enter street, road, state or country'),
          ),
          failure: BlocProvider.value(
            value: cubit,
            child: BlocBuilder<BaseAddressCubit, BaseAddressState>(
              builder: (_, s) => Center(
                child: Visibility(
                  visible: !s.isLoading,
                  replacement: CircularProgressBar.adaptive(
                    width: 0.08.sw,
                    height: 0.08.sw,
                    strokeWidth: 2.5,
                  ),
                  child: const Text(
                    'No result found!',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ),
          searchLabel: label,
          theme: theme,
          builder: (item) => const SizedBox.shrink(),
          filter: (item) => [item?.description.getOrNull],
          items: const [],
          recentSearches: const [],
          showItemsOnEmpty: false,
          itemStartsWith: itemStartsWith,
          itemEndsWith: itemEndsWith,
        );

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const BackButtonIcon(),
      onPressed: () => close(
        context,
        items.isNotEmpty ? _items[0] : PlacePrediction.fromQuery(query),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final _clean = query.toLowerCase().trim();

    if (_clean.isNotEmpty) _cubit.autocomplete(query, token: sessionToken);

    return BlocProvider.value(
      value: _cubit,
      child: BlocBuilder<BaseAddressCubit, BaseAddressState>(
        builder: (c, s) {
          _items = s.predictions.iter
              .where(
                // First we collect all [String] representation of each [item]
                (item) => filter(item)
                    // Then, transforms all results to lower case letters
                    .map((value) => value?.toLowerCase().trim())
                    // Finally, checks whether any coincide with the cleaned query
                    // Checks whether the [startsWith] or [endsWith] are 'true'
                    .any((value) => value?.contains(_clean) == true),
              )
              .toList();

          return _clean.isEmpty && !showItemsOnEmpty
              ? recentSearches.isEmpty
                  ? hint
                  : ListView.custom(
                      shrinkWrap: true,
                      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                      childrenDelegate: SliverChildBuilderDelegate(
                        (_, i) => _itemBuilder(_, i, _items),
                        childCount: recentSearches.length,
                      ),
                    )
              : _items.isEmpty
                  ? failure
                  : ListView.custom(
                      shrinkWrap: true,
                      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                      childrenDelegate: SliverChildBuilderDelegate(
                        (_, i) => _itemBuilder(_, i, _items),
                        childCount: _items.length,
                      ),
                    );
        },
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index, List<PlacePrediction?> results) {
    final prediction = results.elementAt(index);
    String? startChars = '';
    String? endChars = '';

    try {
      startChars = prediction?.description.getOrEmpty?.substring(0, query.length);
      endChars = prediction?.description.getOrEmpty?.substring(query.length);
    } on RangeError catch (_) {
      startChars = prediction?.description.getOrEmpty;
      endChars = '';
    }

    return AdaptiveListTile(
      dense: true,
      leading: SizedBox(
        height: 0.02.sw,
        width: 0.01.sw,
        child: Icon(
          Theme.of(context).platform.fold(
                material: () => Icons.location_searching,
                cupertino: () => CupertinoIcons.location_fill,
              ),
        ),
      ),
      title: AdaptiveText.rich(
        TextSpan(text: '${prediction?.description.getOrEmpty}'),
        softWrap: true,
        style: TextStyle(fontSize: 16.sp),
      ),
      onTap: () {
        onSelected(prediction);

        close(
          context,
          _items.isNotEmpty ? _items[0] : PlacePrediction.fromQuery(query),
        );
      },
    );
  }
}
