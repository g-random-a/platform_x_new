import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:platform_x/core/application/auth/bloc/check_auth_bloc.dart';
import 'package:platform_x/core/application/locale/bloc/locale_bloc.dart';
import 'package:platform_x/core/application/locale/event/locale_event.dart';
import 'package:platform_x/core/application/theme/bloc/theme_bloc.dart';
import 'package:platform_x/core/utils/theme/custom_text_styles.dart';
import 'package:platform_x/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

   String _selectedLanguage = 'አማርኛ';
  final String _initiaLanguage = 'አማርኛ'; // Default selected language
  
  final Map<String, String> _languageMap = {
    'አማርኛ': 'am',
    'English': 'en',
    'Français': 'fr',
    'Español': 'es',
    'Swahili': 'sw',
  };
  late SharedPreferences _prefs;
  bool confirmPage = false;

  @override
  void initState() {
    super.initState();
    _initSharedPreferences(); 

  }

  Future<void> _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _selectedLanguage = _prefs.getString('language') ?? _initiaLanguage;
  }

  Future<void> _saveLanguage(String language) async {
    BlocProvider.of<LocaleBloc>(context)
        .add(ChangeLocaleEvent(Locale(_languageMap[language]!)));
  }

  final List<String> _languages = ['English', 'Spanish', 'French', 'German'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(S.of(context).settings, style: CustomTextStyles.titleSmallPlusJakartaSansOnPrimary(context.watch<ThemeBloc>().state.themeData, context.watch<ThemeBloc>().state.appColorTheme).copyWith(fontSize: 20)),
        backgroundColor: context.watch<ThemeBloc>().state.appColorTheme.blue50,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),

              // Section Title
              const Text(
                'Account',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
              SizedBox(height: 10),

              // Change Language Setting
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: Icon(Icons.language, color: Colors.black),
                  title: Text(
                    'Change Language',
                    style: CustomTextStyles.titleSmallPlusJakartaSansOnPrimary(context.watch<ThemeBloc>().state.themeData, context.watch<ThemeBloc>().state.appColorTheme),
                  ),
                  trailing: DropdownButton<String>(
                    value: _selectedLanguage,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedLanguage = newValue!;
                      });
                    },
                    items: _languages.map((String language) {
                      return DropdownMenuItem<String>(
                        value: language,
                        child: Text(language, style: TextStyle(color: Colors.black),),
                      );
                    }).toList(),
                  ),
                ),
              ),

              // Placeholder for Other Account Settings
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: Icon(Icons.account_circle, color: Colors.black),
                  title:  Text(
                    'Account Information',
                    style: CustomTextStyles.titleSmallPlusJakartaSansOnPrimary(context.watch<ThemeBloc>().state.themeData, context.watch<ThemeBloc>().state.appColorTheme),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
                  onTap: () {},
                ),
              ),
              SizedBox(height: 25),

              // Placeholder for Notifications
              Text(
                'Notifications',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
              SizedBox(height: 10),

              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: Icon(Icons.notifications, color: Colors.black),
                  title: Text(
                    'Notification Settings',
                    style: CustomTextStyles.titleSmallPlusJakartaSansOnPrimary(context.watch<ThemeBloc>().state.themeData, context.watch<ThemeBloc>().state.appColorTheme),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
                  onTap: () {},
                ),
              ),
              SizedBox(height: 20),

              // Placeholder for Privacy & Security
              Text(
                'Privacy & Security',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
              SizedBox(height: 10),

              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: Icon(Icons.lock, color: Colors.black),
                  title: Text(
                    'Privacy Settings',
                    style: CustomTextStyles.titleSmallPlusJakartaSansOnPrimary(context.watch<ThemeBloc>().state.themeData, context.watch<ThemeBloc>().state.appColorTheme),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
                  onTap: () {},
                ),
              ),
              SizedBox(height: 40),

              // Logout Button
              Align(
                alignment: Alignment.bottomCenter,
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Logout logic here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Logout',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
