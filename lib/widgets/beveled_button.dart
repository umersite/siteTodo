import 'package:flutter/material.dart';

Widget beveledButton(
  {
    required String title,
    required GestureTapCallback onTap
  }){
    return ElevatedButton(
      onPressed: onTap, 
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.purple.withOpacity(0.4),
        foregroundColor: Colors.white,
        elevation: 0,
        // Theme.of(context).textTheme.bodyMedium,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(5)
        )
      ),
      child: Text(title)
      );
  }