import 'package:dev_upload_image/firebase_options.dart';
import 'package:dev_upload_image/Login_In/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshort) {
          if (snapshort.connectionState == ConnectionState.waiting) {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Text("Welcome to PhotoShare"),
                ),
              ),
            );
          } else if (snapshort.hasError) {
            return MaterialApp(
               home: Scaffold(
                body: Center(
                  child: Text("An Error,please wait..."),
                ),
              ),
            );
          }
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Flutter clone",
            home: LoginScreen(),
          );
        });
  }
}
