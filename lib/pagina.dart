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

  void _createPost() async {
    Post novoPost = Post(userId: 200, id: 200, title: 'legal', body: 'legal');
    Post? aux = await apiService.createPost(novoPost);
    if (aux != null) {
      print('${aux.userId} - ${aux.id} - ${aux.title} - ${aux.body}');
    }
    _loadPosts();
  }

  void _updatePost() async {
    Post updatePost = Post(
        userId: 200,
        id: 200,
        title: 'Titulo Atualizado',
        body: 'Informações atualizadas');
    Post? aux = await apiService.updatePost(updatePost, 1);
    if (aux != null) {
      print('${aux.userId} - ${aux.id} - ${aux.title} - ${aux.body}');
    }
    _loadPosts();
  }

  void _deletePost() async {
    await apiService.deletePost(1);
    _loadPosts();
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
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
        FloatingActionButton(onPressed: _createPost, child: const Icon(Icons.add)),
        FloatingActionButton(onPressed: _updatePost, child: const Icon(Icons.update)),
        FloatingActionButton(onPressed: _deletePost, child: const Icon(Icons.delete)),
      ]),
    );
  }
}
