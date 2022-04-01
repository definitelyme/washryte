import 'package:flutter/cupertino.dart';
import 'package:kt_dart/collection.dart';
import 'package:washryte/utils/utils.dart';
import 'package:washryte/widgets/adaptive/adaptive.dart';
import 'package:flutter/material.dart';

class AdaptiveDropdown<Model> extends StatelessWidget {
  static const double kErrorHeightDiff = 21;
  static const EdgeInsetsGeometry kdropdownContentPadding = EdgeInsets.symmetric(vertical: 7.0, horizontal: 12.0);
  static const double kdropdownHeight = 46;

  final String? Function(Model?)? text;
  final Widget? Function(Model?)? child;
  final void Function(Model?) onChanged;
  final List<Widget> Function(BuildContext)? selectedItemBuilder;
  final bool alignedDropdown;
  final AlignmentDirectional alignment;
  final Color? backgroundColorDark;
  final Color? backgroundColorLight;
  final InputBorder? border;
  final BorderRadius? borderRadius;
  final Color? buttonColor;
  final ColorScheme? colorScheme;
  final EdgeInsetsGeometry? contentPadding;
  final InputDecoration? decoration;
  final double diameterRatio;
  final bool disabled;
  final String disabledHint;
  final Widget? disabledHintWidget;
  final Color? dropdownColor;
  final int elevation;
  final InputBorder? errorBorder;
  final String? errorText;
  final InputBorder? focusedErrorBorder;
  final double? height;
  final Color? highlightColor;
  final String hint;
  final Widget? hintWidget;
  final Color? iconDisabledColor;
  final Color? iconEnabledColor;
  final double iconSize;
  final bool isDense;
  final bool isExpanded;
  final double? itemFontSize;
  final FontWeight? itemFontWeight;
  final List<Model> items;
  //
  final int maxLines;
  final double? menuMaxHeight;
  final double minFontSize;
  final double maxFontSize;
  final double offAxisFraction;
  final double? radius;
  final Model selected;
  final bool looping;
  final double magnification;
  final Widget? selectionOverlay;
  final ShapeBorder? shape;
  final Color? splashColor;
  final bool useMagnifier;
  final bool validate;
  final double? pickerHeight;
  final PlatformType? platform;

  const AdaptiveDropdown({
    Key? key,
    this.radius,
    required this.items,
    this.text,
    this.child,
    this.hint = '-- Choose --',
    this.hintWidget,
    this.disabledHint = '-- Invalid selection --',
    this.disabledHintWidget,
    required this.selected,
    this.validate = false,
    this.errorText,
    this.disabled = false,
    this.iconSize = 19.0,
    this.isDense = false,
    this.isExpanded = true,
    this.alignedDropdown = false,
    required this.onChanged,
    this.maxLines = 1,
    this.minFontSize = 12,
    this.maxFontSize = double.infinity,
    this.buttonColor,
    this.itemFontSize,
    this.itemFontWeight,
    this.highlightColor,
    this.backgroundColorLight,
    this.backgroundColorDark,
    this.colorScheme,
    this.splashColor,
    this.border,
    this.errorBorder,
    this.focusedErrorBorder,
    this.shape,
    this.contentPadding,
    this.alignment = AlignmentDirectional.centerStart,
    this.borderRadius,
    this.elevation = 8,
    this.dropdownColor,
    this.height,
    this.iconDisabledColor,
    this.iconEnabledColor,
    this.menuMaxHeight,
    this.decoration,
    this.selectedItemBuilder,
    this.pickerHeight,
    this.magnification = 1.0,
    this.looping = false,
    this.useMagnifier = true,
    this.diameterRatio = 1.07,
    this.offAxisFraction = 0.0,
    this.selectionOverlay = const CupertinoPickerDefaultSelectionOverlay(),
    this.platform,
  }) : super(key: key);

