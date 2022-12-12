//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workshop/auth/auth_provider.dart';
import 'package:workshop/helpers/http_service.dart';
import 'package:workshop/helpers/user_provider.dart';
import 'package:workshop/models/user_mode.dart';
import 'package:workshop/screens/home_screen.dart';
import 'package:workshop/screens/login_screen.dart';
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
   final TextEditingController email = TextEditingController();
    final TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authProvider =Provider.of<AuthProvider>(context);
    final userProvider =Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(left:18.0, right: 18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                child: const Text("Registration Portal", style: TextStyle(fontSize: 24, color: Colors.white),),
              ),
             const SizedBox(height: 40),
              TextFormField(
                controller: name,
                keyboardType: TextInputType.name,
                validator: (value){
                  if(value!.isEmpty){
                    return "Name is required!";
                   
                  }
                   return null;
                },
                decoration: const InputDecoration(
                  label:Text("Name", style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),
               const SizedBox(height: 10),
              TextFormField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                validator: (value){
                  if(value!.isEmpty){
                    return "Email is required!";
                   
                  }
                   return null;
                },
                decoration: const InputDecoration(
                  label:Text("Email", style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),
               const SizedBox(height: 10),
              TextFormField(
                controller: password,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                obscuringCharacter: "*",
                validator: (value){
                  if(value!.isEmpty){
                    return "Password is required!";
                   
                  }
                   return null;
                },
                decoration: const InputDecoration(
                  label:Text("Password", style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),
           
                 const SizedBox(height: 30),
                 Container(
                  clipBehavior: Clip.none,
                  child: authProvider.registeredStatus == Status.registering
                  ? const CircularProgressIndicator()
                  :
                  ElevatedButton(onPressed: (){
                    if(_formKey.currentState!.validate()){
                      authProvider.register(name.text, email.text, password.text).then((response){
                        if(response['status']!=200){
                          HttpService().showMessage(response['message'], context);
                        }else{
                          User user = User(user: response['data'].user, token: response['data'].token);
                          userProvider.setUser(user);
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen(),));
                        }
                      });
                    }
                  }, child:const Text("Get Started")),
                 ),
                  const  SizedBox(height: 30,),
              Container(
              alignment: Alignment.center,
              child: TextButton.icon(onPressed: (){Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> const LoginScreen()));}, icon: const Icon(Icons.present_to_all, color: Colors.white,), label: const Text("Login Account", style: TextStyle(fontSize: 16, color: Colors.white),),
            )
            ),
            ],
          ),
        ),
      ),
    );
  }
}