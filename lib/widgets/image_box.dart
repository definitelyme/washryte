library image_box.dart;

import 'dart:io';

import 'package:washryte/core/domain/entities/entities.dart';
import 'package:washryte/utils/utils.dart';
import 'package:washryte/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

enum _ImageType { asset, network, file }

/// A stateless widget to render ImageBox.
class ImageBox extends StatefulWidget {
  final _ImageType _type;

  final Object? heroTag;
  final bool applyConstraintToReplacement;
  final BoxBorder? border;
  final BorderRadius? borderRadius;
  final double elevation;
  final BoxFit fit;
  final double height;
  final String? photo;
  final Widget replacement;
  final String? replacementAsset;
  final bool useDefaultRadius;
  final double width;
  final bool expandsFullscreen;
  final List<Widget> Function(Widget)? stackChildren;
  final AlignmentGeometry stackAlignment;
  final StackFit stackFit;
  final Clip stackClip;
  final void Function(ImageProvider?)? onPressed;

  const ImageBox.asset({
    Key? key,
    this.heroTag,
    this.width = double.infinity,
    this.height = double.infinity,
    this.fit = BoxFit.cover,
    required this.photo,
    this.elevation = 0.0,
    this.border,
    this.borderRadius,
    this.replacement = Utils.nothing,
    this.applyConstraintToReplacement = true,
    this.useDefaultRadius = true,
    this.expandsFullscreen = false,
    this.stackChildren,
    this.stackAlignment = AlignmentDirectional.topStart,
    this.stackFit = StackFit.loose,
    this.stackClip = Clip.hardEdge,
    this.onPressed,
  })  : _type = _ImageType.asset,
        replacementAsset = null,
        super(key: key);

  const ImageBox.file({
    Key? key,
    this.heroTag,
    this.width = double.infinity,
    this.height = double.infinity,
    this.fit = BoxFit.cover,
    required this.photo,
    this.elevation = 0.0,
    this.border,
    this.borderRadius,
    this.replacement = Utils.nothing,
    this.replacementAsset,
    this.applyConstraintToReplacement = true,
    this.useDefaultRadius = true,
    this.expandsFullscreen = false,
    this.stackChildren,
    this.stackAlignment = AlignmentDirectional.topStart,
    this.stackFit = StackFit.loose,
    this.stackClip = Clip.hardEdge,
    this.onPressed,
  })  : _type = _ImageType.file,
        super(key: key);

  const ImageBox.network({
    Key? key,
    this.heroTag,
    this.width = double.infinity,
    this.height = double.infinity,
    this.fit = BoxFit.cover,
    required this.photo,
    this.elevation = 0.0,
    this.border,
    this.borderRadius,
    this.replacement = Utils.nothing,
    this.replacementAsset,
    this.applyConstraintToReplacement = true,
    this.useDefaultRadius = true,
    this.expandsFullscreen = false,
    this.stackChildren,
    this.stackAlignment = AlignmentDirectional.topStart,
    this.stackFit = StackFit.loose,
    this.stackClip = Clip.hardEdge,
    this.onPressed,
  })  : _type = _ImageType.network,
        super(key: key);

  ImageProvider get provider => _type.when(
        asset: AssetImage('$photo'),
        network: CachedNetworkImageProvider(
          '$photo',
          maxHeight: (height == double.infinity ? 1.w : height).toInt(),
          maxWidth: (width == double.infinity ? 1.w : width).toInt(),
        ),
        file: FileImage(File('$photo')),
      );

  @override
  State<ImageBox> createState() => _ImageBoxState();
}

class _ImageBoxState extends State<ImageBox> with AutomaticKeepAliveClientMixin<ImageBox> {
  @override
  bool get wantKeepAlive => true;

  Widget _image(ImageProvider provider) => Image(
        width: widget.width,
        height: widget.height,
        image: provider,
        fit: widget.fit,
        isAntiAlias: true,
      );

  ImageProvider? get _provider => widget.photo?.let((it) => widget._type.when(
        asset: AssetImage(it),
        file: FileImage(File(it)),
        network: CachedNetworkImageProvider(
          it,
          maxHeight: widget.height == double.infinity ? null : widget.height.ceil(),
          maxWidth: widget.width == double.infinity ? null : widget.width.ceil(),
        ),
      ));

  BoxConstraints get constraints => BoxConstraints(maxWidth: widget.width, maxHeight: widget.height);

  Widget get replacement =>
      widget.replacementAsset?.let((it) => _imageBuilder(_provider!)) ??
      (widget.applyConstraintToReplacement ? ConstrainedBox(constraints: constraints, child: widget.replacement) : widget.replacement);

  Object? get _heroTag => widget.heroTag ?? UniqueId.v4().value;

  Widget _imageBuilder(ImageProvider provider) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(borderRadius: widget.borderRadius, border: widget.border),
      child: ClipRRect(
        borderRadius: widget.borderRadius ?? (widget.useDefaultRadius ? 8.br : null),
        clipBehavior: Clip.hardEdge,
        child: MyHero(
          tag: _heroTag,
          borderRadius: widget.borderRadius,
          type: MaterialType.transparency,
          elevation: widget.elevation,
          child: AdaptiveInkWell(
            onTap: widget.expandsFullscreen
                ? () => navigator.pushWidget(AdaptiveFullscreen(
                      heroTag: _heroTag,
                      minScale: 0.1,
                      imageProvider: provider,
                    ))
                : () => widget.onPressed?.call(provider),
            child: widget.stackChildren != null
                ? Stack(
                    alignment: widget.stackAlignment,
                    clipBehavior: widget.stackClip,
                    fit: widget.stackFit,
                    children: widget.stackChildren!.call(_image(provider)),
                  )
                : _image(provider),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return widget.photo?.let(
          (it) => widget._type.when(
            asset: _imageBuilder(_provider!),
            file: _imageBuilder(_provider!),
            network: CachedNetworkImage(
              imageUrl: it,
              fit: widget.fit,
              width: widget.width,
              height: widget.height,
              imageBuilder: (c, provider) => _imageBuilder(provider),
              errorWidget: (_, url, error) => replacement,
              progressIndicatorBuilder: (_, url, d) => ConstrainedBox(
                constraints: constraints,
                child: Center(
                  child: CircularProgressBar.adaptive(
                    value: d.progress,
                    strokeWidth: 2,
                    width: 25,
                    height: 25,
                  ),
                ),
              ),
            ),
          ),
        ) ??
        (widget.applyConstraintToReplacement ? ConstrainedBox(constraints: constraints, child: replacement) : replacement);
  }
}

extension on _ImageType {
  T when<T>({
    required T asset,
    required T network,
    required T file,
  }) {
    switch (this) {
      case _ImageType.asset:
        return asset;
      case _ImageType.network:
        return network;
      case _ImageType.file:
        return file;
    }
  }
}
