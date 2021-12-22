import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashPositionedLoader extends StatefulWidget {
  final Color? color;
  final Duration duration;
  final double size;

  const SplashPositionedLoader({
    Key? key,
    this.size = 34.0,
    this.color,
    this.duration = const Duration(milliseconds: 700),
  }) : super(key: key);

  @override
  _SplashPositionedLoaderState createState() => _SplashPositionedLoaderState();
}

class _SplashPositionedLoaderState extends State<SplashPositionedLoader>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin<SplashPositionedLoader> {
  late AnimationController _controller;
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SpinKitFadingCircle(
      color: widget.color ?? Theme.of(context).colorScheme.primary,
      size: widget.size,
      controller: _controller,
    );
  }
}
