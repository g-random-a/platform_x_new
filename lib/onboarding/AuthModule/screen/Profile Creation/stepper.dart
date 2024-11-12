import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:platform_x/generated/l10n.dart';
import 'package:platform_x/lib.dart';
import 'package:platform_x/onboarding/AuthModule/bloc/profile%20bloc/datacollector_bloc.dart';
import 'package:platform_x/onboarding/AuthModule/bloc/profile%20bloc/datacollector_event.dart';
import 'package:platform_x/onboarding/AuthModule/bloc/profile%20bloc/datacollector_state.dart';
import 'package:platform_x/onboarding/AuthModule/miscellaneous/dropdown_options.dart';
import 'package:platform_x/onboarding/AuthModule/screen/Profile%20Creation/Component/countriesDropdown.dart';
import 'package:platform_x/onboarding/AuthModule/screen/Profile%20Creation/Component/dropdown.dart';
import 'package:platform_x/onboarding/AuthModule/screen/Profile%20Creation/Component/nationalityDropdown.dart';
import 'package:platform_x/onboarding/Common/button.dart';
import 'package:platform_x/onboarding/Common/footer.dart';
import 'package:platform_x/onboarding/Common/gradient.dart';
import 'package:platform_x/onboarding/AuthModule/screen/Profile Creation/Component/divider.dart';

class NewProfilePageScreen extends StatelessWidget {
  const NewProfilePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ProfileBloc(), child: NewProfilePage());
  }
}

class NewProfilePage extends StatefulWidget {
  const NewProfilePage({Key? key}) : super(key: key);

  @override
  _NewProfilePageState createState() => _NewProfilePageState();
}

class _NewProfilePageState extends State<NewProfilePage> {
// Here we have created list of steps that
// are required to complete the form

  int _activeCurrentStep = 0;
  final _basicInfoFormKey = GlobalKey<FormState>();
  final _addressInfoFormKey = GlobalKey<FormState>();
  final _profileInfoFormKey = GlobalKey<FormState>();
  final TextEditingController _passwordController =
      TextEditingController(); // Form key for validation.

  bool _isObscured = true; //for password obscuration

  // Store data separately for address and user info
  final Map<String, dynamic> _userData = {'user_type': 'data_collector'};
  final Map<String, dynamic> _addressData = {};
  final Map<String, dynamic> _profileData = {};
  final Map<String, dynamic> _support = {};

