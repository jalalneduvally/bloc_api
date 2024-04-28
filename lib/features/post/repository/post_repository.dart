import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:bloc_api/features/models/post_model.dart';

class PostRepository{
  static Future<List<PostModel>> fetchPosts()async{
    var client = http.Client();
    List<PostModel> posts=[];
    try {
      var response = await client.get(
          Uri.parse('https://jsonplaceholder.typicode.com/posts'));

      List result = jsonDecode(response.body);
      for( var a in result){
        PostModel post =PostModel.fromJson(a);
        posts.add(post);
      }
      return posts;
  } catch (e){
      log(e.toString());
      return [];
    }
}

  static Future<bool> addPost()async{
    var client = http.Client();
    List<PostModel> posts=[];
    try {
      var response = await client.post(
          Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      body: {
            "title":"Flutter Developer",
            "body":"jalal as a Good developer",
            "userId":"25",
      });
      if(response.statusCode>=200 && response.statusCode<300){
        return true;
      }else{
        return false;
      }
    } catch (e){
      log(e.toString());
      return false;
    }
  }
}