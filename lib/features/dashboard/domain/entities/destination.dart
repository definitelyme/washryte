import 'package:flutter/widgets.dart';
import 'package:washryte/utils/utils.dart';

class Destination {
  final int id;
  final Widget asset;
  final String title;

  const Destination({
    required this.id,
    required this.title,
    required this.asset,
  });

  static List<Destination> get list => [
        Destination(id: 0, title: 'Home', asset: AppAssets.dashboardHome),
        //
        Destination(id: 1, title: 'Timeline', asset: AppAssets.dashboardTimeline),
        //
        Destination(id: 2, title: 'Notifications', asset: AppAssets.dashboardNotification),
        //
        Destination(id: 3, title: 'Profile', asset: AppAssets.dashboardHome),
      ];

  @override
  bool operator ==(o) {
    if (identical(this, o)) return true;
    return o is Destination && o.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Destination(id: $id, title: $title)';
}
