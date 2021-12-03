import 'package:washryte/utils/utils.dart';
import 'package:washryte/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DocumentPickerSheet extends StatelessWidget {
  final List<DocumentPicker> pickers;

  const DocumentPickerSheet({Key? key, this.pickers = const []}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: 0.17.sh,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...pickers.map(
              (p) => Flexible(
                child: AdaptiveListTile(
                  dense: true,
                  material: true,
                  contentPadding: EdgeInsets.zero,
                  title: InkWell(
                    onTap: () {
                      p.onPressed.call();
                      navigator.pop();
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.05.sw),
                      child: SizedBox(
                        height: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 4,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: p.asset ?? const SizedBox.shrink(),
                                  ),
                                  //
                                  HorizontalSpace(width: 0.04.sw),
                                  //
                                  Flexible(
                                    child: AdaptiveText(
                                      p.name,
                                      style: TextStyle(fontSize: 17.sp),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //
                            const Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            //
            VerticalSpace(height: 0.022.h),
          ],
        ),
      ),
    );
  }
}

class DocumentPicker {
  final String name;
  final Widget? asset;
  final VoidCallback onPressed;

  DocumentPicker({required this.name, this.asset, required this.onPressed});
}
