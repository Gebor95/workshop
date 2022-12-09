

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workshop/auth/auth_user_prefrence.dart';
import 'package:workshop/helpers/allblogs_provider.dart';
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
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    getBlogs();
  }

  getBlogs() async => await context.read<AllBlogsProvider>().fetchBlogs();
  Future <User> getUser()=> UserPreference().getUser();
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    var blogslist = Provider.of<AllBlogsProvider>(context).allBlogsList;
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
      body:Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
          const  SizedBox(height: 30.0,),
          const Center(child: Text("Welcome to Emmi Software Track Blog", style: TextStyle(fontSize: 18.0),)),
          const Padding(
             padding: EdgeInsets.all(10.0),
             child: Divider(height: 2.0, color: Colors.blue,),
           ),
          const SizedBox(height: 20.0,),
          Expanded(
            child: ListView.builder(
              
              itemCount: blogslist.length,
              itemBuilder: (context, index){
              return const ListTile(
                leading: Icon(Icons.edit),
                title: Text("Blog Title"),
                subtitle: Text("Blog Body"),
                trailing: Icon(Icons.delete),
              );
            }),
          ),
          ],
          
        ),
      ),
      
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const CreatePost(),));
        },
        ),
    );
  }
}