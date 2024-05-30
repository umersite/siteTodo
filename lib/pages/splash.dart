import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_todos/pages/login_page.dart';
//import 'package:flutter_todos/pages/todo.dart';
import 'package:flutter_todos/widgets/background.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  List<String> sayings = [
    "Dead will rise again",
    "Born free live free",
    "What happens to the soules who look in the eyes of draggon",
    "There is no evil by my contious",
    "Dead man walking"
  ];
  String saying="";
  Random rnd = Random();
  int counter = 0;

  void loadingStatus() {
    Future.delayed(const Duration(seconds: 1)).then((_) {
      setState(() {
        counter += 25;
        saying=sayings[rnd.nextInt(5)];
      });
      loadingStatus();
    });
  }


@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    setState(() {
      counter = 0;
      saying="";
    });
  }


 @override
  void initState() {
    super.initState();
    loadingStatus();
    Timer(
      const Duration(seconds: 4),
      () => Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context)=> const LoginPage()
      ))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: backgroundContainer(fillbody())
    );
  }

  Widget fillbody(){
    return  Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                color:Colors.black54,
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    //crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                      const CircularProgressIndicator(),
                      const SizedBox(height: 10),
                      Text("Loading $counter%",style: 
                      Theme.of(context).textTheme.bodyMedium
                      ,),
                       const SizedBox(height: 10),
                       Text(saying,style: 
                      Theme.of(context).textTheme.bodyMedium
                      ,),
                       const SizedBox(height: 10),
                       Text("App powered by Aptech Site Center",style: 
                      Theme.of(context).textTheme.bodyLarge
                      ,),
                     ],
                  ),
                  ),
              )
            ],
          ),
        );
      

  }
}
