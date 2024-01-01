
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller ;
  final bool obscureText ;
  final Widget? suffixIcon ;
 final String hinttext ;
 final int? maxlength;
 final String? Function(String?) validator ;

  const MyTextField({
    super.key,
     required this.controller,
      required this.hinttext,
        this.suffixIcon,
         required this.obscureText,
          required this.validator, this.maxlength
          });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      obscureText: obscureText,
      controller: controller,
      maxLength: maxlength,
      decoration: InputDecoration(
        fillColor: Colors.blue[50],
        filled: true,
        border: InputBorder.none,
        hintText: hinttext,
        hintStyle: TextStyle(
          color: Colors.grey[500],
          fontWeight: FontWeight.w300,
        ),
        suffixIcon: suffixIcon,
        
      ),
    );
  }
}