import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:baby_gallery/services/auth_provider.dart';
import 'package:baby_gallery/services/gallery_provider.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Providers
    final galleryProvider =
        Provider.of<GalleryProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context);

    // Get album ID from route arguments
    int? albumId;
    albumId ??= ModalRoute.of(context)?.settings.arguments as int?;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Albums'),
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
      body: FutureBuilder<void>(
        future: galleryProvider.fetchGalleries(albumId),
        builder: (context, snapshot) {
          return Consumer<GalleryProvider>(
            builder: (context, provider, child) {
              // Loading state
              if (provider.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                );
              }

              // Error state
              if (provider.error != null) {
                return Center(child: Text(provider.error!));
              }

              // Empty state
              if (provider.gallery.isEmpty) {
                return const Center(child: Text('No photos available.'));
              }

              // Loaded state
              return GridView.builder(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 166,
                  childAspectRatio: 0.92,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  mainAxisExtent: 210,
                ),
                itemCount: provider.gallery.length,
                itemBuilder: (BuildContext ctx, index) {
                  final gallery = provider.gallery[index];

                  return Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xff4A576F),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: InkWell(
                      splashColor: Colors.white12,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          "/photo",
                          arguments: gallery,
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Thumbnail Image
                          SizedBox(
                            height: 150,
                            width: 150,
                            child: Hero(
                              tag: gallery['thumbnailUrl'],
                              child: Image.network(
                                gallery['thumbnailUrl'],
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          // Title
                          Expanded(
                            child: Text(
                              gallery['title'],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: "Open Sans",
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}