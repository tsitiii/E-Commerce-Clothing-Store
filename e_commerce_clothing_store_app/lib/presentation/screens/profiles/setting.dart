import 'package:e_commerce_clothing_store_app/presentation/screens/profiles/notificationpage.dart';
import 'package:e_commerce_clothing_store_app/presentation/screens/profiles/profilepage.dart';
import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Settings',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 5),
            const Row(
              children: [
                SizedBox(width: 10),
                Text('Account', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 5),
            InkWell(
              child: Container(
                padding: const  EdgeInsets.all(7),
                margin: const  EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    CircleAvatar(radius: 28),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Mark Adam'),
                          Text('markadam@gmail.com'),
                        ],
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Profilepage();
                    },
                  ),
                );
              },
            ),
            SizedBox(height: 15),
            Divider(),
            SizedBox(height: 15),
            Row(
              children: [
                SizedBox(width: 10),
                Text(
                  'Setting',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 5),
            Expanded(
              child: ListView(
                children: [
                  _buildListItem(
                    context,
                    icon: Icons.notifications,
                    title: 'Notificaton',
                    destination: Notificationpage(),
                  ),
                  _buildListItem(
                    context,
                    icon: Icons.language,
                    title: 'Language',
                    destination: Notificationpage(),
                  ),
                  _buildListItem(
                    context,
                    icon: Icons.privacy_tip,
                    title: 'Privacy',
                    destination: Notificationpage(),
                  ),
                  _buildListItem(
                    context,
                    icon: Icons.support_agent,
                    title: 'Help Center',
                    destination: Notificationpage(),
                  ),
                  _buildListItem(
                    context,
                    icon: Icons.info,
                    title: 'About Us',
                    destination: Notificationpage(),
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
      margin: EdgeInsets.all(5),
      child: ListTile(
        leading: Icon(icon),
        title: Text(
          title,
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
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
