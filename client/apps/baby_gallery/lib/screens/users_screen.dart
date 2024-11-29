import 'package:baby_gallery/components/custom_app_bar.dart';
import 'package:baby_gallery/services/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<UsersProvider>(context, listen: false);

    return Scaffold(
      appBar: CustomAppBar(
        isPrevScreenAvailable: false,
        screenName: "Users",
      ),
      body: FutureBuilder<void>(
        future: usersProvider.fetchUsers(),
        builder: (context, snapshot) {
          // Data successfully loaded, display the users list
          return Consumer<UsersProvider>(
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

              if (provider.users.isEmpty) {
                return const Center(child: Text('No users available.'));
              }

              return ListView.builder(
                itemBuilder: (context, index) {
                  final user = provider.users[index];
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        "/albums",
                        arguments: user['id'],
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
                            child: Text(user['id'].toString()),
                          ),
                        ),
                        title: Text(
                          user['name'],
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontFamily: "open sans",
                          ),
                        ),
                        subtitle: Text(
                          user['email'],
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontFamily: "open sans",
                          ),
                        ),
                        trailing: const Icon(
                          Icons.double_arrow_rounded,
                          color: Color(0xFF0F1E3D),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: provider.users.length,
              );
            },
          );
        },
      ),
    );
  }
}