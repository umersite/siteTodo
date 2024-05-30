
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todos/firebase_options.dart';
import 'package:flutter_todos/pages/about_us.dart';
import 'package:flutter_todos/pages/comment_page.dart';
import 'package:flutter_todos/pages/splash.dart';
import 'package:flutter_todos/pages/todo.dart';
import 'package:flutter_todos/routes/page_routes.dart';

Future<void> main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProjectMain());
}

// void main(){
// runApp(const ProjectMain());

// }

class ProjectMain extends StatelessWidget {
  const ProjectMain({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    title: "To Do List",
   home: const SplashPage(),
   //home: Comment_Page(),
    debugShowCheckedModeBanner: false,    
    theme: ThemeData(
      primarySwatch: Colors.blueGrey,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: Colors.black,
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white,width: 3),
          
        ),
        filled: true,
        fillColor: Colors.black.withOpacity(0.8),
        hintStyle: const TextStyle(color: Colors.redAccent,fontSize: 12.0),
        border: const OutlineInputBorder(),
        counterStyle: const TextStyle(color: Colors.white,fontSize: 12.0),
        errorStyle: const TextStyle(color: Colors.redAccent,fontSize: 12.0),
        errorBorder: const OutlineInputBorder(),
        labelStyle: const TextStyle(color: Colors.teal,fontSize: 12.0),
      ),
      textTheme: const TextTheme(
        titleMedium: TextStyle(color: Colors.greenAccent),
        bodyMedium: TextStyle(
          color:Colors.white,fontSize: 18,
        ),
        bodyLarge: TextStyle(
          color: Colors.white, fontSize: 20,
        )
      ),
    ),
    routes: {
      PageRoutes.home:(context)=>Todos(),
      PageRoutes.aboutus:(context)=>const AboutUs_Page(),
      PageRoutes.comments :(context) => Comment_Page(),
    },  
  
  );
  }
}