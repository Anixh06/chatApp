
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/services/theme_provider.dart';
import 'package:chat_app/services/auth/auth_service.dart';

class SettingsPage extends StatelessWidget{
  const SettingsPage ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          ),
       ),
      body: Column(
        children: [
          // Dark Mode Toggle
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return ListTile(
                title: Text('Dark Mode'),
                subtitle: Text(themeProvider.isDarkMode ? 'Enabled' : 'Disabled'),
                trailing: Switch(
                  value: themeProvider.isDarkMode,
                  onChanged: (value) {
                    themeProvider.toggleTheme();
                  },
                ),
              );
            },
          ),
          
          // Sign Out Button
          ListTile(
            title: Text('Sign Out'),
            leading: Icon(Icons.logout),
            onTap: () async {
              // Show confirmation dialog
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Sign Out'),
                    content: Text('Are you sure you want to sign out?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () async {
                          Navigator.of(context).pop();
                          await AuthService().signOut();
                        },
                        child: Text('Sign Out'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
