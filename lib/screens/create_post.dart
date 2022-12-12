


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workshop/auth/auth_provider.dart';
import 'package:workshop/auth/blog_provider.dart';
import 'package:workshop/helpers/http_service.dart';
import 'package:workshop/helpers/user_provider.dart';
class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final blogProvider = Provider.of<BlogProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left:18.0, right: 18.0, top: 50.0),
            child: Form(
               key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Create A Post", style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w600),),
                 const SizedBox(height: 60.0,),
                 Row(
                    children: const [Text("Post Title", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),),Padding(
                      padding: EdgeInsets.only(bottom:8.0),
                      child: Text("*", style: TextStyle(color: Colors.red),),
                    ),]
                  ),
                 TextFormField(
                   controller: title,
                     validator: (value){
                  if(value!.isEmpty){
                    return "Title is required!";
                   
                  }
                   return null;
                },
                   decoration: const InputDecoration(
                     filled: true,
                     fillColor: Color.fromARGB(255, 226, 226, 226),
                     border: InputBorder.none,
                     hintText: "Enter the post title"
                   ),
                   
                 ),
                 const SizedBox(height: 30.0,),
                  Row(
                    children: const [Text("Post Description", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),),Padding(
                      padding: EdgeInsets.only(bottom:8.0),
                      child: Text("*", style: TextStyle(color: Colors.red),),
                    ),]
                  ),
                 TextFormField(
                   controller: description,
                   maxLines: 7,
                     validator: (value){
                  if(value!.isEmpty){
                    return "Description is required!";
                   
                  }
                   return null;
                },
                    decoration:const  InputDecoration(
                     filled: true,
                     fillColor: Color.fromARGB(255, 226, 226, 226),
                     border: InputBorder.none,
                     hintText: "Enter the post description"
                   ),
                   
                 ),
                  const SizedBox(height: 20.0,),
                 Container(
                  clipBehavior: Clip.none,
                  child: blogProvider.loadingCircle == Status.loading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(500, 50),
                      maximumSize: const Size(500, 50),
                    ),
                    onPressed: (){
                       if (_formKey.currentState!.validate()) {
                          blogProvider.savePost(title.text, description.text, userProvider.changeName, userProvider.tokensaved).then((response) {
                          if (response['status']!=200) {
                             HttpService().showMessage(response['message'], context);
                          }else{
                            clearForm();
                         // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen(),));
                       HttpService().showMessage(response['message'], context);
                          }
                        });
                        }
                    }, 
                    child: const Text("Save"),
                    ),
                 ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void clearForm(){
    title.clear();
    description.clear();
  }
}