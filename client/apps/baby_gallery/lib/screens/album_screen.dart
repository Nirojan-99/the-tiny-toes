import 'package:baby_gallery/components/custom_app_bar.dart';
import 'package:baby_gallery/services/album_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlbumScreen extends StatelessWidget {
  const AlbumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final albumsProvider = Provider.of<AlbumsProvider>(context, listen: false);

    int? userId;

    userId ??= ModalRoute.of(context)?.settings.arguments as int?;

    return Scaffold(
      appBar: CustomAppBar(
        isPrevScreenAvailable: true,
        screenName: "Albums",
      ),
      body: FutureBuilder<void>(
        future: albumsProvider.fetchAlbums(userId),
        builder: (context, snapshot) {
          // Data successfully loaded, display the users list
          return Consumer<AlbumsProvider>(
            builder: (context, provider, child) {
              if (provider.isLoading) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: Colors.white,
                ));
              }

              // Show error message if fetching fails
              if (provider.error != null) {
                return Center(child: Text(provider.error!));
              }

              if (provider.albums.isEmpty) {
                return const Center(child: Text('No albums available.'));
              }

              return ListView.builder(
                itemBuilder: (context, index) {
                  final album = provider.albums[index];
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        "/gallery",
                        arguments: album['id'],
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xff4A576F),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: const Color(0xFF0F1E3D),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              album['title'][0].toUpperCase(),
                            ),
                          ),
                        ),
                        title: Text(
                          album['title'],
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontFamily: "open sans",
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: provider.albums.length,
              );
            },
          );
        },
      ),
    );
  }
}