import 'package:flutter/material.dart';
import 'models/post_model.dart';
import 'service/post_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pertemuan 8 - Consume API',
      home: PostPage(),
    );
  }
}

class PostPage extends StatefulWidget {
  @override
  State<PostPage> createState() => _PostPageState();
}
 class _PostPageState extends State<PostPage>{
  late Future<List<PostModel>> futurePosts;

  @override
  void initState(){
    super.initState();
    futurePosts = PostService.getPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Consume API",
          style: TextStyle(color: Colors.pink, fontSize: 18, fontWeight: .bold),
        ),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<List<PostModel>>(
        future: futurePosts,
        builder: (context, snapshot) {
          if (snapshot.hasData){
            final posts = snapshot.data!;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return Card(
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text(post.id.toString()),
                      Text(post.title, style: TextStyle(fontWeight: .bold)),
                      Text(post.body)
                    ],
                  ),
                );
              },
            );
          }else if (snapshot.hasError){
            return Center(child: Text('Error: ${snapshot.error}'));
          }else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

  


  