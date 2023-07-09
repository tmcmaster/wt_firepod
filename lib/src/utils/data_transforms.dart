import 'package:flutter/material.dart';

mixin DataTransforms {
  static int stringToInt(String? value) => int.tryParse(value ?? '') ?? 0;
  static double stringToDouble(String? value) => double.tryParse(value ?? '') ?? 0;
}

mixin DataValidators {
  static FormFieldValidator<String> phone({String? errorText}) {
    return (valueCandidate) => validateMobile(valueCandidate);
  }

  static String? validateMobile(String? value) {
    const pattern = r'(^(\+?\(61\)|\(\+?61\)|\+?61|\(0[1-9]\)|0[1-9])?( ?-?[0-9]){7,9}$)';
    final regExp = RegExp(pattern);
    if (value == null || value.isEmpty) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }
}
