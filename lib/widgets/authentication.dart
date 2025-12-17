import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/session.dart';
import '../enums/authentication_step.dart';
import '../enums/keyboard_type.dart';
import '../enums/text_validation.dart';
import '../models/form_inputs/text.dart';
import '../providers/navigation.dart';
import '../providers/session.dart';
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
  String? _loadingAction;
  String? _email;
  int? _sessionId;

  static const String _emailInputName = 'Email';
  static const String _codeInputName = 'Code';

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return WickWidgetLoadingIndicator(action: _loadingAction);
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
              'Enter your email to sign in. We’ll send a quick verification email.',
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
          helpText: 'Enter the code sent to $_email.',
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
    final String? email = WickUtilityTypeConverter.convert(
      formValues[_emailInputName],
    );
    if (email == null) return;
    _setLoading(true, 'Sending verification email.');
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
    final String? code = WickUtilityTypeConverter.convert(
      formValues[_codeInputName],
    );
    if (code == null || _sessionId == null) return;
    _setLoading(true, 'Verifying.');
    final bool signedIn = await Provider.of<WickProviderSession>(
      context,
      listen: false,
    ).signIn(context, _sessionId!, code);
    if (mounted && signedIn) {
      (Provider.of<WickProviderNavigation>(
        context,
        listen: false,
      )).navigate(context);
    }
    _setLoading(false);
  }

  void _setLoading(bool loading, [String? action]) {
    setState(() {
      _isLoading = loading;
      if (loading) {
        _loadingAction = action;
      } else {
        _loadingAction = null;
      }
    });
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
