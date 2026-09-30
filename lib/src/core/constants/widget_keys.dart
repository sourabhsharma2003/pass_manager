import 'package:flutter/material.dart';

abstract class WidgetKeys {
  static const authScreen = ValueKey('auth_screen');
  static const entryScreen = ValueKey('entry_screen');
  static const usePinView = ValueKey('use_pin_view');
  static const bioAuthView = ValueKey('bio_auth_view');
  static const usePasswordView = ValueKey('use_pass_view');
  static const usePasswordbuttom = ValueKey('use_pass_button');
  static const createPasspinView = ValueKey('create_pass_pin_view');
  static const loading = ValueKey('loading');
  static const createPin = ValueKey('create_pin');
  static const createPass = ValueKey('create_pass');
  static const createButton = ValueKey('create_button');
  static const forgotButton = ValueKey('forgot_button');
  static const loginPinButton = ValueKey('login_pin_button');
  static const loginPassButton = ValueKey('login_pass_button');
  static const loginpinfield = ValueKey('logic_pin_field');
  static const loginErrordialog = ValueKey('login_error_dialog');
  static const loginpassfield = ValueKey('login_pass_field');
  static const loginpassbutton = ValueKey('login_pass_button');
}
