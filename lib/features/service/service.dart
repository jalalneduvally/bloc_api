import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/post_model.dart';
class RestApiService{
  Future<bool> addUserService(String title,String body)async{
    try{
      final Map<String,dynamic> map={
        "userId":"54",
        "title":title,
        "body":body,
      };
      http.Response response=await http.post(Uri.parse("https://jsonplaceholder.typicode.com/posts"),
      body: map);
      debugPrint("response body:${response.body}");
      if(response.statusCode==200){
        return true;
      }else{
        return false;
      }
    }catch(e){
      throw Exception(e);
    }
  }
  Future<PostModel> readUserService()async{
    try{
      http.Response response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts/1"));

      PostModel postModel=PostModel.fromJson(jsonDecode(response.body) as Map<String,dynamic>);
      return postModel;
    }catch (e){
      debugPrint("err:$e");
      throw Exception(e);
    }
  }
  Future<bool> updateUserService(dynamic data)async{
    try{
      http.Response response=await http.put(Uri.parse("https://jsonplaceholder.typicode.com/posts/1"),
      body: data);
      debugPrint("response body:${response.body}");
      if(response.statusCode ==200){
        return true;
      }else{
        return false;
      }
    }catch (e){
      throw Exception(e);
    }
  }

  Future<bool> deleteUserService(String id)async{
    try{
      http.Response response = await http.delete(Uri.parse("https://jsonplaceholder.typicode.com/posts/1"),
      body: {"id":id});
      if(response.statusCode ==200){
        return true;
      }else{
        return false;
      }
    }catch (e){
      throw Exception(e);
    }
  }
}