  List<Step> stepList() => [
        Step(
            title: Text(S.of(context).account),
            state:
                _activeCurrentStep > 0 ? StepState.complete : StepState.indexed,
            isActive: _activeCurrentStep >= 0,
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _basicInfoFormKey,
                child: Column(
                  children: [
                    buildDivider(S.of(context).basic_information),
                    const SizedBox(height: 16),
                    Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            // First Name, Middle Name, National ID No.
                            _buildTextField(
                                label: S.of(context).username,
                                hint: '',
                                dataMap: _userData,
                                dataLabel: 'username'),
                            _buildTextField(
                                label: S.of(context).email,
                                hint: '',
                                dataMap: _userData,
                                dataLabel: 'email',
                                boardType: 'Email',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return S.of(context).enter_email;
                                  }
                                  final RegExp emailRegex = RegExp(
                                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

                                  if (!emailRegex.hasMatch(value)) {
                                    return S.of(context).enter_valid_email;
                                  }
                                  return null;
                                }),
                            Row(children: [
                              Expanded(
                                child: _buildTextField(
                                    label: S.of(context).first_name,
                                    hint: '',
                                    dataMap: _userData,
                                    dataLabel: 'first_name'),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: _buildTextField(
                                    label: S.of(context).last_name,
                                    hint: '',
                                    dataMap: _userData,
                                    dataLabel: 'last_name'),
                              )
                            ]),

                            _buildTextField(
                                label: S.of(context).password,
                                hint: '',
                                controller: _passwordController,
                                obscureText: true,
                                dataMap: _userData,
                                dataLabel: 'password',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return S.of(context).please_enter_password;
                                  } else if (value.length < 8) {
                                    return S
                                        .of(context)
                                        .password_must_be_8_character;
                                  }
                                  return null;
                                }),

                            _buildTextField(
                                label: S.of(context).confirm_password,
                                hint: '',
                                obscureText: true,
                                dataLabel: "confirm",
                                dataMap: _support,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return S.of(context).confirm_your_password;
                                  } else if (value !=
                                      _passwordController.text) {
                                    return S.of(context).password_dont_match;
                                  }
                                  return null;
                                })
                          ],
                        )),
                  ],
                ),
              ),
            )),
        Step(
            title: Text(S.of(context).address),
            state:
                _activeCurrentStep > 1 ? StepState.complete : StepState.indexed,
            isActive: _activeCurrentStep >= 1,
            content: Form(
              key: _addressInfoFormKey,
              child: Column(
                children: [
                  buildDivider(S.of(context).address_information),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child:
                        CountryDropdown(
                          dataMap: _addressData,
                        ),),
                      //    _buildTextField(
                      //       label: S.of(context).country,
                      //       hint: '',
                      //       dataMap: _addressData,
                      //       dataLabel: 'country'),
                      // ),
                      const SizedBox(width: 8),
                      Expanded(
                          child: _buildTextField(
                              label: S.of(context).region,
                              hint: '',
                              dataMap: _addressData,
                              dataLabel: 'region')),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                            label: S.of(context).city,
                            hint: '',
                            dataMap: _addressData,
                            dataLabel: 'city'),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                          child: _buildTextField(
                              label: S.of(context).zone_or_subcity,
                              hint: '',
                              dataMap: _addressData,
                              dataLabel: 'zone_or_subcity')),
                    ],
                  ),
                  _buildTextField(
                      label: S.of(context).woreda,
                      hint: '',
                      dataMap: _addressData,
                      dataLabel: 'woreda',
                      boardType: 'Number'),
                  _buildTextField(
                      label: S.of(context).postal_code,
                      hint: '',
                      dataMap: _addressData,
                      dataLabel: 'postal_code',
                      boardType: 'Number'),
                  _buildTextField(
                      label: S.of(context).address_line_1,
                      hint: '',
                      dataMap: _addressData,
                      dataLabel: 'address_line_1'),
                  _buildTextField(
                    label: S.of(context).address_line_2,
                    hint: '',
                    dataMap: _addressData,
                    dataLabel: 'address_line_2',
                  ),
                ],
              ),
            )),
        Step(
            title: Text(S.of(context).profile),
            isActive: _activeCurrentStep >= 2,
            content: Form(
              key: _profileInfoFormKey,
              child: Column(
                children: [
                  buildDivider(S.of(context).profile_information),
                  const SizedBox(
                    height: 16,
                  ),
                  // _buildTextField(
                  //     label: S.of(context).nationality,
                  //     hint: '',
                  //     dataMap: _profileData,
                  //     dataLabel: 'nationality'),
                  NationalityDropdown(dataMap: _profileData,),
                  // Date of Birth and Gender in one row.
                  Row(
                    children: [
                      Expanded(
                          child: _buildTextField(
                              label: S.of(context).date_of_birth,
                              hint: 'YYYY-MM-DD',
                              dataMap: _profileData,
                              dataLabel: 'date_of_birth',
                              boardType: 'Text',
                              validator: (value) {
                                if (value == null) {
                                  return S.of(context).enter_date_of_birth;
                                }
                                final RegExp dateRegex = RegExp(
                                    r'^\d{4}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01])$');

                                if (!dateRegex.hasMatch(value)) {
                                  return S.of(context).date_of_birth_format;
                                }
                                return null;
                              })),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: DropdownInputField(
                            validation: true,
                            options: gender,
                            data: _profileData,
                            defaultValue: "Male",
                            lable: S.of(context).sex,
                            dataKey: "gender",
                            errorMessage: S.of(context).please_select_option,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  _buildTextField(
                      label: S.of(context).phone_number,
                      hint: '',
                      dataMap: _profileData,
                      dataLabel: 'phone_number',
                      boardType: "Phone"),

                  // Education Level and Marital Status
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: DropdownInputField(
                            validation: true,
                            options: educationLevelStrings,
                            data: _profileData,
                            defaultValue: "Primary",
                            lable: S.of(context).education_level,
                            dataKey: "education_level",
                            errorMessage: S.of(context).please_select_option,
                          ),
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: DropdownInputField(
                            validation: true,
                            options: maritialStatus,
                            data: _profileData,
                            defaultValue: "Single",
                            lable: S.of(context).maritial_status,
                            dataKey: "marriage_status",
                            errorMessage: S.of(context).please_select_option,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Emergency Tin Number Contact Name and Phone
                  _buildTextField(
                      label: S.of(context).tin_number,
                      hint: '',
                      dataMap: _profileData,
                      dataLabel: 'tin_number',
                      boardType: "Number"),
                  _buildTextField(
                      label: S.of(context).emergency_contact_name,
                      hint: '',
                      dataMap: _profileData,
                      dataLabel: 'emergency_contact_name'),
                  _buildTextField(
                      label: S.of(context).emergency_contact_info,
                      hint: '',
                      dataMap: _profileData,
                      dataLabel: 'emergency_contact_number',
                      boardType: "Phone"),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: DropdownInputField(
                            validation: true,
                            options: idType,
                            data: _profileData,
                            defaultValue: "National Id",
                            lable: S.of(context).id_type,
                            dataKey: "id_type",
                            errorMessage: S.of(context).please_select_option,
                          ),
                        ),
                      ),
                    ],
                  ),
                  _buildTextField(
                      label: S.of(context).selected_id_number,
                      hint: '',
                      dataMap: _profileData,
                      dataLabel: 'id_number',
                      boardType: "Text and Number"),

                  const SizedBox(height: 24),
                ],
              ),
            ))
      ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text:
                      S.of(context).please_tell_us_about_you, // The green part
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold, // Bold text.
                    color: Colors.black
                  ),
                ),
                TextSpan(
                  text: S.of(context).yourself, // The red part
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold, // Bold text.
                    color: Colors.blue, // Blue color.
                  ),
                ),
              ],
            ),
          ),
        ),

        // Here we have initialized the stepper widget
        body: BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) async {
            if (state is ProfileCreated) {
              // Navigate to the next page when submission is successful
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(S.of(context).profile_created_successfuly)),
              );
              await Future.delayed(const Duration(seconds: 1));
              context.go('/document');
            } else if (state is ProfileCreationFailed) {
              // Show an error message if submission fails
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          child: Builder(builder: (context) {
            return Container(
              color: Colors.black,
              child: Theme(
                data: Theme.of(context).copyWith(
                    colorScheme: const ColorScheme.light(
                  primary: Color.fromARGB(255, 96, 169, 222),
                )),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: CustomPaint(
                        painter: GradientBackgroundPainter(
                            alignment: Alignment.bottomLeft),
                      ),
                    ),
                    Column(
                      children: [
                        Expanded(
                          child: Stepper(
                            type: StepperType.horizontal,
                            connectorThickness: 2,
                            currentStep: _activeCurrentStep,
                            steps: stepList(),
                            onStepContinue: () {
                              //not at the last page
                              bool validated = false;
                              switch (_activeCurrentStep) {
                                case 0:
                                  {
                                    if (_basicInfoFormKey.currentState
                                            ?.validate() ??
                                        false) {
                                      validated = true;
                                    }
                                    break;
                                  }
                                case 1:
                                  {
                                    if (_addressInfoFormKey.currentState
                                            ?.validate() ??
                                        false) {
                                      validated = true;
                                    }
                                  }
                              }
                              if (_activeCurrentStep <
                                  (stepList().length - 1)) {
                                if (validated) {
                                  setState(() {
                                    _activeCurrentStep += 1;
                                  });
                                }
                              } else {
                                _basicInfoFormKey.currentState?.save();
                                _addressInfoFormKey.currentState?.save();
                                _profileData['user'] = _userData;
                                _profileData['user_address'] = _addressData;
                                _profileData['latitude'] = .1;
                                _profileData['longitude'] = .21;

                                if (_profileInfoFormKey.currentState
                                        ?.validate() ??
                                    false) {
                                  _profileInfoFormKey.currentState?.save();
                                  // Emit the event to submit the form
                                  BlocProvider.of<ProfileBloc>(context)
                                      .add(CreateProfile(_profileData));
                                }
                              }
                            },
                            onStepCancel: () {
                              if (_activeCurrentStep == 0) {
                                return;
                              }

                              setState(() {
                                _activeCurrentStep -= 1;
                              });
                            },
                            controlsBuilder: (BuildContext context,
                                ControlsDetails details) {
                              return Row(
                                children: [
                                  if (_activeCurrentStep != 0)
                                    Expanded(
                                      child: CustomButton(
                                          text: S.of(context).back,
                                          onPressed:
                                              details.onStepCancel ?? () {}),
                                    ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: CustomButton(
                                      text: S.of(context).next,
                                      onPressed:
                                          details.onStepContinue ?? () {},
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        BlocBuilder<ProfileBloc, ProfileState>(
                            builder: (context, state) {
                          if (state is ProfileCreating) {
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
                            return const SizedBox();
                          }
                        }),
                        const SizedBox(height: 10),
                        const CutsomFooter()
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
        ));
  }

  // Method to build text fields.
  Widget _buildTextField({
    required String label,
    required String hint,
    FormFieldValidator<String>? validator,
    required Map<String, dynamic>? dataMap,
    required String? dataLabel,
    TextEditingController? controller,
    String boardType = "Text",
    bool obscureText =
        false, // default to false, meaning not obscure by default
  }) {
    final TextInputType keyboardType;
    switch (boardType) {
      case 'Text':
        keyboardType = TextInputType.text;
        break;
      case 'Number':
        keyboardType = TextInputType.number;
      case 'Date':
        keyboardType = TextInputType.datetime;
        break;
      case 'Phone':
        keyboardType = TextInputType.phone;
        break;
      case 'Email':
        keyboardType = TextInputType.emailAddress;
        break;
      default:
        keyboardType = TextInputType.text;
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        style: const TextStyle(color: Colors.black),
        controller: controller,
        decoration: InputDecoration(
          hoverColor: Colors.black,
          fillColor: Colors.black,
          focusColor: Colors.black,
          suffixIcon: obscureText
              ? IconButton(
                  icon: Icon(
                    _isObscured ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    // Toggle the password visibility
                    setState(() {
                      _isObscured = !_isObscured;
                    });
                  })
              : null,
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),

        keyboardType: keyboardType,
        validator: validator ??
            (value) {
              if (boardType == "Number" &&
                  value != null &&
                  !RegExp(r'^[0-9]+$').hasMatch(value)) {
                return S.of(context).please_enter_number_only;
              } else if (boardType == "Text" &&
                  value != null &&
                  !RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                return S.of(context).please_enter_letters_only;
              }

              return null;
            },
        onSaved: (value) {
          dataMap?[dataLabel as String] = value;
        },
        obscureText: obscureText && _isObscured, // for password fields
      ),
    );
  }
}
