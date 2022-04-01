import 'package:washryte/utils/utils.dart';

class Destination {
  final int id;
  final String asset;
  final String title;

  const Destination({
    required this.id,
    required this.title,
    required this.asset,
  });

  static List<Destination> get list => const [
        Destination(id: 0, title: 'Home', asset: AppAssets.dashboardHomeAsset),
        //
        Destination(id: 1, title: 'Timeline', asset: AppAssets.dashboardTimelineAsset),
        //
        Destination(id: 2, title: 'Notifications', asset: AppAssets.dashboardNotificationAsset),
        //
        Destination(id: 3, title: 'Profile', asset: AppAssets.dashboardHomeAsset),
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
