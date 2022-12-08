import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workshop/auth/auth_provider.dart';
import 'package:workshop/auth/auth_user_prefrence.dart';
import 'package:workshop/auth/blog_provider.dart';
import 'package:workshop/helpers/user_provider.dart';
import 'package:workshop/models/user_mode.dart';
import 'package:workshop/screens/home_screen.dart';
import 'package:workshop/screens/login_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => BlogProvider()),
      ],
      child:const MyApp(),
      ),
      );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    Future<User> getUser() => UserPreference().getUser();

    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'WorkShop App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
          future: getUser(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                case ConnectionState.waiting:
                return const CircularProgressIndicator();
               default:
               if(snapshot.hasError){
                return Text('Error: ${snapshot.error}');
               }else if(snapshot.data!.token == "null"){
                return const LoginScreen();
               }else{
                return const HomeScreen();
               }
            }
        },
        )
    );
  }
}
