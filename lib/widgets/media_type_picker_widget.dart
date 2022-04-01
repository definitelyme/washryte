library media_type_picker_widget.dart;

import 'package:flutter/material.dart';
import 'package:washryte/features/dashboard/presentation/widgets/index.dart';
import 'package:washryte/utils/utils.dart';
import 'package:washryte/widgets/widgets.dart';

enum SelectableMediaType { audio, image, document, video }

/// A stateless widget to render MediaTypePickerWidget.
class MediaTypePickerWidget extends StatelessWidget {
  final List<MediaTypePicker> pickers;
  final void Function(SelectableMediaType)? onCameraPressed;
  final void Function(SelectableMediaType)? onGalleryPressed;

  const MediaTypePickerWidget({
    Key? key,
    this.pickers = const [],
    this.onCameraPressed,
    this.onGalleryPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      clipBehavior: Clip.antiAlias,
      controller: ScrollController(),
      physics: Utils.physics,
      scrollDirection: Axis.vertical,
      padding: MediaQuery.of(context).viewInsets,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          VerticalSpace(height: 0.04.sw),
          //
          ClipRRect(
            borderRadius: BorderRadius.circular(Utils.cardRadius),
            child: DecoratedBox(
              decoration: const BoxDecoration(color: Colors.grey),
              child: SizedBox(height: 0.015.sw, width: 0.2.sw),
            ),
          ),
          //
          VerticalSpace(height: 0.02.h),
          //
          Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.spaceAround,
            spacing: 0.07.w,
            runAlignment: WrapAlignment.start,
            runSpacing: 0.013.h,
            children: [
              if (pickers.isNotEmpty) ...pickers.map((e) => _Builder(picker: e)).toList(),
              if (pickers.isEmpty)
                ...MediaTypePicker.defaults
                    .map((e) => _Builder(
                        picker: e,
                        onSelected: (type) {
                          navigator.pop().then((_) => openChoiceBottomsheet(context, type));
                        }))
                    .toList(),
            ],
          ),
          //
          VerticalSpace(height: 0.03.h),
        ],
      ),
    );
  }

  void openChoiceBottomsheet(BuildContext ctx, SelectableMediaType type) async {
    await App.showAdaptiveBottomSheet(
      ctx,
      radius: Radius.zero,
      elevation: 0,
      enableDrag: true,
      bounce: true,
      builder: (_) => DocumentPickerSheet(
        pickers: [
          DocumentPicker(
            name: 'Camera',
            asset: Utils.foldTheme(
              light: () => AppAssets.cameraColored,
              dark: () => AppAssets.cameraOutlined,
            ),
            onPressed: () => onCameraPressed?.call(type),
          ),
          //
          DocumentPicker(
            name: 'Gallery',
            asset: Utils.foldTheme(
              light: () => AppAssets.galleryColored,
              dark: () => AppAssets.galleryOutlined,
            ),
            onPressed: () => onGalleryPressed?.call(type),
          ),
        ],
      ),
    );
  }
}

class _Builder extends StatelessWidget {
  final MediaTypePicker picker;
  final void Function(SelectableMediaType)? onSelected;

  const _Builder({
    Key? key,
    required this.picker,
    this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          borderRadius: BorderRadius.circular(picker.radius),
          color: picker.backgroundColor,
          child: InkWell(
            borderRadius: BorderRadius.circular(picker.radius),
            onTap: () {
              if (picker.onPressed != null) picker.onPressed?.call(picker.type);
              if (onSelected != null) onSelected?.call(picker.type);
            },
            child: Padding(
              padding: EdgeInsets.all(picker.iconPadding),
              child: picker.icon,
            ),
          ),
        ),
        //
        VerticalSpace(height: 0.007.h),
        //
        AdaptiveText(
          picker.name,
          fontSize: 15.sp,
          maxLines: 1,
          fontWeight: FontWeight.w500,
          softWrap: false,
          letterSpacing: Utils.letterSpacing,
        ),
      ],
    );
  }
}

class MediaTypePicker {
  const MediaTypePicker({
    required this.name,
    required this.icon,
    this.onPressed,
    this.backgroundColor = Palette.neutralF3,
    this.radius = Utils.cardRadius,
    this.iconPadding = 18.0,
    required this.type,
  });

  final String name;
  final Icon icon;
  final void Function(SelectableMediaType)? onPressed;
  final Color backgroundColor;
  final double radius;
  final double iconPadding;
  final SelectableMediaType type;

  static List<MediaTypePicker> get defaults => <MediaTypePicker>[
        // const MediaTypePicker(
        //   name: 'Audio',
        //   type: SelectableMediaType.audio,
        //   icon: Icon(
        //     Icons.audiotrack,
        //     color: Colors.amber,
        //     size: 27.0,
        //   ),
        // ),
        const MediaTypePicker(
          name: 'Photo',
          type: SelectableMediaType.image,
          icon: Icon(
            Icons.image,
            color: Palette.accentColor,
            size: 27.0,
          ),
        ),
        const MediaTypePicker(
          name: 'Video',
          type: SelectableMediaType.video,
          icon: Icon(
            Icons.videocam,
            color: Colors.red,
            size: 27.0,
          ),
        ),
      ];
}

extension SelectableMediaTypeX on SelectableMediaType {
  T when<T>({
    required T Function() audio,
    required T Function() image,
    required T Function() document,
    required T Function() video,
  }) {
    switch (this) {
      case SelectableMediaType.audio:
        return audio.call();
      case SelectableMediaType.image:
        return image.call();
      case SelectableMediaType.document:
        return document.call();
      case SelectableMediaType.video:
        return video.call();
    }
  }

  T maybeWhen<T>({
    T Function()? audio,
    T Function()? image,
    T Function()? document,
    T Function()? video,
    required T Function() orElse,
  }) {
    switch (this) {
      case SelectableMediaType.audio:
        return audio?.call() ?? orElse.call();
      case SelectableMediaType.image:
        return image?.call() ?? orElse.call();
      case SelectableMediaType.document:
        return document?.call() ?? orElse.call();
      case SelectableMediaType.video:
        return video?.call() ?? orElse.call();
    }
  }
}
