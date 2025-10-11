import 'package:flutter/material.dart';

import '../controllers/session.dart';
import '../enums/authentication_step.dart';
import '../enums/keyboard_type.dart';
import '../enums/text_validation.dart';
import '../models/form_inputs/text.dart';
import '../utilities/type_converter.dart';
import 'forms/base.dart';
import 'loading_indicator.dart';

class WickWidgetAuthentication extends StatefulWidget {
  const WickWidgetAuthentication({super.key});

  @override
  State<WickWidgetAuthentication> createState() =>
      _WickWidgetAuthenticationState();
}

class _WickWidgetAuthenticationState extends State<WickWidgetAuthentication> {
  WickEnumAuthenticationStep _currentStep =
      WickEnumAuthenticationStep.enterEmail;
  bool _isLoading = false;
  String? _email;
  int? _sessionId;

  static const String _emailInputName = 'Email';
  static const String _codeInputName = 'Code';

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const WickWidgetLoadingIndicator();
    }

    return switch (_currentStep) {
      WickEnumAuthenticationStep.enterEmail => _buildSignInWithEmailForm(),
      WickEnumAuthenticationStep.verifyEmail => _buildVerifyEmailForm(),
    };
  }

  Widget _buildSignInWithEmailForm() {
    return WickWidgetFormBase(
      name: 'Sign In With Email',
      inputs: [
        WickModelFormInputText(
          validations: [
            WickEnumTextValidation.required,
            WickEnumTextValidation.email,
          ],
          keyboardType: WickEnumKeyboardType.email,
          name: _emailInputName,
          helpText:
              'Enter your email to sign in. We’ll send a quick verification email and nothing else.',
        ),
      ],
      submitButtonText: 'Continue',
      onSubmit: _handleSignInWithEmailSubmit,
    );
  }

  Widget _buildVerifyEmailForm() {
    return WickWidgetFormBase(
      name: 'Verify Email',
      inputs: [
        WickModelFormInputText(
          validations: [WickEnumTextValidation.required],
          keyboardType: WickEnumKeyboardType.number,
          name: _codeInputName,
          helpText: 'Enter the code sent to $_email',
        ),
      ],
      submitButtonText: 'Continue',
      onSubmit: _handleVerifySubmit,
      onCancel: _reset,
    );
  }

  Future<void> _handleSignInWithEmailSubmit(
    Map<String, dynamic> formValues,
  ) async {
    final String? email = WickUtilityTypeConverter.describe(
      formValues[_emailInputName],
    );
    if (email == null) return;
    _setLoading(true);
    final sessionId = await WickControllerSession().sendVerificationEmail(
      context,
      email,
    );
    if (mounted) {
      setState(() {
        _email = email;
        _sessionId = sessionId;
        _isLoading = false;
        _currentStep =
            sessionId != null
                ? WickEnumAuthenticationStep.verifyEmail
                : WickEnumAuthenticationStep.enterEmail;
      });
    }
  }

  Future<void> _handleVerifySubmit(Map<String, dynamic> formValues) async {
    final String? code = WickUtilityTypeConverter.describe(
      formValues[_codeInputName],
    );
    if (code == null || _sessionId == null) return;
    _setLoading(true);
    final sessionToken = await WickControllerSession().signIn(
      context,
      _sessionId!,
      code,
    );
    if (mounted) {
      setState(() {
        _isLoading = false;
        if (sessionToken == null) {
          _currentStep = WickEnumAuthenticationStep.verifyEmail;
        }
        // Once signed in, the application will redirect the user.
      });
    }
  }

  void _setLoading(bool loading) {
    if (mounted) {
      setState(() {
        _isLoading = loading;
      });
    }
  }

  void _reset() {
    setState(() {
      _currentStep = WickEnumAuthenticationStep.enterEmail;
      _isLoading = false;
      _email = null;
      _sessionId = null;
    });
  }
}
