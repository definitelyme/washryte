library image_box.dart;

import 'dart:io';

import 'package:washryte/utils/utils.dart';
import 'package:washryte/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum _ImageType { asset, network, file }

/// A stateless widget to render ImageBox.
class ImageBox extends StatefulWidget {
  final double width;
  final double height;
  final BoxFit fit;
  final double elevation;
  final ShapeBorder? shape;
  final BorderRadius? borderRadius;
  final String? photo;
  final Widget replacement;
  final bool applyConstraintToReplacement;
  final _ImageType _type;

  const ImageBox.network({
    Key? key,
    this.width = double.infinity,
    this.height = double.infinity,
    this.fit = BoxFit.cover,
    required this.photo,
    this.elevation = 0.0,
    this.shape,
    this.borderRadius,
    this.replacement = Utils.nothing,
    this.applyConstraintToReplacement = false,
  })  : _type = _ImageType.network,
        super(key: key);

  const ImageBox.asset({
    Key? key,
    this.width = double.infinity,
    this.height = double.infinity,
    this.fit = BoxFit.cover,
    required this.photo,
    this.elevation = 0.0,
    this.shape,
    this.borderRadius,
    this.replacement = Utils.nothing,
    this.applyConstraintToReplacement = false,
  })  : _type = _ImageType.asset,
        super(key: key);

  const ImageBox.file({
    Key? key,
    this.width = double.infinity,
    this.height = double.infinity,
    this.fit = BoxFit.cover,
    required this.photo,
    this.elevation = 0.0,
    this.shape,
    this.borderRadius,
    this.replacement = Utils.nothing,
    this.applyConstraintToReplacement = false,
  })  : _type = _ImageType.file,
        super(key: key);

  @override
  State<ImageBox> createState() => _ImageBoxState();
}

class _ImageBoxState extends State<ImageBox> with AutomaticKeepAliveClientMixin<ImageBox> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ClipRRect(
      borderRadius: widget.borderRadius ?? BorderRadius.circular(8.0),
      child: Material(
        // shape: widget.shape,
        type: MaterialType.transparency,
        borderRadius: widget.borderRadius,
        elevation: 0.0,
        child: widget.photo?.let(
              (it) => widget._type.when(
                asset: Image.asset(
                  it,
                  width: widget.width,
                  height: widget.height,
                  fit: widget.fit,
                ),
                file: Image.file(
                  File(it),
                  width: widget.width,
                  height: widget.height,
                  fit: widget.fit,
                ),
                network: CachedNetworkImage(
                  imageUrl: it,
                  fit: widget.fit,
                  width: widget.width,
                  height: widget.height,
                  progressIndicatorBuilder: (_, url, download) => ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: widget.width,
                      maxHeight: widget.height,
                    ),
                    child: Center(
                      child: CircularProgressBar.adaptive(
                        value: download.progress,
                        strokeWidth: 2,
                        width: 25,
                        height: 25,
                      ),
                    ),
                  ),
                  errorWidget: (_, url, error) => widget.applyConstraintToReplacement
                      ? ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: widget.width,
                            maxHeight: widget.height,
                          ),
                          child: widget.replacement,
                        )
                      : widget.replacement,
                ),
              ),
            ) ??
            (widget.applyConstraintToReplacement
                ? ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: widget.width,
                      maxHeight: widget.height,
                    ),
                    child: widget.replacement,
                  )
                : widget.replacement),
      ),
    );
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
