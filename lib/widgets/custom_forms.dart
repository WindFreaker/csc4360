import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {

  // required arguments
  final String label;
  final IconData icon;

  // optional arguments
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextEditingController? controller;

  CustomTextFormField({required this.label, required this.icon, this.onSaved, this.validator, this.obscureText = false, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: IconTheme(
          data: IconThemeData(
            color: Colors.black,
          ),
          child: Icon(icon),
        ),
      ),
      onSaved: onSaved,
      validator: validator,
      obscureText: obscureText,
      controller: controller,
    );
  }

}

String? Function(String?) checkFor(List<String? Function(String)> checks) {

  return (String? input) {

    if (input == null) {
      input = '';  // make input not possibly null
    }

    String? result;
    for (final check in checks) {
      result = check(input);
      if (result != null) {
        break;
      }
    }

    return result;

  };

}

class CustomValidators {

  static String? notEmpty(String input) {

    if (input.isEmpty) {
      return 'Field cannot be empty.';
    }

    return null;

  }

  static String? validEmail(String input) {

    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(input)) {
      return 'Please enter a valid email address.';
    }

    return null;

  }

}