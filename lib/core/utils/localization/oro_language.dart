import 'package:flutter/material.dart';

class OromoMaterialLocalizations extends DefaultMaterialLocalizations {
  const OromoMaterialLocalizations();

  static const LocalizationsDelegate<MaterialLocalizations> delegate = _OromoMaterialLocalizationsDelegate();

  @override
  String get cancelButtonLabel => 'Haqqi';

  @override
  String get okButtonLabel => 'Eyyee';

  @override
  String get selectAllButtonLabel => 'Filadhu Hunda';

  // Add other overrides as necessary for your app...
}

class _OromoMaterialLocalizationsDelegate extends LocalizationsDelegate<MaterialLocalizations> {
  const _OromoMaterialLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'oro';

  @override
  Future<MaterialLocalizations> load(Locale locale) async => const OromoMaterialLocalizations();

  @override
  bool shouldReload(covariant LocalizationsDelegate<MaterialLocalizations> old) => false;
}
