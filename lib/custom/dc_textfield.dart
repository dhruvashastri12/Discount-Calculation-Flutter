import 'package:flutter/material.dart';

class DCTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function onClearPressed;
  final String label;
  final int maxLength;
  final bool discountValueError;

  DCTextField(
      {this.controller, this.onClearPressed, this.label, this.maxLength, this.discountValueError});

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.white60,
      controller: controller,
      style: TextStyle(
        color: Colors.white60,
      ),
      maxLength: maxLength,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        suffixIcon: IconButton(
            icon: Icon(Icons.cancel, color: Colors.white24),
            onPressed: onClearPressed ?? () {}),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white60, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white60, width: 1.0),
        ),
        labelText: label ?? '',
        labelStyle: TextStyle(
          color: Colors.white60,
          fontSize: 17.0,
        ),
        errorText: discountValueError
            ? 'Please enter discount value < 100%'
            : null,
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white60, width: 1.0),
        ),
      ),
    );
  }
}
