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
        backgroundColor: const Color(0xFF1565C0),
        title: Text(subject, style: const TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // IMAGE
                SizedBox(
                  height: 160,
                  child: Image.asset(imagePath, fit: BoxFit.contain),
                ),

                const SizedBox(height: 20),

                // TITLE
                Text(
                  subject,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0D47A1),
                  ),
                ),

                const SizedBox(height: 15),

                // LONG DESCRIPTION
                Text(
                  description,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(fontSize: 16, height: 1.4),
                ),

                const SizedBox(height: 35),

                // ---- BUTTONS SECTION ----
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ENROLL BUTTON
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0D47A1),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text("Enroll Now", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),

                    const SizedBox(width: 20),

                    // WHATSAPP BUTTON (NOW SAME STYLE)
                    ElevatedButton.icon(
                      onPressed: launchWhatsApp,
                      icon: const Icon(Icons.message),
                      label: const Text(
                        "Chat on WhatsApp",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0D47A1),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// 🔵 WHATSAPP LAUNCHER
void launchWhatsApp() async {
  const phone = "+917827460182"; // CHANGE to your number
  const message = "Hello, I want more details about your tuition services!";

  final whatsappUrl = Uri.parse("https://wa.me/$phone?text=$message");

  if (!await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication)) {
    throw "Could not open WhatsApp";
  }
}
