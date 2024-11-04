import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_x/core/application/locale/bloc/locale_bloc.dart';
import 'package:platform_x/core/application/locale/event/locale_event.dart';
import 'package:platform_x/core/application/theme/bloc/theme_bloc.dart';
import 'package:platform_x/generated/l10n.dart';
import '../../Common/dropdown.dart';
import '../../Common/button.dart';
import '../../Common/gradient.dart';
// ignore: depend_on_referenced_packages
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String _selectedLanguage = 'አማርኛ';
  final String _initiaLanguage = 'አማርኛ'; // Default selected language
  final List<String> _languages = [
    'አማርኛ',
    'English',
    'Français',
    'Español',
    'Swahili'
  ];
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
    _initSharedPreferences(); // Initialize SharedPreferences on startup
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAuth();
    });
  }

  void _checkAuth() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? isAuth = prefs.getString('access_token');
    if (isAuth != null && isAuth.isNotEmpty) {
      context.go('/tasks');
      return;
    }

    setState(() {
      confirmPage = true;
    });

  }

  Future<void> _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> _saveLanguage(String language) async {
    BlocProvider.of<LocaleBloc>(context)
        .add(ChangeLocaleEvent(Locale(_languageMap[language]!)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter:
                    GradientBackgroundPainter(alignment: Alignment.bottomLeft),
              ),
            ),
            !confirmPage ? CircularProgressIndicator(color: Colors.green,) :  Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // const Spacer(), // Push the logo to the top
                  Column(
                    children: [
                      // Logo and Text Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/logo.png',
                            width: 280,
                            height: 280,
                          ),
                        ],
                      ),
                    ],
                  ),
                  // const Spacer(), // Push other elements downward
            
                  // Language Selection Dropdown
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).language,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      const SizedBox(height: 8),
                      CustomDropdown(
                        initialValue: _initiaLanguage,
                        items: _languages,
                        onChanged: (String? newValue) {
                          // Handle language change here
                          _selectedLanguage = newValue!;
                          _saveLanguage(_selectedLanguage);
                        },
                      ),
                    ],
                  ),
            
                  const SizedBox(
                      height: 40), // Add some space between dropdown and button
            
                  // Get Started Button
                  CustomButton(
                    text: S.of(context).get_started,
                    onPressed: () {
                      print(_prefs.getString('language'));
                      context.go('/onboarding');
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
