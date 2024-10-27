import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../event/locale_event.dart';
import '../state/locale_state.dart';

class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  LocaleBloc() : super(LocaleInitialState()) {
    on<ChangeLocaleEvent>(_onChangeLocale);
    _loadSavedLocale(); // Load the saved locale on startup
  }

  // Load saved locale from shared preferences
  Future<void> _loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString('languageCode');
    if (languageCode != null) {
      add(ChangeLocaleEvent(Locale(languageCode)));
    }
  }

  // Change locale and persist the selected locale in shared preferences
  Future<void> _onChangeLocale(ChangeLocaleEvent event, Emitter<LocaleState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', event.locale.languageCode); // Save language preference
    emit(LocaleChangedState(event.locale)); // Emit new state with the selected locale
  }
}
