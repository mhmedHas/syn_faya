import 'package:flutter/material.dart';
import 'package:v1/generated/l10n.dart';
import 'package:v1/helper/Constanat.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).privacy,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: primary, // Color of the appBar
        automaticallyImplyLeading:
            false, // This hides the default hamburger icon
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // Back arrow icon
          onPressed: () {
            // Navigator.of(context).push(MaterialPageRoute(
            //     builder: (context) =>
            //         HomeScreen())); // This will take the user back to the previous screen

            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              'This is our privacy policy text. It explains how we collect, use, and protect your personal data. We respect your privacy and are committed to ensuring that your data is kept secure and used only for its intended purpose.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 16,
                    height: 1.5,
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              '1. Data Collection:',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'We collect personal information such as your name, email, and phone number when you use our service.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Text(
              '2. Data Usage:',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your personal data is used only to provide and improve our services and will not be shared with third parties without your consent.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Text(
              '3. Data Protection:',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'We implement various security measures to protect your personal information, including encryption and secure data storage.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Text(
              'By using our service, you agree to the terms outlined in this privacy policy.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
