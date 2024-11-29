import 'package:baby_gallery/components/custom_app_bar.dart';
import 'package:flutter/material.dart';

class PhotoScreen extends StatelessWidget {
  const PhotoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve photo data from route arguments
    final Map<String, dynamic> photo =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: CustomAppBar(
        isPrevScreenAvailable: true,
        screenName: "Photo",
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
