import 'package:flutter/material.dart';
import 'package:frqncy_app/src/screens/sign_in.dart';
import 'package:frqncy_app/src/services/auth_service.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = [
      "Account & Subscription",
      "Notifications",
      "Language",
      "Downloads",
      "Google Fit",
      "My Data",
      "Support",
      "Terms & Conditions",
      "Privacy Policy",
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF1B062B),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B062B),
        elevation: 0,
        title: const Text("Settings"),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: settings.length,
              separatorBuilder:
                  (_, __) => const Divider(color: Colors.white24, height: 1),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    settings[index],
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onTap: () {
                    // Handle each setting item tap
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  await AuthService().signOut();
                  if (!context.mounted) return;
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => SignInScreen()),
                    (_) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9B51E0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text("Log Out", style: TextStyle(fontSize: 16)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