  double get _height => validate && !errorText.isNullOrBlank && !App.platform.isIOS
      ? height != null
          ? height! + AdaptiveDropdown.kErrorHeightDiff
          : AdaptiveDropdown.kdropdownHeight + AdaptiveDropdown.kErrorHeightDiff
      : height ?? AdaptiveDropdown.kdropdownHeight;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: disabled,
      child: PlatformBuilder(
        platform: platform,
        material: (_) => _MaterialDropdown(
          child: child,
          hint: hint,
          hintWidget: hintWidget,
          disabledHint: disabledHint,
          disabledHintWidget: disabledHintWidget,
          text: text,
          items: items,
          selected: selected,
          onChanged: onChanged,
          disabled: disabled,
          iconSize: iconSize,
          isDense: isDense,
          isExpanded: isExpanded,
          alignedDropdown: alignedDropdown,
          buttonColor: buttonColor,
          itemFontSize: itemFontSize,
          itemFontWeight: itemFontWeight,
          highlightColor: highlightColor,
          backgroundColorLight: backgroundColorLight,
          backgroundColorDark: backgroundColorDark,
          colorScheme: colorScheme,
          splashColor: splashColor,
          border: border,
          errorBorder: errorBorder,
          focusedErrorBorder: focusedErrorBorder,
          shape: shape,
          contentPadding: contentPadding,
          alignment: alignment,
          borderRadius: borderRadius,
          elevation: elevation,
          dropdownColor: dropdownColor,
          height: height,
          iconDisabledColor: iconDisabledColor,
          iconEnabledColor: iconEnabledColor,
          menuMaxHeight: menuMaxHeight,
          decoration: decoration,
          selectedItemBuilder: selectedItemBuilder,
          magnification: magnification,
          looping: looping,
          useMagnifier: useMagnifier,
          diameterRatio: diameterRatio,
          offAxisFraction: offAxisFraction,
          selectionOverlay: selectionOverlay,
          errorText: errorText,
          maxLines: maxLines,
          minFontSize: minFontSize,
          maxFontSize: maxFontSize,
          radius: radius,
          validate: validate,
        ),
        cupertino: (_) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: _height),
                child: Row(
                  children: [
                    if (decoration?.prefixIcon != null) decoration!.prefixIcon!,
                    //
                    Flexible(
                      child: Material(
                        color: App.resolveColor(CupertinoColors.lightBackgroundGray, dark: Palette.cardColorDark),
                        shape: shape ??
                            RoundedRectangleBorder(
                              side: BorderSide(
                                color: Utils.foldTheme(
                                  light: () => backgroundColorLight ?? Palette.inputBgColor,
                                  dark: () => backgroundColorDark ?? backgroundColorLight ?? Palette.secondaryColor.shade400,
                                ),
                              ),
                              borderRadius: borderRadius ?? BorderRadius.circular(radius ?? Utils.inputBorderRadius),
                            ),
                        child: AdaptiveInkWell(
                          onTap: () async {
                            if (disabled) return;
                            //
                            final result = await App.showAdaptiveBottomSheet<Model?>(
                              context,
                              bounce: true,
                              // isDismissible: false,
                              useRootNavigator: false,
                              builder: (context) => _CupertinoPicker(
                                items: items,
                                selected: selected,
                                itemFontSize: itemFontSize,
                                itemFontWeight: itemFontWeight,
                                maxLines: maxLines,
                                minFontSize: minFontSize,
                                maxFontSize: maxFontSize,
                                useMagnifier: useMagnifier,
                                magnification: magnification,
                                diameterRatio: diameterRatio,
                                offAxisFraction: offAxisFraction,
                                looping: looping,
                                selectionOverlay: selectionOverlay,
                                backgroundColorLight: backgroundColorLight,
                                backgroundColorDark: backgroundColorDark,
                                onSelectedChanged: onChanged,
                                height: pickerHeight,
                                text: text,
                                child: child,
                              ),
                            );
                            //
                            if (result != null) onChanged(result);
                          },
                          borderRadius: Utils.inputBorderRadius.br,
                          containedInkWell: true,
                          highlightColor: App.resolveColor(
                            CupertinoColors.lightBackgroundGray,
                            dark: CupertinoColors.darkBackgroundGray,
                          ),
                          child: DropdownMenuItem<Model?>(
                            value: selected,
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: contentPadding?.let(
                                    (it) => AdaptiveDropdown.kdropdownContentPadding.add(it),
                                  ) ??
                                  AdaptiveDropdown.kdropdownContentPadding,
                              child: child?.call(selected) ??
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: AdaptiveText(
                                          selected != null ? '${text?.call(selected) ?? "- Please set 'text' property -"}' : '-- Choose --',
                                          maxLines: maxLines,
                                          minFontSize: minFontSize,
                                          maxFontSize: maxFontSize,
                                          softWrap: false,
                                          wrapWords: false,
                                          fontSize: itemFontSize ?? 16.sp,
                                          fontWeight: itemFontWeight,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      //
                                      Icon(
                                        CupertinoIcons.chevron_down,
                                        size: 20,
                                        color: CupertinoDynamicColor.resolve(
                                          Utils.foldTheme(light: () => Palette.iconLight, dark: () => Palette.iconDark),
                                          context,
                                        ),
                                      ),
                                    ],
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //
            if (errorText != null && validate)
              AdaptiveText(
                '$errorText',
                maxLines: 1,
                softWrap: false,
                wrapWords: false,
                minFontSize: 14,
                fontSize: 16.sp,
                textColor: Palette.errorRed,
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
      ),
    );
  }
}

class _CupertinoPicker<Model> extends StatefulWidget {
  final String? Function(Model)? text;
  final Color? backgroundColorDark;
  final Color? backgroundColorLight;
  final double diameterRatio;
  final double? itemFontSize;
  final FontWeight? itemFontWeight;
  final List<Model> items;
  final bool looping;
  final double magnification;
  final int maxLines;
  final double minFontSize;
  final double maxFontSize;
  final double offAxisFraction;
  final ValueChanged<Model>? onSelectedChanged;
  final Model selected;
  final Widget? selectionOverlay;
  final bool useMagnifier;
  final Widget? Function(Model)? child;
  final double? height;

  const _CupertinoPicker({
    Key? key,
    required this.items,
    required this.selected,
    this.height,
    this.onSelectedChanged,
    this.magnification = 1.0,
    this.looping = false,
    this.useMagnifier = true,
    this.diameterRatio = 1.07,
    this.offAxisFraction = 0.0,
    this.selectionOverlay = const CupertinoPickerDefaultSelectionOverlay(),
    this.backgroundColorDark,
    this.backgroundColorLight,
    this.maxLines = 1,
    this.minFontSize = 12,
    this.maxFontSize = double.infinity,
    this.itemFontSize,
    this.itemFontWeight,
    this.text,
    this.child,
  }) : super(key: key);

  @override
  State<_CupertinoPicker<Model>> createState() => _CupertinoPickerState<Model>();
}

class _CupertinoPickerState<Model> extends State<_CupertinoPicker<Model>> {
  late int _selectedItemIndex;

  late FixedExtentScrollController scrollController;

  double get _height => widget.height ?? 0.3.h;

  @override
  void initState() {
    scrollController = FixedExtentScrollController(initialItem: widget.selected != null ? widget.items.indexOf(widget.selected!) : 0);
    _selectedItemIndex = widget.items.indexOf(widget.selected ?? widget.items[0]);
    super.initState();
  }

  Color get _backgroundLight => widget.backgroundColorLight ?? CupertinoColors.lightBackgroundGray;

  Color get _backgroundDark => widget.backgroundColorDark ?? CupertinoColors.darkBackgroundGray;

  double get fontSize => widget.itemFontSize ?? 16.sp;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      child: Stack(
        children: [
          CupertinoPicker(
            scrollController: scrollController,
            itemExtent: kMinInteractiveDimensionCupertino,
            backgroundColor: App.resolveColor(_backgroundLight, dark: _backgroundDark),
            magnification: widget.magnification,
            looping: widget.looping,
            useMagnifier: widget.useMagnifier,
            diameterRatio: widget.diameterRatio,
            offAxisFraction: widget.offAxisFraction,
            selectionOverlay: widget.selectionOverlay,
            onSelectedItemChanged: (index) => setState(() => _selectedItemIndex = index),
            children: widget.items
                .toImmutableList()
                .mapIndexed((i, item) =>
                    widget.child?.call(item) ??
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: App.sidePadding),
                        child: AdaptiveText(
                          '${widget.text?.call(item) ?? "- Please set 'text' property -"}',
                          maxLines: widget.maxLines,
                          minFontSize: widget.minFontSize,
                          overflow: TextOverflow.ellipsis,
                          softWrap: widget.maxLines != 1,
                          wrapWords: widget.maxLines != 1,
                          fontSize: i == _selectedItemIndex ? fontSize + 2 : fontSize,
                          fontWeight: i == _selectedItemIndex ? FontWeight.w600 : widget.itemFontWeight,
                        ),
                      ),
                    ))
                .asList(),
          ),
          //
          Positioned(
            top: 0,
            right: 0,
            child: CupertinoButton(
              borderRadius: 8.br,
              onPressed: () => navigator.pop(widget.items[_selectedItemIndex]),
              child: AdaptiveText(
                'Done',
                maxLines: 1,
                fontSize: 17.sp,
                fontWeight: FontWeight.bold,
                textColor: Palette.accentColor,
                textColorDark: Palette.accentColor,
                letterSpacing: Utils.letterSpacing,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MaterialDropdown<Model> extends StatelessWidget {
  final String? Function(Model?)? text;
  final Widget? Function(Model?)? child;
  final void Function(Model?) onChanged;
  final List<Widget> Function(BuildContext)? selectedItemBuilder;
  final bool alignedDropdown;
  final AlignmentDirectional alignment;
  final Color? backgroundColorDark;
  final Color? backgroundColorLight;
  final InputBorder? border;
  final BorderRadius? borderRadius;
  final Color? buttonColor;
  final ColorScheme? colorScheme;
  final EdgeInsetsGeometry? contentPadding;
  final InputDecoration? decoration;
  final double diameterRatio;
  final bool disabled;
  final String disabledHint;
  final Widget? disabledHintWidget;
  final Color? dropdownColor;
  final int elevation;
  final InputBorder? errorBorder;
  final String? errorText;
  final InputBorder? focusedErrorBorder;
  final double? height;
  final Color? highlightColor;
  final String hint;
  final Widget? hintWidget;
  final Color? iconDisabledColor;
  final Color? iconEnabledColor;
  final double iconSize;
  final bool isDense;
  final bool isExpanded;
  final double? itemFontSize;
  final FontWeight? itemFontWeight;
  final List<Model> items;
  final bool looping;
  //
  final double magnification;

  final int maxLines;
  final double? menuMaxHeight;
  final double minFontSize;
  final double maxFontSize;
  final double offAxisFraction;
  final double? radius;
  final Model selected;
  final Widget? selectionOverlay;
  final ShapeBorder? shape;
  final Color? splashColor;
  final bool useMagnifier;
  final bool validate;

  const _MaterialDropdown({
    Key? key,
    this.radius,
    required this.items,
    this.text,
    this.child,
    this.hint = '-- Choose --',
    this.hintWidget,
    this.disabledHint = '-- Invalid selection --',
    this.disabledHintWidget,
    required this.selected,
    this.validate = false,
    this.errorText,
    this.disabled = false,
    this.iconSize = 19.0,
    this.isDense = false,
    this.isExpanded = true,
    this.alignedDropdown = false,
    required this.onChanged,
    this.maxLines = 1,
    this.minFontSize = 12,
    this.maxFontSize = double.infinity,
    this.buttonColor,
    this.itemFontSize,
    this.itemFontWeight,
    this.highlightColor,
    this.backgroundColorLight,
    this.backgroundColorDark,
    this.colorScheme,
    this.splashColor,
    this.border,
    this.errorBorder,
    this.focusedErrorBorder,
    this.shape,
    this.contentPadding,
    this.alignment = AlignmentDirectional.centerStart,
    this.borderRadius,
    this.elevation = 8,
    this.dropdownColor,
    this.height,
    this.iconDisabledColor,
    this.iconEnabledColor,
    this.menuMaxHeight,
    this.decoration,
    this.selectedItemBuilder,
    this.magnification = 1.0,
    this.looping = false,
    this.useMagnifier = true,
    this.diameterRatio = 1.07,
    this.offAxisFraction = 0.0,
    this.selectionOverlay = const CupertinoPickerDefaultSelectionOverlay(),
  }) : super(key: key);

  // bool get _showErrors => validate == true && !errorText.isNullOrBlank;
  double get _height => validate && !errorText.isNullOrBlank
      ? height != null
          ? height! + AdaptiveDropdown.kErrorHeightDiff
          : AdaptiveDropdown.kdropdownHeight + AdaptiveDropdown.kErrorHeightDiff
      : height ?? AdaptiveDropdown.kdropdownHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: alignedDropdown,
          layoutBehavior: ButtonBarLayoutBehavior.constrained,
          materialTapTargetSize: MaterialTapTargetSize.padded,
          buttonColor: buttonColor,
          highlightColor: highlightColor,
          splashColor: splashColor,
          colorScheme: colorScheme,
          shape: shape ??
              RoundedRectangleBorder(
                side: BorderSide(
                  color: Utils.foldTheme(
                    light: () => backgroundColorLight ?? Palette.inputBgColor,
                    dark: () => backgroundColorDark ?? Palette.cardColorDark,
                  ),
                ),
                borderRadius: borderRadius ?? BorderRadius.circular(radius ?? Utils.inputBorderRadius),
              ),
          child: DropdownButtonFormField<Model?>(
            autovalidateMode: validate ? AutovalidateMode.always : AutovalidateMode.disabled,
            decoration: InputDecoration(
              border: border,
              errorBorder: errorBorder,
              focusedErrorBorder: focusedErrorBorder,
              contentPadding: contentPadding?.let(
                    (it) => AdaptiveDropdown.kdropdownContentPadding.add(it),
                  ) ??
                  AdaptiveDropdown.kdropdownContentPadding,
            ).merge(decoration),
            alignment: alignment,
            elevation: elevation,
            dropdownColor: dropdownColor,
            isDense: isDense,
            itemHeight: kMinInteractiveDimension,
            validator: (value) => errorText,
            iconDisabledColor: iconDisabledColor,
            iconEnabledColor: iconEnabledColor,
            menuMaxHeight: menuMaxHeight,
            selectedItemBuilder: (_) => items
                .map((iv) =>
                    child?.call(iv) ??
                    Align(
                      alignment: Alignment.centerLeft,
                      child: AdaptiveText(
                        '${text?.call(iv)}',
                        maxLines: maxLines,
                        minFontSize: minFontSize,
                        maxFontSize: maxFontSize,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        fontSize: itemFontSize,
                        fontWeight: itemFontWeight,
                      ),
                    ))
                .toList(),
            items: items
                .map(
                  (item) => DropdownMenuItem<Model?>(
                    value: item,
                    alignment: Alignment.centerLeft,
                    child: child?.call(item) ??
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 2,
                              child: AdaptiveText(
                                '${text?.call(item) ?? "- Please set 'text' property -"}',
                                maxLines: maxLines,
                                minFontSize: minFontSize,
                                maxFontSize: maxFontSize,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                fontSize: itemFontSize,
                                fontWeight: itemFontWeight,
                              ),
                            ),
                            if (item == selected)
                              Icon(
                                Icons.check_circle,
                                size: 20,
                                color: iconEnabledColor ?? Palette.accentColor.shade400,
                              ),
                          ],
                        ),
                  ),
                )
                .toList(),
            disabledHint: disabledHintWidget ??
                Align(
                  alignment: Alignment.centerLeft,
                  child: AdaptiveText(
                    disabledHint,
                    maxLines: 1,
                    minFontSize: minFontSize,
                    maxFontSize: maxFontSize,
                    fontSize: itemFontSize,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                ),
            hint: hintWidget ??
                Align(
                  alignment: Alignment.centerLeft,
                  child: AdaptiveText(
                    hint,
                    maxLines: 1,
                    minFontSize: minFontSize,
                    maxFontSize: maxFontSize,
                    fontSize: itemFontSize,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                ),
            value: selected,
            isExpanded: isExpanded,
            icon: const Icon(Icons.keyboard_arrow_down),
            iconSize: iconSize,
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}
