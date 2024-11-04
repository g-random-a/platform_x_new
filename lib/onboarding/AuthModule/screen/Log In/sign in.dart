import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_x/core/application/auth/bloc/check_auth_bloc.dart';
import 'package:platform_x/core/application/auth/event/check_auth_event.dart';
import 'package:platform_x/generated/l10n.dart';
import 'package:platform_x/onboarding/AuthModule/bloc/login%20bloc/login_bloc.dart';
import 'package:platform_x/onboarding/AuthModule/bloc/login%20bloc/login_event.dart';
import 'package:platform_x/onboarding/AuthModule/bloc/login%20bloc/login_state.dart';
import 'package:platform_x/onboarding/Common/footer.dart';
import '../../../Common/button.dart';
import '../../../Common/gradient.dart';
import 'package:go_router/go_router.dart';

class LogIn extends StatelessWidget {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => LoginBloc(), child: LogInScreen());
  }
}

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreen createState() => _LogInScreen();
}

class _LogInScreen extends State<LogInScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _loginData = {};
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:
          BlocListener<LoginBloc, LoginState>(listener: (context, state) async {
        if (state is Logged) {
          // Navigate to the next page when submission is successful
          BlocProvider.of<AuthBloc>(context).add(AuthLoginEvent());
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(S.of(context).log_in_successfuly)),
          );
          await Future.delayed(const Duration(seconds: 1));
          context.go('/');
        } else if (state is LoggingFailed) {
          // Show an error message if submission fails
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      }, child: Builder(builder: (context) {
        return Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter:
                    GradientBackgroundPainter(alignment: Alignment.bottomLeft),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Platform Logo and Title
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/PlatformX_logo.png', // Ensure the logo is added to assets
                            width: 160,
                            height: 160,
                          ),
                        ],
                      ),
                      // const SizedBox(height: 40),

                      // Title
                      Text(
                        S.of(context).login,
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      const SizedBox(height: 8),

                      // Subtitle
                      Text(
                        S.of(context).please_enter_username_and_password,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Password Fields
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: S.of(context).username,
                          labelStyle: TextStyle(color: Colors.black),
                          hoverColor: Colors.black,
                          hintStyle: const TextStyle(color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(color: Colors.black)),
                        ),
                        style: const TextStyle(color: Colors.black),
                        validator: (value) {
                          // use the custom validator or default one
                          if (value == null || value.isEmpty) {
                            return S
                                .of(context)
                                .please_enter_username; // default validation message
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _loginData["username"] = value as String;
                        }, // for password fields
                      ),

                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: InputDecoration(
                          labelStyle: const TextStyle(color: Colors.black),
                          hoverColor: Colors.black,
                          hintStyle: const TextStyle(color: Colors.black),
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(color: Colors.black)),
                          suffixIconColor: Colors.black,
                          suffixIcon: IconButton(
                              icon: Icon(
                                _isObscure
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                // Toggle the password visibility
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              }),
                          labelText: S.of(context).password,
                        ),
                        style: TextStyle(color: Colors.black),
                        validator: (value) {
                          // use the custom validator or default one
                          if (value == null || value.isEmpty) {
                            return S
                                .of(context)
                                .please_enter_password; // default validation message
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _loginData['password'] = value as String;
                        },
                        obscureText: _isObscure, // for password fields
                      ),

                      const SizedBox(height: 20),

                      // Continue Button
                      BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                        if (state is Logging) {
                          return const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                              ]);
                        } else {
                          return SizedBox(
                            width: double.infinity,
                            child: CustomButton(
                                text: S.of(context).next,
                                onPressed: () {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    _formKey.currentState?.save();
                                    // Emit the event to submit the form
                                    BlocProvider.of<LoginBloc>(context)
                                        .add(Login(_loginData));
                                  }
                                }),
                          );
                        }
                        // to return some widget incase all the above fails
                      }),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                S.of(context).dont_have_account,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Flexible(
                              child: GestureDetector(
                                onTap: () => {context.go('/profile')},
                                child: Text(
                                  S.of(context).create_new_account,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 96, 169, 222),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Spacer(),

                      // Powered by Text
                      const CutsomFooter()
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      })),
    );
  }
}
