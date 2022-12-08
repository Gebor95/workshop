

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workshop/auth/auth_user_prefrence.dart';
import 'package:workshop/helpers/user_provider.dart';
import 'package:workshop/models/user_mode.dart';
import 'package:workshop/screens/create_post.dart';
import 'package:workshop/screens/login_screen.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future <User> getUser()=> UserPreference().getUser();
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    getUser().then((value){
      User user =User(user: value.user, token: value.token);
      userProvider.setUser(user);
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        centerTitle: false,
        actions: [Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(onTap:() {
            UserPreference().removeUser();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
          }, child: const Icon(Icons.exit_to_app)),
        )],
      ),
      drawer: Drawer(
        backgroundColor: Colors.teal,
        child:  Column(
          children: [
            Container(
              alignment: Alignment.topCenter,
              width: double.infinity,
              height: 150.0,
              color:Colors.white,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(35.0),
                    child: Text(userProvider.changeName)),
                ],
              ),
            )
          ],
        ),
      ),
      body:const Center(child:  Text("You don't have any post yet!")),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const CreatePost(),));
        },
        ),
    );
  }
}