import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workshop/auth/auth_provider.dart';
import 'package:workshop/helpers/http_service.dart';
import 'package:workshop/helpers/user_provider.dart';
import 'package:workshop/models/user_mode.dart';
import 'package:workshop/screens/home_screen.dart';
import 'package:workshop/screens/register_screen.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
 final _formKey = GlobalKey<FormState>();
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
                child: const Text("Login Portal", style: TextStyle(fontSize: 24, color: Colors.white),),
              ),
             const SizedBox(height: 40),
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
                  child: authProvider.logginStatus == Status.loggingIn
                  ? const CircularProgressIndicator()
                  :ElevatedButton(
                    onPressed: (){
                      if (_formKey.currentState!.validate()) {
                        authProvider.login(email.text, password.text).then((response) {
                          if (response['status']!=200) {
                             HttpService().showMessage(response['message'], context);
                          }else{
                             User user = User(user: response['data'].user, token: response['data'].token);
                          userProvider.setUser(user);
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen(),));
                       
                          }
                        });
                        
                      }
                    },
                  child:const Text("Access Account")),
                 ),
                  const  SizedBox(height: 30,),
              Container(
              alignment: Alignment.center,
              child: TextButton.icon(onPressed: (){Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> const RegisterScreen()));}, icon: const Icon(Icons.person_add, color: Colors.white,), label: const Text("Register Account", style: TextStyle(fontSize: 16, color: Colors.white),),
            )
            ),
            ],
          ),
        ),
      ),
    );
  }
}