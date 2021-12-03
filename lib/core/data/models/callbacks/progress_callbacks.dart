typedef AwaitCallback = void Function(bool);

abstract class BaseProgressAdapter {
  /// Final size of the download. If count is unknown this will be null.
  final int? count;

  /// Total of currently downloaded bytes.
  final int downloaded;

  /// download progress as an double between 0 and 1.
  /// When the final size is unknown or the downloaded size exceeds the total
  /// size [progress] is null.
  double? get progress;

  bool get isDone;

  void listen(AwaitCallback it);

  BaseProgressAdapter(this.count, this.downloaded);
}

class SendProgressCallback extends BaseProgressAdapter {
  SendProgressCallback(int? count, int downloaded) : super(count, downloaded);

  @override
  double? get progress {
    if (count == null || downloaded > count!) return null;
    return downloaded / count!;
  }

  @override
  bool get isDone => progress == 1;

  @override
  void listen(AwaitCallback it) {
    if (isDone) return it(true);
    it(false);
  }
}

class ReceiveProgressCallback extends BaseProgressAdapter {
  ReceiveProgressCallback(int? count, int downloaded)
      : super(count, downloaded);

  @override
  double? get progress {
    if (count == null || downloaded > count!) return null;
    return downloaded / count!;
  }

  @override
  bool get isDone => progress == 1;

  @override
  void listen(AwaitCallback it) {
    if (isDone) return it(true);
    it(false);
  }
}
