
import 'package:flutter/material.dart';

String? validateEmail(String? value, FocusNode focusNode){
  Pattern pattern = r'^[\w-\.]+@([\w+]+\.)+[\w-]{2,4}$';
  RegExp regex = RegExp(pattern.toString());

  if(!regex.hasMatch(value.toString())){
    focusNode.requestFocus();
    return 'Please enter a valid email';
  }else{
    focusNode.unfocus();
    return null;
  }

}

String? validatePass(String? value){
  Pattern pattern = r'^\d{8}$';
   RegExp regex = RegExp(pattern.toString());
  if(!regex.hasMatch(value.toString())){    
    return 'Chars. of 8 digits XXXXXXXX required';
  }else{
    
    return null;
  }

}

String? validateName(String value, FocusNode focusNode){
  Pattern pattern = r'^[a-zA-Z ]$';
  RegExp regex = RegExp(pattern.toString());

  if(!regex.hasMatch(value.toString())){
    focusNode.requestFocus();
    return 'Name should contain only letters and spaces, and no digits';
  }else{
    focusNode.unfocus();
    return null;
  }

}