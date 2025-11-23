import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EnrollPage extends StatelessWidget {
  final String subject;
  final String description;
  final String imagePath;

  const EnrollPage({
    super.key,
    required this.subject,
    required this.description,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(subject),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  imagePath,
                  height: 120,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 20),
                Text(
                  'Enroll for $subject',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                Text(
                  description,
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                ElevatedButton.icon(
                  icon: const Icon(Icons.chat),
                  onPressed: () {
                    launchUrl(Uri.parse('https://wa.me/919876543210'));
                  },
                  label: const Text('Chat on WhatsApp'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
