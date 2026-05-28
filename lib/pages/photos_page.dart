import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'photos_page.dart';
import '../models/photo_model.dart';

class PhotosPage extends StatefulWidget {
  const PhotosPage({super.key});

  @override
  State<PhotosPage> createState() => _PhotosPageState();
}

class _PhotosPageState extends State<PhotosPage> {
  List<PhotoModel> photos = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPhotos();
  }

  Future<void> fetchPhotos() async {
    final response = await http.get(
      Uri.parse(
        'https://picsum.photos/v2/list?page=2&limit=10',
      ),
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);

      setState(() {
        photos =
            data.map((json) => PhotoModel.fromJson(json)).toList();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Photos Gallery"),
        centerTitle: true,
        elevation: 0,
      backgroundColor:Color.fromARGB(255, 218, 149, 172)
      ),
      body:
          isLoading
              ? const Center(
                child: CircularProgressIndicator(),
              ): 
              ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: photos.length,
                itemBuilder: (context, index) {
                  final photo = photos[index];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius:
                              const BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                          child: Image.network(
                            'https://picsum.photos/id/${photo.id}/500/300',
                            height: 220,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            photo.author,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
    );
  }
}