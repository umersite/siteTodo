import 'package:flutter/material.dart';

import '../widgets/nav_drawer.dart';

class AboutUs_Page extends StatelessWidget {
  const AboutUs_Page({super.key});
  static const String routeName = '/AboutUsPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       drawer:const NavigationCustomDrawer(),
      appBar: AppBar(
        title: const Text("About Us"),
       
      ),
      body: const Center(
        child:  Text("About Us"),
      ),
    );
  }
}