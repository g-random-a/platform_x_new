import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:platform_x/generated/l10n.dart';
import 'package:platform_x/onboarding/AuthModule/bloc/profile%20bloc/datacollector_bloc.dart';
import 'package:platform_x/onboarding/AuthModule/bloc/profile%20bloc/datacollector_event.dart';
import 'package:platform_x/onboarding/AuthModule/bloc/profile%20bloc/datacollector_state.dart';
import 'package:platform_x/onboarding/Common/button.dart';
import 'package:platform_x/tasks_management/presentation/components/custom_image.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadDocumentsScreen extends StatelessWidget {
  const UploadDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ProfileBloc(), child: const UploadDocuments());
  }
}

class UploadDocuments extends StatefulWidget {
  const UploadDocuments({super.key});

  @override
  _UploadDocumentsState createState() => _UploadDocumentsState();
}

class _UploadDocumentsState extends State<UploadDocuments> {
  // Variables to track the selected files for each field
  String? idImage;
  String? profileImage;
  String? credentialImage;

  Map<String, File>? fileData = {};
  Map<String, String> fieldMap = {
    'credentialImage': 'credential_image',
    'profileImage': 'profile_picture',
    'idImage': 'id_image'
  };

  // Progress tracking (0, 1, 2, or 3)
  List completedSteps = [];

  SharedPreferences? _preferences;
  String? profileId;

  @override
  void initState() {
    super.initState();
    _initializeSharedPreferences();
  }

  Future<void> _initializeSharedPreferences() async {
    _preferences = await SharedPreferences.getInstance();
    _loadStoredValue();
  }

  void _loadStoredValue() {
    setState(() {
      profileId = _preferences!.getString('profile_id');
    });
  }

  // Method to handle file picking
  Future<void> _pickFile(String field) async {
    print("***** file picker here");
    final FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
    print("***** file picker here");

    if (result != null) {
      try {
        File file = File(result.files.single.path!);
        fileData?[fieldMap[field]!] = file;
      } catch (e) {
        print(e);
        print("Currently in web mod, please use mobile version");
      }
      setState(() {
        switch (field) {
          case 'idImage':
            idImage = result.files.single.path!;
            break;
          case 'profileImage':
            profileImage = result.files.single.path!;
            break;
          case 'credentialImage':
            credentialImage = result.files.single.path!;
            break;
        }
        _updateProgress();
      });
    }
  }

  // Update progress based on selected files
  void _updateProgress() {
    List steps = [];
    if (idImage != null) steps.add(1);
    if (profileImage != null) steps.add(2);
    if (credentialImage != null) steps.add(3);

    setState(() {
      completedSteps = steps;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) async {
            if (state is ProfileUpdated) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(S.of(context).profile_files_uploaded)),
              );
              await Future.delayed(const Duration(seconds: 3));
              // Navigate to the next page when submission is successful
              context.go('/login');
            } else if (state is ProfileUpdateFailed) {
              // Show an error message if submission fails
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          child: Builder(builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Card(
                  elevation: 8,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              S.of(context).upload_documents,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              S.of(context).document_size,
                              style:
                                  const TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                            const SizedBox(height: 24),
                            _buildProgressIndicator(),
                            const SizedBox(height: 24),
                            _buildUploadField(
                                S.of(context).id_image, idImage, 'idImage'),
                            _buildUploadField(S.of(context).profile_picture,
                                profileImage, 'profileImage'),
                            _buildUploadField(
                                S.of(context).education_credential_image,
                                credentialImage,
                                'credentialImage'),
                            // const Spacer(),
                            BlocBuilder<ProfileBloc, ProfileState>(
                                builder: (context, state) {
                              if (state is ProfileUpdating) {
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
                                        profileId = profileId ??
                                            '8d4fa07c-5cfd-43da-bb16-d63e4aba0e91';
                                        BlocProvider.of<ProfileBloc>(context).add(
                                            UpdateProfile(profileId!, {},
                                                files: fileData));
                                      }),
                                );
                              }
                              // to return some widget incase all the above fails
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  // Widget for the upload fields
  Widget _buildUploadField(String label, String? file, String field) {
    return GestureDetector(
      onTap: () {
        _pickFile(field);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(255, 126, 126, 126)),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(
                height: 2,
              ),
              Row(

                children: [
                  const Icon(
                    Icons.photo,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  Text(
                    file != null
                        ? "Picked"
                        : S.of(context).upload_file_here,
                    style: const TextStyle(color: Colors.black),
                    // softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  file != null
                      ? const Icon(Icons.check, color: Colors.green)
                      : const SizedBox(),
                ],
              ),
              if (file != null)
                    CustomImageView(
                      imagePath: file,
                      fit: BoxFit.fill,
                      width: 100,
                      height: 100,
                      captured: true,
                    )
            ],
          ),
        ),
      ),
    );
  }

  // Progress Indicator Widget
  Widget _buildProgressIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildStep(1, S.of(context).id_image),
        const Expanded(
            child: Divider(
          color: Colors.grey,
        )),
        _buildStep(2, S.of(context).profile_picture),
        const Expanded(
            child: Divider(
          color: Colors.grey,
        )),
        _buildStep(3, S.of(context).credential_image),
      ],
    );
  }

  // Step widget for the progress indicator
  Widget _buildStep(int step, String label) {
    bool isActive = completedSteps.contains(step);
    return Column(
      children: [
        CircleAvatar(
            backgroundColor: Colors.blue,
            child: !isActive
                ? Text(step.toString(),
                    style: const TextStyle(color: Colors.white))
                : const Icon(
                    Icons.check,
                  )),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.black),
        ),
      ],
    );
  }
}
