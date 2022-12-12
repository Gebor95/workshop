import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:workshop/helpers/http_service.dart';
import 'package:workshop/models/allblogs_model.dart';

class AllBlogsProvider with ChangeNotifier {
  List<Data> allBlogsList = [];
  List<Data> get allBlog => allBlogsList;
  
  //fetching online data
  Future fetchBlogs() async{
    try{
      //
      final resp = await get(Uri.parse(HttpService.blog));
      
       if (resp.statusCode == 200) {
        // decoding our online data body
        final jsonData= jsonDecode(resp.body);
        // loop through fetched data and store in allBlogsList
        for (var blogindex in jsonData['data']) {
          Data data = Data.fromJson(blogindex);

         allBlogsList.add(data);
        }
      }
    }on SocketException{
    throw  "Connection Error";
    
    }
    notifyListeners();
  }
}