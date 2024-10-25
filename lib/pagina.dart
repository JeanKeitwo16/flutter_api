import 'package:apiaula/post.dart';
import 'package:flutter/material.dart';
import 'package:apiaula/api_service.dart';

class Pagina extends StatefulWidget {
  const Pagina({super.key});

  @override
  State<Pagina> createState() => _PaginaState();
}

class _PaginaState extends State<Pagina> {
  final ApiService apiService = ApiService();

  List<Post> posts = [];
  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  void _loadPosts() async {
    var aux = await apiService.getPosts();
    setState(() {
      posts = aux;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "API - Exemplo",
          ),
          backgroundColor: Colors.blue),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 10,
              child: ListTile(
                title: Text('${posts[index].userId} - ${posts[index].id}'),
                subtitle: Text('${posts[index].title} - ${posts[index].body}'),
              ),
            ),
          );
        },
      ),
    );
  }
}
