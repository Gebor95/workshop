import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:workshop/auth/auth_provider.dart';
import 'package:workshop/helpers/http_service.dart';
import 'package:workshop/models/post.dart';

class BlogProvider with ChangeNotifier{

  Status _loadingCircle = Status.notLoading;
  Status get loadingCircle => _loadingCircle;
  

   Future <Map<String, dynamic>> savePost(String title, String body, String author, String token) async {
     final Map<String, dynamic> bodyPost = {
      "title": title,
      "body":body,
      "author": author,
    
    };
     _loadingCircle = Status.loading;
    notifyListeners();
    final  response = await post(Uri.parse(HttpService.blog),
    headers: {
      'content-Type': 'application/json',
      'Authorization':'Bearer $token',
    },
    body: jsonEncode(bodyPost)
    ).then(onValue)
    .catchError(onError);

    _loadingCircle = Status.loaded;
    notifyListeners();
    return response;
   }

static Future onValue(Response response)async{ 
var result;
final Map<String, dynamic> responseData = jsonDecode(response.body);

if(response.statusCode == 200){
 Blog blog =Blog.fromJson(responseData['data']);

    result={
      'status': 200,
      'message': responseData["message"],
      'data': blog
    };
  }else{
    result={
      'status': 500,
      'message': "Unable to create Post",
      'data': null
  };
  }

return result;
}

  static onError(error){
    return{
      'status': false,
      'message': "Unexpected Error Encountered!",
      'data': error
    };
  }

}