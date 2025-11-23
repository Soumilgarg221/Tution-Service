import 'package:flutter/material.dart';
import 'enroll.dart';
import 'about.dart';
import 'contact.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final List<Map<String, String>> subjects = const [
    {
      "name": "English",
      "img": "assets/img/eng.png",
      "short": "Improve vocabulary, grammar\nand fluent communication.",
      "long":
          "Our English classes focus on building strong grammar, vocabulary, reading and writing skills. "
          "Students learn to express themselves clearly, write better answers, and gain confidence in speaking."
    },
    {
      "name": "Maths",
      "img": "assets/img/maths.png",
      "short": "Master concepts, logic\nand problem solving.",
      "long":
          "Maths is taught step-by-step from basics to advanced topics. We focus on concepts, formulas, problem solving "
          "techniques and exam oriented practice so that students stop fearing numbers."
    },
    {
      "name": "Science",
      "img": "assets/img/microscope.png",
      "short": "Understand experiments,\nreasoning and real-world science.",
      "long":
          "Science classes explain every chapter with real-life examples and simple experiments. "
          "We focus on understanding concepts in Physics, Chemistry and Biology instead of rote learning."
    },
    {
      "name": "Computer",
      "img": "assets/img/online-test.png",
      "short": "Learn basics, typing &\ndigital knowledge.",
      "long":
          "Computer classes cover basic operations, typing skills, office tools and safe internet usage. "
          "Students become comfortable with using computers for studies and projects."
    },
    {
      "name": "Social Studies",
      "img": "assets/img/social-science.png",
      "short": "Know history, civics,\ngeography and culture.",
      "long":
          "Social Studies is taught through stories, maps and diagrams. We help students remember important dates, "
          "concepts in civics, and geography topics with clear explanations."
    },
    {
      "name": "Hindi",
      "img": "assets/img/vowel.png",
      "short": "Improve reading, writing\nand grammar skills.",
      "long":
          "Hindi classes focus on reading fluently, writing proper answers and understanding grammar. "
          "We also work on comprehension and creative writing to score better in exams."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/img/logo.png',
              height: 40,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.school, color: Colors.white);
              },
            ),
            const SizedBox(width: 10),
            const Text('Tuition Services'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AboutPage()),
            ),
            child: const Text('About', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ContactPage()),
            ),
            child: const Text('Contact', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount = 3;
          if (constraints.maxWidth < 1200) crossAxisCount = 2;
          if (constraints.maxWidth < 700) crossAxisCount = 1;

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: GridView.builder(
                  itemCount: subjects.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio:
                        constraints.maxWidth < 700 ? 1.05 : 1.0,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemBuilder: (context, index) {
                    final s = subjects[index];
                    return Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Image.asset(
                                s['img']!,
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              s['name']!,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0D47A1),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              s['short']!,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => EnrollPage(
                                      subject: s['name']!,
                                      description: s['long']!,
                                      imagePath: s['img']!,
                                    ),
                                  ),
                                );
                              },
                              child: const Text('Enroll'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
  color: const Color(0xFF0D47A1), // Dark Navy Blue
  padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 40),
  child: Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---------------- Logo ----------------
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/img/logo.png",
                height: 55,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.school, color: Colors.white, size: 50),
              ),
              const SizedBox(height: 10),
              Text(
                "Tuition Services",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ],
          ),

          // ---------------- Courses ----------------
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Courses",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
              SizedBox(height: 10),
              Text("English", style: TextStyle(color: Colors.white70)),
              Text("Maths", style: TextStyle(color: Colors.white70)),
              Text("Science", style: TextStyle(color: Colors.white70)),
              Text("Computer", style: TextStyle(color: Colors.white70)),
              Text("Social Studies", style: TextStyle(color: Colors.white70)),
              Text("Hindi", style: TextStyle(color: Colors.white70)),
            ],
          ),

          // ---------------- Useful Links ----------------
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Useful Links",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
              SizedBox(height: 10),
              Text("About", style: TextStyle(color: Colors.white70)),
              Text("Contact", style: TextStyle(color: Colors.white70)),
              Text("Enroll", style: TextStyle(color: Colors.white70)),
            ],
          ),

          // ---------------- Contact + Social ----------------
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Contact",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
              SizedBox(height: 10),
              Text("tuition@example.com\n+91 98765 43210",
                  style: TextStyle(color: Colors.white70)),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.facebook, color: Colors.white, size: 22),
                  SizedBox(width: 10),
                  Icon(Icons.chat, color: Colors.white, size: 22), // whatsapp alt
                  SizedBox(width: 10),
                  Icon(Icons.camera_alt, color: Colors.white, size: 22), // insta alt
                ],
              )
            ],
          ),
        ],
      ),

      SizedBox(height: 20),
      Divider(color: Colors.white24),
      SizedBox(height: 10),

      Text("© 2025 Tuition Services. All rights reserved.",
          style: TextStyle(color: Colors.white70, fontSize: 12)),

      GestureDetector(
        onTap: () {}, // can link portfolio later
        child: Padding(
          padding: EdgeInsets.only(top: 5),
          child: Text("Designed and Developed by You",
              style: TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                  fontSize: 12)),
        ),
      ),
    ],
  ),
)


    );
  }
}
