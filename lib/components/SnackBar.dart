  import 'package:flutter/material.dart';

enum SnackBarType { error, success }

SnackBar Message({
  message = String,
  type = SnackBarType
  }) {
    return SnackBar(
          content: Text(message),
          backgroundColor: type == "success"? Color.fromARGB(194, 9, 167, 28) : Color.fromARGB(184, 147, 11, 11),
        );
  }