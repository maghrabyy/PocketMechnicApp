import 'package:flutter/material.dart';
import 'package:flutter_course/style.dart';

class RegularInput extends StatelessWidget {
  const RegularInput({
    Key? key,
    required this.label,
    required this.inputController,
    this.hint,
    this.goNext,
    this.enabled,
    this.labelStyle,
    this.hintstyle,
    this.keyboardType,
    this.emptyErrorText,
    this.emptyFieldError,
    this.onChanged,
    this.maxLength,
    this.action,
    this.floatingLabel,
    this.capitalizationBehaviour,
  }) : super(key: key);
  final String label;
  final String? hint;
  final TextEditingController inputController;
  final bool? goNext;
  final bool? enabled;
  final TextStyle? labelStyle;
  final TextStyle? hintstyle;
  final TextInputType? keyboardType;
  final String? emptyErrorText;
  final bool? emptyFieldError;
  final int? maxLength;
  final Function(String)? onChanged;
  final IconButton? action;
  final bool? floatingLabel;
  final TextCapitalization? capitalizationBehaviour;
  @override
  Widget build(BuildContext context) {
    return TextField(
      textCapitalization: capitalizationBehaviour ?? TextCapitalization.none,
      maxLength: maxLength,
      keyboardType: keyboardType,
      enabled: enabled,
      controller: inputController,
      textAlign: TextAlign.center,
      textInputAction:
          goNext == true ? TextInputAction.next : TextInputAction.done,
      onChanged: onChanged,
      decoration: InputDecoration(
        floatingLabelBehavior: floatingLabel == true
            ? FloatingLabelBehavior.always
            : FloatingLabelBehavior.auto,
        suffixIcon: action,
        counterText: '',
        errorText: emptyFieldError == true ? emptyErrorText : null,
        labelText: label,
        hintStyle: hintstyle,
        labelStyle: labelStyle,
        hintText: hint,
      ),
    );
  }
}

class EmailInput extends StatelessWidget {
  const EmailInput({
    Key? key,
    this.goNext,
    required this.inputController,
    this.emptyFieldError,
    this.onChanged,
  }) : super(key: key);

  final TextEditingController inputController;
  final bool? goNext;
  final bool? emptyFieldError;
  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: inputController,
      keyboardType: TextInputType.emailAddress,
      textInputAction:
          goNext == true ? TextInputAction.next : TextInputAction.done,
      textAlign: TextAlign.center,
      onChanged: onChanged,
      decoration: InputDecoration(
        errorText: emptyFieldError == true ? 'Email cannot be blank' : null,
        labelText: 'Email',
        hintText: 'Enter your email address',
      ),
    );
  }
}

class EmailUsernameInput extends StatelessWidget {
  const EmailUsernameInput({
    Key? key,
    this.goNext,
    required this.inputController,
  }) : super(key: key);

  final TextEditingController inputController;
  final bool? goNext;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: inputController,
      keyboardType: TextInputType.emailAddress,
      textInputAction:
          goNext == true ? TextInputAction.next : TextInputAction.done,
      textAlign: TextAlign.center,
      decoration: const InputDecoration(
        labelText: 'Email/Username',
        hintText: 'Enter your username or email address',
      ),
    );
  }
}

class PhoneInput extends StatelessWidget {
  const PhoneInput({
    Key? key,
    this.goNext,
    required this.inputController,
    this.emptyFieldError,
    this.onChanged,
    this.hint,
    this.enabled,
    this.floatingLabel,
  }) : super(key: key);

  final TextEditingController inputController;
  final bool? goNext;
  final bool? emptyFieldError;
  final Function(String)? onChanged;
  final String? hint;
  final bool? enabled;
  final bool? floatingLabel;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: 11,
      enabled: enabled,
      keyboardType: TextInputType.phone,
      controller: inputController,
      textAlign: TextAlign.center,
      textInputAction:
          goNext == true ? TextInputAction.next : TextInputAction.none,
      onChanged: onChanged,
      decoration: InputDecoration(
        counterText: '',
        floatingLabelBehavior: floatingLabel == true
            ? FloatingLabelBehavior.always
            : FloatingLabelBehavior.auto,
        errorText:
            emptyFieldError == true ? 'Phone number cannot be blank' : null,
        labelText: 'Phone number',
        hintText: hint ?? 'Enter your phone number',
      ),
    );
  }
}

class PasswordInput extends StatefulWidget {
  const PasswordInput({
    Key? key,
    this.goNext,
    required this.inputController,
    this.confirmationPass,
    this.emptyFieldError,
    this.onChanged,
  }) : super(key: key);

  final TextEditingController inputController;
  final bool? goNext;
  final bool? confirmationPass;
  final bool? emptyFieldError;
  final Function(String)? onChanged;

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool hiddenPassword = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: hiddenPassword,
      controller: widget.inputController,
      textAlign: TextAlign.center,
      textInputAction:
          widget.goNext == true ? TextInputAction.next : TextInputAction.done,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(
            hiddenPassword == true ? Icons.visibility : Icons.visibility_off,
            color: fifthLayerColor,
          ),
          onPressed: () {
            setState(() {
              hiddenPassword = !hiddenPassword;
            });
          },
        ),
        errorText:
            widget.emptyFieldError == true ? 'Password cannot be blank' : null,
        labelText:
            widget.confirmationPass == true ? 'Confirm Password' : 'Password',
        hintText: widget.confirmationPass == true
            ? 'Confirm your password'
            : 'Enter your password',
      ),
    );
  }
}
