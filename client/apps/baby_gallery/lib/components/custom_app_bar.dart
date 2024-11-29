import 'package:baby_gallery/services/auth_provider.dart';
import 'package:baby_gallery/services/storage_service.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String screenName;
  final bool isPrevScreenAvailable;
  CustomAppBar(
      {super.key,
      required this.screenName,
      required this.isPrevScreenAvailable});

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  final StorageService _storageService = StorageService();
  final AuthProvider _authProvider = AuthProvider();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _storageService.getUsername(), // Fetch username asynchronously
      builder: (context, snapshot) {
        // Default title while waiting
        String userName = '';
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            userName = snapshot.data!;
          } else {
            Navigator.pushReplacementNamed(context, "/login");
          }
        }

        return AppBar(
          title: Text(screenName),
          leading: Row(children: [
            isPrevScreenAvailable
                ? IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  )
                : const SizedBox(),
          ]),
          actions: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
              decoration: const BoxDecoration(
                  color: Color(0xffeeb51d),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Text(
                userName,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.white),
              onPressed: () => _authProvider.logout(context),
            ),
          ],
        );
      },
    );
  }
}