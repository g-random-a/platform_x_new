import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LocaleEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ChangeLocaleEvent extends LocaleEvent {
  final Locale locale;

  ChangeLocaleEvent(this.locale);

  @override
  List<Object> get props => [locale];
}

class LoadLocaleEvent extends LocaleEvent {
  @override
  List<Object> get props => [];
}
