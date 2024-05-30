import 'package:flutter/material.dart';

backgroundContainer(child){
  return Container(
    decoration: BoxDecoration(
      color: Colors.black,
      image: DecorationImage(
        image: const AssetImage("assets/images/background.jpg"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.9), BlendMode.dstATop)
        )
    ),
    child: child,
  );
}