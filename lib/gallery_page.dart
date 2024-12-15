// lib/gallery_page.dart
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'settings_page.dart';
import 'dashboard_page.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  final List<String> _photos = [];
  final List<List<String>> _comments = [];
  final List<int> _likes = [];
  final TextEditingController _commentController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  void _addComment(int index) {
    if (_commentController.text.isNotEmpty) {
      setState(() {
        _comments[index].add(_commentController.text);
        _commentController.clear();
      });
    }
  }

  Future<void> _addPhoto() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _photos.add(image.path);
        _comments.add([]);
        _likes.add(0);
      });
    }
  }

  void _likePhoto(int index) {
    setState(() {
      _likes[index]++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Gallery'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: _addPhoto,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFDCC1FF), // Light Lavender
                ),
                child: const Text('Add Photo'),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
              ),
              itemCount: _photos.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            File(_photos[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.thumb_up),
                            onPressed: () => _likePhoto(index),
                          ),
                          Text('${_likes[index]}'),
                          IconButton(
                            icon: const Icon(Icons.comment),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Add a Comment'),
                                    content: TextField(
                                      controller: _commentController,
                                      decoration: const InputDecoration(
                                        labelText: 'Enter your comment',
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          _addComment(index);
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Submit'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      Column(
                        children: _comments[index]
                            .map((comment) => Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(comment),
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.photo),
                label: 'Gallery',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
            currentIndex: 1,
            selectedItemColor: const Color(0xFFA294F9), // Dark Purple
            onTap: (index) {
              if (index == 0) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const DashboardPage()),
                );
              } else if (index == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              }
            },
          ),
          Positioned(
            bottom: 20,
            child: FloatingActionButton(
              onPressed: _addPhoto,
              backgroundColor: const Color(0xFFDCC1FF), // Light Lavender
              child: const Icon(Icons.add_a_photo),
            ),
          ),
        ],
      ),
    );
  }
}