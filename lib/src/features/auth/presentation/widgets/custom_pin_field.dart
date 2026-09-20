import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomPinField extends StatelessWidget {
  
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final String hintext;
  final Function(String)? onfieldsubmitted;
  

  
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  const CustomPinField({
    super.key,
    this.inputFormatters,
    this.keyboardType,
  
   
    this.controller,
    required this.textInputAction,
    required this.hintext,
    this.onfieldsubmitted,
  });
  UnderlineInputBorder normalborder() {
    return UnderlineInputBorder(
      borderSide: BorderSide(color: const Color.fromARGB(255, 243, 205, 33), width: 1.2),

    );
  }

  

  InputDecoration inputDecoration() {
    return InputDecoration(
    
      hintText: hintext,
      
     
      enabledBorder: normalborder(),
      focusedBorder: normalborder(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        obscureText:true,
        onFieldSubmitted: onfieldsubmitted,
      
        controller: controller,
        textInputAction: textInputAction,
        decoration: inputDecoration(),
        style: TextStyle(letterSpacing: 6),
        maxLength: 4,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
      ),
    );
  }
}
