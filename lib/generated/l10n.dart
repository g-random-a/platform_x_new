// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Hello`
  String get hello {
    return Intl.message(
      'Hello',
      name: 'hello',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to the app!`
  String get welcome {
    return Intl.message(
      'Welcome to the app!',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get get_started {
    return Intl.message(
      'Get Started',
      name: 'get_started',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Log In`
  String get login {
    return Intl.message(
      'Log In',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// ` User Name`
  String get username {
    return Intl.message(
      ' User Name',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get first_name {
    return Intl.message(
      'First Name',
      name: 'first_name',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get last_name {
    return Intl.message(
      'Last Name',
      name: 'last_name',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get country {
    return Intl.message(
      'Country',
      name: 'country',
      desc: '',
      args: [],
    );
  }

  /// `Region`
  String get region {
    return Intl.message(
      'Region',
      name: 'region',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `Zone or SubCity`
  String get zone_or_subcity {
    return Intl.message(
      'Zone or SubCity',
      name: 'zone_or_subcity',
      desc: '',
      args: [],
    );
  }

  /// `Woreda`
  String get woreda {
    return Intl.message(
      'Woreda',
      name: 'woreda',
      desc: '',
      args: [],
    );
  }

  /// `Sex`
  String get sex {
    return Intl.message(
      'Sex',
      name: 'sex',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phone_number {
    return Intl.message(
      'Phone Number',
      name: 'phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Education Level`
  String get education_level {
    return Intl.message(
      'Education Level',
      name: 'education_level',
      desc: '',
      args: [],
    );
  }

  /// `Maitial Status`
  String get maritial_status {
    return Intl.message(
      'Maitial Status',
      name: 'maritial_status',
      desc: '',
      args: [],
    );
  }

  /// `Tin Number`
  String get tin_number {
    return Intl.message(
      'Tin Number',
      name: 'tin_number',
      desc: '',
      args: [],
    );
  }

  /// `Emergency Contact Name`
  String get emergency_contact_name {
    return Intl.message(
      'Emergency Contact Name',
      name: 'emergency_contact_name',
      desc: '',
      args: [],
    );
  }

  /// `Emergency Contact Phone`
  String get emergency_contact_info {
    return Intl.message(
      'Emergency Contact Phone',
      name: 'emergency_contact_info',
      desc: '',
      args: [],
    );
  }

  /// `Postal Code`
  String get postal_code {
    return Intl.message(
      'Postal Code',
      name: 'postal_code',
      desc: '',
      args: [],
    );
  }

  /// `Address Line 1`
  String get address_line_1 {
    return Intl.message(
      'Address Line 1',
      name: 'address_line_1',
      desc: '',
      args: [],
    );
  }

  /// `Address Line 2`
  String get address_line_2 {
    return Intl.message(
      'Address Line 2',
      name: 'address_line_2',
      desc: '',
      args: [],
    );
  }

  /// `Address Information`
  String get address_information {
    return Intl.message(
      'Address Information',
      name: 'address_information',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Profile Information`
  String get profile_information {
    return Intl.message(
      'Profile Information',
      name: 'profile_information',
      desc: '',
      args: [],
    );
  }

  /// `Nationality`
  String get nationality {
    return Intl.message(
      'Nationality',
      name: 'nationality',
      desc: '',
      args: [],
    );
  }

  /// `Date of Birth`
  String get date_of_birth {
    return Intl.message(
      'Date of Birth',
      name: 'date_of_birth',
      desc: '',
      args: [],
    );
  }

  /// `Please enter date of birth`
  String get enter_date_of_birth {
    return Intl.message(
      'Please enter date of birth',
      name: 'enter_date_of_birth',
      desc: '',
      args: [],
    );
  }

  /// `Must be YYYY-MM-DD`
  String get date_of_birth_format {
    return Intl.message(
      'Must be YYYY-MM-DD',
      name: 'date_of_birth_format',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirm_password {
    return Intl.message(
      'Confirm Password',
      name: 'confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Please enter an email`
  String get enter_email {
    return Intl.message(
      'Please enter an email',
      name: 'enter_email',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email`
  String get enter_valid_email {
    return Intl.message(
      'Please enter a valid email',
      name: 'enter_valid_email',
      desc: '',
      args: [],
    );
  }

  /// `Basic Information`
  String get basic_information {
    return Intl.message(
      'Basic Information',
      name: 'basic_information',
      desc: '',
      args: [],
    );
  }

  /// `Id Type`
  String get id_type {
    return Intl.message(
      'Id Type',
      name: 'id_type',
      desc: '',
      args: [],
    );
  }

  /// `Selected Id No.`
  String get selected_id_number {
    return Intl.message(
      'Selected Id No.',
      name: 'selected_id_number',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account {
    return Intl.message(
      'Account',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `yourself`
  String get yourself {
    return Intl.message(
      'yourself',
      name: 'yourself',
      desc: '',
      args: [],
    );
  }

  /// `Empower Yourself with Digital Tasks`
  String get onboarding_1_title {
    return Intl.message(
      'Empower Yourself with Digital Tasks',
      name: 'onboarding_1_title',
      desc: '',
      args: [],
    );
  }

  /// ` Join a community of contributors and earn supplemental income by completing simple digital tasks.`
  String get onboarding_1_sub_title {
    return Intl.message(
      ' Join a community of contributors and earn supplemental income by completing simple digital tasks.',
      name: 'onboarding_1_sub_title',
      desc: '',
      args: [],
    );
  }

  /// `Simple Tasks, Real Rewards`
  String get onboarding_2_title {
    return Intl.message(
      'Simple Tasks, Real Rewards',
      name: 'onboarding_2_title',
      desc: '',
      args: [],
    );
  }

  /// `Complete tasks using your smartphone at your convenience`
  String get onboarding_2_sub_title {
    return Intl.message(
      'Complete tasks using your smartphone at your convenience',
      name: 'onboarding_2_sub_title',
      desc: '',
      args: [],
    );
  }

  /// `Get Ready to Start Earning`
  String get onboarding_3_title {
    return Intl.message(
      'Get Ready to Start Earning',
      name: 'onboarding_3_title',
      desc: '',
      args: [],
    );
  }

  /// `Set up your profile, verify your identity, and choose the types of tasks you want to complete. You're just a few steps away from earning your first income`
  String get onboarding_3_sub_title {
    return Intl.message(
      'Set up your profile, verify your identity, and choose the types of tasks you want to complete. You\'re just a few steps away from earning your first income',
      name: 'onboarding_3_sub_title',
      desc: '',
      args: [],
    );
  }

  /// `Create New Account`
  String get create_new_account {
    return Intl.message(
      'Create New Account',
      name: 'create_new_account',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get dont_have_account {
    return Intl.message(
      'Don\'t have an account?',
      name: 'dont_have_account',
      desc: '',
      args: [],
    );
  }

  /// `Please enter Password`
  String get please_enter_password {
    return Intl.message(
      'Please enter Password',
      name: 'please_enter_password',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 8 characters long`
  String get password_must_be_8_character {
    return Intl.message(
      'Password must be at least 8 characters long',
      name: 'password_must_be_8_character',
      desc: '',
      args: [],
    );
  }

  /// `Please confirm your password`
  String get confirm_your_password {
    return Intl.message(
      'Please confirm your password',
      name: 'confirm_your_password',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get password_dont_match {
    return Intl.message(
      'Passwords do not match',
      name: 'password_dont_match',
      desc: '',
      args: [],
    );
  }

  /// `Please enter Username`
  String get please_enter_username {
    return Intl.message(
      'Please enter Username',
      name: 'please_enter_username',
      desc: '',
      args: [],
    );
  }

  /// `Please enter Username`
  String get please_enter_username_and_password {
    return Intl.message(
      'Please enter Username',
      name: 'please_enter_username_and_password',
      desc: '',
      args: [],
    );
  }

  /// `Please select an option`
  String get please_select_option {
    return Intl.message(
      'Please select an option',
      name: 'please_select_option',
      desc: '',
      args: [],
    );
  }

  /// `Please tell us a little about `
  String get please_tell_us_about_you {
    return Intl.message(
      'Please tell us a little about ',
      name: 'please_tell_us_about_you',
      desc: '',
      args: [],
    );
  }

  /// `Logged In Successfuly`
  String get log_in_successfuly {
    return Intl.message(
      'Logged In Successfuly',
      name: 'log_in_successfuly',
      desc: '',
      args: [],
    );
  }

  /// `profile created successfuly`
  String get profile_created_successfuly {
    return Intl.message(
      'profile created successfuly',
      name: 'profile_created_successfuly',
      desc: '',
      args: [],
    );
  }

  /// `Please enter number only`
  String get please_enter_number_only {
    return Intl.message(
      'Please enter number only',
      name: 'please_enter_number_only',
      desc: '',
      args: [],
    );
  }

  /// `Please enter letter only`
  String get please_enter_letters_only {
    return Intl.message(
      'Please enter letter only',
      name: 'please_enter_letters_only',
      desc: '',
      args: [],
    );
  }

  /// `Profile Files Uploaded`
  String get profile_files_uploaded {
    return Intl.message(
      'Profile Files Uploaded',
      name: 'profile_files_uploaded',
      desc: '',
      args: [],
    );
  }

  /// `Upload documents`
  String get upload_documents {
    return Intl.message(
      'Upload documents',
      name: 'upload_documents',
      desc: '',
      args: [],
    );
  }

  /// `All documents shall not exceed 10MB`
  String get document_size {
    return Intl.message(
      'All documents shall not exceed 10MB',
      name: 'document_size',
      desc: '',
      args: [],
    );
  }

  /// `Id Image`
  String get id_image {
    return Intl.message(
      'Id Image',
      name: 'id_image',
      desc: '',
      args: [],
    );
  }

  /// `Profile Picture`
  String get profile_picture {
    return Intl.message(
      'Profile Picture',
      name: 'profile_picture',
      desc: '',
      args: [],
    );
  }

  /// `Credential Image`
  String get credential_image {
    return Intl.message(
      'Credential Image',
      name: 'credential_image',
      desc: '',
      args: [],
    );
  }

  /// `Education Crediential Image`
  String get education_credential_image {
    return Intl.message(
      'Education Crediential Image',
      name: 'education_credential_image',
      desc: '',
      args: [],
    );
  }

  /// `Upload your file here`
  String get upload_file_here {
    return Intl.message(
      'Upload your file here',
      name: 'upload_file_here',
      desc: '',
      args: [],
    );
  }

  /// `Page Not Found`
  String get t_page_not_found {
    return Intl.message(
      'Page Not Found',
      name: 't_page_not_found',
      desc: '',
      args: [],
    );
  }

  /// `Task Completed Successfully!`
  String get t_task_compleleted_successfully {
    return Intl.message(
      'Task Completed Successfully!',
      name: 't_task_compleleted_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Thank you for completing the task. Your submission has been received and is now being reviewed for quality. You’ll receive your earnings once the verification is complete. Keep up the great work—you're making a difference!`
  String get t_task_compleleted_successfully_desc {
    return Intl.message(
      'Thank you for completing the task. Your submission has been received and is now being reviewed for quality. You’ll receive your earnings once the verification is complete. Keep up the great work—you\'re making a difference!',
      name: 't_task_compleleted_successfully_desc',
      desc: '',
      args: [],
    );
  }

  /// `Back to Main Screen`
  String get t_back_to_main_screen {
    return Intl.message(
      'Back to Main Screen',
      name: 't_back_to_main_screen',
      desc: '',
      args: [],
    );
  }

  /// `No questions found`
  String get t_no_questions_found {
    return Intl.message(
      'No questions found',
      name: 't_no_questions_found',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get t_back {
    return Intl.message(
      'Back',
      name: 't_back',
      desc: '',
      args: [],
    );
  }

  /// `Back to Dash`
  String get t_back_to_dashboard {
    return Intl.message(
      'Back to Dash',
      name: 't_back_to_dashboard',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to go back to dashboard?`
  String get t_are_you_sure_dashboard {
    return Intl.message(
      'Are you sure you want to go back to dashboard?',
      name: 't_are_you_sure_dashboard',
      desc: '',
      args: [],
    );
  }

  /// `All progress will be lost`
  String get t_dashboard_progress_lost {
    return Intl.message(
      'All progress will be lost',
      name: 't_dashboard_progress_lost',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get t_cancel {
    return Intl.message(
      'Cancel',
      name: 't_cancel',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get t_yes {
    return Intl.message(
      'Yes',
      name: 't_yes',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get t_submit {
    return Intl.message(
      'Submit',
      name: 't_submit',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get t_next {
    return Intl.message(
      'Next',
      name: 't_next',
      desc: '',
      args: [],
    );
  }

  /// `Previous`
  String get t_previous {
    return Intl.message(
      'Previous',
      name: 't_previous',
      desc: '',
      args: [],
    );
  }

  /// `Total Earning`
  String get t_total_earning {
    return Intl.message(
      'Total Earning',
      name: 't_total_earning',
      desc: '',
      args: [],
    );
  }

  /// `Total Tasks`
  String get t_total_tasks {
    return Intl.message(
      'Total Tasks',
      name: 't_total_tasks',
      desc: '',
      args: [],
    );
  }

  /// `Couldn't load please try again later.`
  String get t_couldnt_load_try_again {
    return Intl.message(
      'Couldn\'t load please try again later.',
      name: 't_couldnt_load_try_again',
      desc: '',
      args: [],
    );
  }

  /// `Start Task`
  String get t_start_task {
    return Intl.message(
      'Start Task',
      name: 't_start_task',
      desc: '',
      args: [],
    );
  }

  /// `Most Recent`
  String get t_most_recent {
    return Intl.message(
      'Most Recent',
      name: 't_most_recent',
      desc: '',
      args: [],
    );
  }

  /// `Ongoing`
  String get t_ongoing {
    return Intl.message(
      'Ongoing',
      name: 't_ongoing',
      desc: '',
      args: [],
    );
  }

  /// `Saved`
  String get t_saved {
    return Intl.message(
      'Saved',
      name: 't_saved',
      desc: '',
      args: [],
    );
  }

  /// `Est. Budget`
  String get t_est_budget {
    return Intl.message(
      'Est. Budget',
      name: 't_est_budget',
      desc: '',
      args: [],
    );
  }

  /// `points.`
  String get t_points {
    return Intl.message(
      'points.',
      name: 't_points',
      desc: '',
      args: [],
    );
  }

  /// `Show less`
  String get t_showless {
    return Intl.message(
      'Show less',
      name: 't_showless',
      desc: '',
      args: [],
    );
  }

  /// `More`
  String get t_More {
    return Intl.message(
      'More',
      name: 't_More',
      desc: '',
      args: [],
    );
  }

  /// `out`
  String get t_out {
    return Intl.message(
      'out',
      name: 't_out',
      desc: '',
      args: [],
    );
  }

  /// `of`
  String get t_of {
    return Intl.message(
      'of',
      name: 't_of',
      desc: '',
      args: [],
    );
  }

  /// `completed`
  String get t_completed {
    return Intl.message(
      'completed',
      name: 't_completed',
      desc: '',
      args: [],
    );
  }

  /// `task`
  String get t_task {
    return Intl.message(
      'task',
      name: 't_task',
      desc: '',
      args: [],
    );
  }

  /// `You don't have Saved Tasks currently`
  String get t_nosavedtasks {
    return Intl.message(
      'You don\'t have Saved Tasks currently',
      name: 't_nosavedtasks',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get tab_home {
    return Intl.message(
      'Home',
      name: 'tab_home',
      desc: '',
      args: [],
    );
  }

  /// `Tasks`
  String get tab_tasks {
    return Intl.message(
      'Tasks',
      name: 'tab_tasks',
      desc: '',
      args: [],
    );
  }

  /// `Wallet`
  String get tab_wallet {
    return Intl.message(
      'Wallet',
      name: 'tab_wallet',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get tab_history {
    return Intl.message(
      'History',
      name: 'tab_history',
      desc: '',
      args: [],
    );
  }

  /// `profile`
  String get tab_profile {
    return Intl.message(
      'profile',
      name: 'tab_profile',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'am'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'oro'),
      Locale.fromSubtags(languageCode: 'sw'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
