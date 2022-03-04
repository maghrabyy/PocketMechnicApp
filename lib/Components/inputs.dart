import 'package:flutter/material.dart';

class RegularInput extends StatelessWidget {
  const RegularInput({
    Key? key,
    required this.label,
    required this.inputController,
    this.hint,
    this.goNext,
  }) : super(key: key);
  final String label;
  final String? hint;
  final TextEditingController inputController;
  final bool? goNext;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: inputController,
      textAlign: TextAlign.center,
      textInputAction:
          goNext == true ? TextInputAction.next : TextInputAction.done,
      decoration: InputDecoration(
        labelText: label,
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
  }) : super(key: key);

  final TextEditingController inputController;
  final bool? goNext;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.phone,
      controller: inputController,
      textAlign: TextAlign.center,
      textInputAction:
          goNext == true ? TextInputAction.next : TextInputAction.done,
      decoration: const InputDecoration(
        labelText: 'Phone number',
        hintText: 'Enter your phone number',
      ),
    );
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput({
    Key? key,
    this.goNext,
    required this.inputController,
  }) : super(key: key);

  final TextEditingController inputController;
  final bool? goNext;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: true,
      controller: inputController,
      textAlign: TextAlign.center,
      textInputAction:
          goNext == true ? TextInputAction.next : TextInputAction.done,
      decoration: const InputDecoration(
        labelText: 'Password',
        hintText: 'Enter your password',
      ),
    );
  }
}
