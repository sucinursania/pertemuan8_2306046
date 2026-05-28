import 'dart:convert';
import 'package:http/http.dart'as http;
import '../models/post_model.dart';

class PostService {
  static Future<List<PostModel>> getPost() async{
    // varibel utk manggil api
    final res = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );

    if (res.statusCode == 200) {
      List data = jsonDecode(res.body);
      return data.map((e)=> PostModel.fromJson(e)).toList();
    }
    else {
      throw Exception('Gagal mengambil daqta');
    }
  }
}

