import 'package:e_commerce_clothing_store_app/presentation/screens/profiles/contact.dart';
import 'package:e_commerce_clothing_store_app/presentation/screens/profiles/notificationpage.dart';
import 'package:e_commerce_clothing_store_app/presentation/screens/profiles/profilepage.dart';
import 'package:e_commerce_clothing_store_app/presentation/screens/profiles/setting.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'capstone',
      home: Person(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Person extends StatefulWidget {
  const Person({super.key});

  @override
  State<Person> createState() => _PersonState();
}

class _PersonState extends State<Person> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 15),
            const CircleAvatar(radius: 45),
            const SizedBox(height: 10),
            const Text('Mark Adam'),
            const Text('markadam@gmail.com'),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                children: [
                  _buildListItem(
                    context,
                    icon: Icons.person,
                    title: 'Profile',
                    destination: const Profilepage(),
                  ),
                  _buildListItem(
                    context,
                    icon: Icons.settings,
                    title: 'Setting',
                    destination: const Setting(),
                  ),
                  _buildListItem(
                    context,
                    icon: Icons.mail,
                    title: 'Contact',
                    destination: const Contact(),
                  ),
                  _buildListItem(
                    context,
                    icon: Icons.share,
                    title: 'Share App',
                    destination: const Contact(),
                  ),
                  _buildListItem(
                    context,
                    icon: Icons.help,
                    title: 'Help',
                    destination: const Contact(),
                  ),
                  const SizedBox(height: 80),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const Notificationpage();
                            },
                          ),
                        );
                      },
                      child: const Text(
                        'Sign Out',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 84, 87, 88),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Widget destination,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      margin: const EdgeInsets.all(5),
      child: ListTile(
        minVerticalPadding: 5,
        leading: Icon(icon),
        title: Text(
          title,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destination),
          );
        },
      ),
    );
  }
}
