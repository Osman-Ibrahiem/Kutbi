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
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
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
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Kutbi`
  String get appTitle {
    return Intl.message('Kutbi', name: 'appTitle', desc: '', args: []);
  }

  /// `Login`
  String get loginTitle {
    return Intl.message('Login', name: 'loginTitle', desc: '', args: []);
  }

  /// `Welcome back`
  String get welcomeBack {
    return Intl.message(
      'Welcome back',
      name: 'welcomeBack',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Email is required`
  String get error_empty_email {
    return Intl.message(
      'Email is required',
      name: 'error_empty_email',
      desc: '',
      args: [],
    );
  }

  /// `The email address is not valid.`
  String get error_invalid_email {
    return Intl.message(
      'The email address is not valid.',
      name: 'error_invalid_email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Password is required`
  String get error_empty_password {
    return Intl.message(
      'Password is required',
      name: 'error_empty_password',
      desc: '',
      args: [],
    );
  }

  /// `Min 6 characters`
  String get error_invalid_password {
    return Intl.message(
      'Min 6 characters',
      name: 'error_invalid_password',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get btnLogin {
    return Intl.message('Login', name: 'btnLogin', desc: '', args: []);
  }

  /// `This field is required`
  String get error_required_field {
    return Intl.message(
      'This field is required',
      name: 'error_required_field',
      desc: '',
      args: [],
    );
  }

  /// `No account found with this email.`
  String get error_user_not_found {
    return Intl.message(
      'No account found with this email.',
      name: 'error_user_not_found',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect password. Please try again.`
  String get error_wrong_password {
    return Intl.message(
      'Incorrect password. Please try again.',
      name: 'error_wrong_password',
      desc: '',
      args: [],
    );
  }

  /// `This account has been disabled. Please contact support.`
  String get error_user_disabled {
    return Intl.message(
      'This account has been disabled. Please contact support.',
      name: 'error_user_disabled',
      desc: '',
      args: [],
    );
  }

  /// `Too many attempts. Please try again later.`
  String get error_too_many_requests {
    return Intl.message(
      'Too many attempts. Please try again later.',
      name: 'error_too_many_requests',
      desc: '',
      args: [],
    );
  }

  /// `Login failed.`
  String get error_login_faild {
    return Intl.message(
      'Login failed.',
      name: 'error_login_faild',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email or password.`
  String get error_invalid_credentials {
    return Intl.message(
      'Invalid email or password.',
      name: 'error_invalid_credentials',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection. Please check your network.`
  String get error_no_internet {
    return Intl.message(
      'No internet connection. Please check your network.',
      name: 'error_no_internet',
      desc: '',
      args: [],
    );
  }

  /// `This sign-in method is not enabled.`
  String get error_operation_not_allowed {
    return Intl.message(
      'This sign-in method is not enabled.',
      name: 'error_operation_not_allowed',
      desc: '',
      args: [],
    );
  }

  /// `The email address is already in use.`
  String get error_email_already_used {
    return Intl.message(
      'The email address is already in use.',
      name: 'error_email_already_used',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong. Please try again.`
  String get error_unknown {
    return Intl.message(
      'Something went wrong. Please try again.',
      name: 'error_unknown',
      desc: '',
      args: [],
    );
  }

  /// `Logged in successfully.`
  String get success_login {
    return Intl.message(
      'Logged in successfully.',
      name: 'success_login',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account? `
  String get donotHaveAccount {
    return Intl.message(
      'Don\'t have an account? ',
      name: 'donotHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Create account`
  String get createAccount {
    return Intl.message(
      'Create account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Register new account`
  String get registerTitle {
    return Intl.message(
      'Register new account',
      name: 'registerTitle',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message('Name', name: 'name', desc: '', args: []);
  }

  /// `Name is required`
  String get error_name_empty {
    return Intl.message(
      'Name is required',
      name: 'error_name_empty',
      desc: '',
      args: [],
    );
  }

  /// `Passwords doesn't match`
  String get error_passwords_not_match {
    return Intl.message(
      'Passwords doesn\'t match',
      name: 'error_passwords_not_match',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get btnRegister {
    return Intl.message('Register', name: 'btnRegister', desc: '', args: []);
  }

  /// `Registered successfully.`
  String get success_register {
    return Intl.message(
      'Registered successfully.',
      name: 'success_register',
      desc: '',
      args: [],
    );
  }

  /// `A world of books`
  String get appSubTitle {
    return Intl.message(
      'A world of books',
      name: 'appSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message('Description', name: 'description', desc: '', args: []);
  }

  /// `Show Less`
  String get showLess {
    return Intl.message('Show Less', name: 'showLess', desc: '', args: []);
  }

  /// `Show More`
  String get showMore {
    return Intl.message('Show More', name: 'showMore', desc: '', args: []);
  }

  /// `Publication year`
  String get publicationYear {
    return Intl.message(
      'Publication year',
      name: 'publicationYear',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message('Price', name: 'price', desc: '', args: []);
  }

  /// `Pages`
  String get pages {
    return Intl.message('Pages', name: 'pages', desc: '', args: []);
  }

  /// `Removed from bookmarks`
  String get bookmarks_removed {
    return Intl.message(
      'Removed from bookmarks',
      name: 'bookmarks_removed',
      desc: '',
      args: [],
    );
  }

  /// `Added to bookmarks`
  String get bookmarks_added {
    return Intl.message(
      'Added to bookmarks',
      name: 'bookmarks_added',
      desc: '',
      args: [],
    );
  }

  /// `Books Store`
  String get booksStore {
    return Intl.message('Books Store', name: 'booksStore', desc: '', args: []);
  }

  /// `My Bookmarks`
  String get myBookmarks {
    return Intl.message(
      'My Bookmarks',
      name: 'myBookmarks',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get myAccount {
    return Intl.message('Account', name: 'myAccount', desc: '', args: []);
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Logout`
  String get btnLogout {
    return Intl.message('Logout', name: 'btnLogout', desc: '', args: []);
  }

  /// `Version {appVersion}`
  String version(Object appVersion) {
    return Intl.message(
      'Version $appVersion',
      name: 'version',
      desc: 'App version label',
      args: [appVersion],
    );
  }

  /// `No bookmarks yet.`
  String get noBookmarks {
    return Intl.message(
      'No bookmarks yet.',
      name: 'noBookmarks',
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
      Locale.fromSubtags(languageCode: 'ar'),
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
