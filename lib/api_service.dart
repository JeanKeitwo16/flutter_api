import 'dart:convert';

import 'package:apiaula/post.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  // GET
  Future<List<Post>> getPosts() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) {
        return Post.fromMap(item);
      }).toList();
    }
    return [];
  }

  Future<Post?> createPost(Post post) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(post.toMap()),
    );
    if(response.statusCode == 201){
      print("Dado criado com sucesso");
        return Post.fromMap(jsonDecode(response.body));
    }
    return null;
  }

  Future<Post?> updatePost(Post post, int id) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(post.toMap()),
    );
    if(response.statusCode == 200){
      print("Dado atualizado com sucesso");
        return Post.fromMap(jsonDecode(response.body));
    }
    return null;
  }
  
  Future<void> deletePost(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$id'),
    );
    if(response.statusCode == 200){
      print("Dado apagado com sucesso");
    }
  }
}
