import 'package:flutter/material.dart';

class ModelFormDefinition<T> {
  final String label;
  final T initialValue;
  final List<FormFieldValidator> validators;
  final bool readOnly;
  final bool isUUID;
  ModelFormDefinition({
    required this.label,
    required this.validators,
    required this.initialValue,
    this.readOnly = false,
    this.isUUID = false,
  });
}
