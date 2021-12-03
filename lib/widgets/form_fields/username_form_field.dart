library username_form_field.dart;

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:washryte/core/data/response/index.dart';
import 'package:washryte/core/domain/entities/entities.dart';
import 'package:washryte/widgets/widgets.dart';

/// A stateless widget to render Form Fields for Name.
// ignore: must_be_immutable
class UsernameFormField<Reactive extends BlocBase<ReactiveState>, ReactiveState> extends StatelessWidget {
  final bool Function(ReactiveState)? validate;
  final bool Function(ReactiveState)? disabled;
  final String? Function(ReactiveState)? initial;
  final FieldObject<String?>? Function(ReactiveState)? field;
  final void Function(Reactive, String)? onChanged;
  final Option<AppHttpResponse?> Function(ReactiveState)? response;
  final void Function(ReactiveState)? onEditingComplete;
  final CupertinoFormType? cupertinoFormType;
  final EdgeInsets? cupertinoPadding;
  final FocusNode? focus;
  final String? heroTag;
  final EdgeInsets? materialPadding;
  final FocusNode? next;
  final String? prefix;
  final bool isNew;

  const UsernameFormField({
    Key? key,
    this.isNew = true,
    this.prefix,
    this.validate,
    this.disabled,
    this.initial,
    this.field,
    this.onChanged,
    this.focus,
    this.next,
    this.response,
    this.heroTag,
    this.cupertinoFormType,
    this.materialPadding,
    this.cupertinoPadding,
    this.onEditingComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReactiveTextFormField<Reactive, ReactiveState>(
      disabled: disabled,
      validate: validate,
      capitalization: TextCapitalization.none,
      keyboardType: TextInputType.text,
      autoFillHints: [
        if (!isNew) AutofillHints.username,
        if (isNew) AutofillHints.newUsername,
        AutofillHints.nickname,
      ],
      field: field,
      focus: focus,
      next: next,
      response: response,
      errorField: (error) => error.errors?.username,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
    );
  }
}
