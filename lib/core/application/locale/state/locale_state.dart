import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LocaleState extends Equatable {
  final Locale locale;

  const LocaleState(this.locale);

  @override
  List<Object> get props => [locale];
}

class LocaleInitialState extends LocaleState {
  const LocaleInitialState() : super(const Locale('en'));
}

class LocaleChangedState extends LocaleState {
  const LocaleChangedState(super.locale);
}
