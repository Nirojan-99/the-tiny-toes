import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:baby_gallery/services/auth_provider.dart';

class PhotoScreen extends StatelessWidget {
  const PhotoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve AuthProvider
    final authProvider = Provider.of<AuthProvider>(context);

    // Retrieve photo data from route arguments
    final Map<String, dynamic> photo =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () => authProvider.logout(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display photo
              Hero(
                tag: photo['thumbnailUrl']!,
                child: Image.network(
                  photo['url'],
                  fit: BoxFit.fitWidth,
                ),
              ),
              // Display photo title
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  photo['title'],
                  overflow: TextOverflow.ellipsis,
                  maxLines: 10,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: "Open Sans",
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
