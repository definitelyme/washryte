import 'package:washryte/core/data/response/index.dart';
import 'package:washryte/core/domain/entities/entities.dart';
import 'package:washryte/core/domain/validator/validator.dart';
import 'package:washryte/utils/utils.dart';
import 'package:washryte/widgets/widgets.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A stateless widget to render Form Field for Phone Inputs.
// ignore: must_be_immutable
class PhoneFormField<Reactive extends BlocBase<ReactiveState>, ReactiveState> extends StatelessWidget {
  late ReactiveState _state;

  final bool Function(ReactiveState)? validate;
  final bool Function(ReactiveState)? disabled;
  final String? Function(ReactiveState)? initial;
  final FieldObject<String?>? Function(ReactiveState)? field;
  final void Function(Reactive, String)? onChanged;
  final int? Function(ReactiveState)? maxLength;
  final bool? Function(ReactiveState)? readOnly;
  final Option<AppHttpResponse?> Function(ReactiveState)? response;
  final TextEditingController? Function(ReactiveState)? controller;
  final List<String?>? Function(ErrorResponse)? errorField;
  final void Function(ReactiveState)? onEditingComplete;
  final InputBorder? border;
  final BorderRadius? borderRadius;
  final CupertinoFormType? cupertinoFormType;
  final EdgeInsets? cupertinoPadding;
  final InputBorder? errorBorder;
  final FocusNode? focus;
  final InputBorder? focusedErrorBorder;
  final String? heroTag;
  final EdgeInsets? materialPadding;
  final FocusNode? next;
  final String? prefix;
  final Widget? prefixWidget;

  PhoneFormField({
    Key? key,
    this.prefix,
    this.prefixWidget,
    this.validate,
    this.disabled,
    this.initial,
    this.field,
    this.onChanged,
    this.readOnly,
    this.focus,
    this.next,
    this.response,
    this.errorField,
    this.controller,
    this.heroTag,
    this.maxLength,
    this.cupertinoFormType,
    this.materialPadding,
    this.cupertinoPadding,
    this.borderRadius,
    this.border,
    this.errorBorder,
    this.focusedErrorBorder,
    this.onEditingComplete,
  }) : super(key: key);

  ReactiveState get state => _state;

  set __state(ReactiveState value) => _state = value;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Reactive, ReactiveState>(
      builder: (c, s) {
        __state = s;

        var _input = AdaptiveTextFormInput(
          cupertinoFormType: cupertinoFormType,
          cupertinoPadding: cupertinoPadding,
          materialPadding: materialPadding,
          prefixMode: OverlayVisibilityMode.always,
          prefixIcon: prefixWidget,
          initial: initial?.call(s),
          disabled: disabled?.call(s) ?? false,
          validate: validate?.call(s) ?? false,
          readOnly: readOnly?.call(s),
          controller: controller?.call(s),
          capitalization: TextCapitalization.none,
          keyboardType: TextInputType.phone,
          maxLength: maxLength?.call(s),
          borderRadius: borderRadius,
          border: border,
          errorBorder: errorBorder,
          focusedErrorBorder: focusedErrorBorder,
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp('$phonePattern'))],
          autoFillHints: [AutofillHints.telephoneNumberLocal],
          focus: focus,
          next: next,
          onChanged: (val) => onChanged?.call(c.read<Reactive>(), val),
          onEditingComplete: () => onEditingComplete?.call(s),
          errorText: field?.call(s)?.value.fold(
                (f) => f.message,
                (_) => response?.call(s).fold(
                      () => null,
                      (http) => http?.response.maybeMap(
                        error: (f) => f.errors?.phone?.firstOrNone ?? errorField?.call(f)?.firstOrNone,
                        orElse: () => null,
                      ),
                    ),
              ),
        );

        return heroTag != null && !heroTag.isBlank ? Hero(tag: heroTag!, child: _input) : _input;
      },
    );
  }
}
