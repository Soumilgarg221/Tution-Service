import 'package:flutter/material.dart';
import 'enroll.dart';
import 'about.dart';
import 'contact.dart';

class HomePage extends StatelessWidget {
  final VoidCallback toggleTheme;
  const HomePage({super.key, required this.toggleTheme});

  final List<Map<String, String>> subjects = const [
    {
      "name": "ENGLISH",
      "img": "assets/img/eng.png",
      "short": "Improve vocabulary, grammar\nand fluent communication.",
      "long":
          "Our English classes focus on building strong grammar, vocabulary, reading and writing skills. Students learn to express themselves clearly, write better answers, and gain confidence in speaking."
    },
    {
      "name": "MATHS",
      "img": "assets/img/maths.png",
      "short": "Master concepts, logic\nand problem solving.",
      "long":
          "Maths is taught step-by-step from basics to advanced topics. We focus on concepts, formulas, problem solving techniques and exam oriented practice so students stop fearing numbers."
    },
    {
      "name": "SCIENCE",
      "img": "assets/img/microscope.png",
      "short": "Understand experiments,\nreasoning and real-world science.",
      "long":
          "Science classes explain every chapter with real-life examples and simple experiments. We focus on understanding concepts in Physics, Chemistry and Biology instead of rote learning."
    },
    {
      "name": "COMPUTER",
      "img": "assets/img/online-test.png",
      "short": "Learn basics, typing &\ndigital knowledge.",
      "long":
          "Computer classes cover basic operations, typing skills, office tools and safe internet usage. Students become comfortable with using computers for studies and projects."
    },
    {
      "name": "SOCIAL STUDIES",
      "img": "assets/img/social-science.png",
      "short": "Know history, civics,\ngeography and culture.",
      "long":
          "Social Studies is taught through stories, maps and diagrams. We help students remember important dates, civics concepts, and geography topics with clear explanations."
    },
    {
      "name": "HINDI",
      "img": "assets/img/vowel.png",
      "short": "Improve reading, writing\nand grammar skills.",
      "long":
          "Hindi classes focus on reading fluently, writing proper answers and understanding grammar. We also work on comprehension and creative writing to score better in exams."
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/img/logo.png',
              height: 40,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.school, color: Colors.white),
            ),
            const SizedBox(width: 10),
            const Text('Tuition Services'),
          ],
        ),
        actions: [
          IconButton(
            onPressed: toggleTheme,
            icon: Icon(
              isDark ? Icons.light_mode : Icons.dark_mode,
              color: Colors.white,
            ),
          ),
          if (MediaQuery.of(context).size.width > 700)
            TextButton(
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const AboutPage())),
              child: const Text('About', style: TextStyle(color: Colors.white)),
            ),
          if (MediaQuery.of(context).size.width > 700)
            TextButton(
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const ContactPage())),
              child: const Text('Contact', style: TextStyle(color: Colors.white)),
            ),
        ],
      ),

      drawer: MediaQuery.of(context).size.width <= 700
          ? Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(color: Theme.of(context).primaryColor),
                    child: const Center(
                      child: Text("MENU",
                          style: TextStyle(color: Colors.white, fontSize: 22)),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.info),
                    title: const Text("About"),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const AboutPage()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.contact_mail),
                    title: const Text("Contact"),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const ContactPage()));
                    },
                  ),
                ],
              ),
            )
          : null,

      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: LayoutBuilder(
                    builder: (context, c) {
                      int count = 3;
                      if (c.maxWidth < 1200) count = 2;
                      if (c.maxWidth < 700) count = 1;

                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: subjects.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: count,
                          childAspectRatio: c.maxWidth < 700 ? 1 : 0.92,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                        ),
                        itemBuilder: (_, i) => _hoverCard(context, subjects[i]),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _hoverCard(BuildContext context, Map<String, String> s) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return StatefulBuilder(builder: (_, set) {
      bool hover = false;

      return MouseRegion(
        onEnter: (_) => set(() => hover = true),
        onExit: (_) => set(() => hover = false),
        cursor: SystemMouseCursors.click,
        child: AnimatedScale(
          duration: const Duration(milliseconds: 90),
          scale: (MediaQuery.of(context).size.width > 700 && hover) ? 1.12 : 1.0,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => EnrollPage(
                            subject: s['name']!,
                            description: s['long']!,
                            imagePath: s['img']!,
                          )));
            },
            child: Card(
              elevation: 3,
              color: isDark ? const Color(0xFF1E293B) : Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 70, child: Image.asset(s['img']!, fit: BoxFit.contain)),
                    const SizedBox(height: 8),
                    Text(s['name']!,
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : const Color(0xFF0D47A1))),
                    const SizedBox(height: 5),
                    Text(s['short']!,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 13, color: isDark ? Colors.white70 : Colors.black87)),
                    const SizedBox(height: 8),

                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => EnrollPage(
                                      subject: s['name']!,
                                      description: s['long']!,
                                      imagePath: s['img']!,
                                    )));
                      },
                      child: const Text("Enroll", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildFooter(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      color: isDark ? const Color(0xFF0A2342) : const Color(0xFF0D47A1),
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MediaQuery.of(context).size.width < 700
                ? MainAxisAlignment.center
                : MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _FooterLogo(),
              _FooterCol(title: "Courses", list: [
                "English", "Maths", "Science", "Computer", "Social Studies", "Hindi"
              ]),
              _FooterCol(title: "Useful Links", list: [
                "About", "Contact", "Enroll"
              ]),
              _FooterContact(),
            ],
          ),
          const SizedBox(height: 20),
          Divider(color: isDark ? Colors.white24 : Colors.white30),
          const SizedBox(height: 10),
          Text("© 2025 Tuition Services. All rights reserved.",
              style: TextStyle(color: isDark ? Colors.white70 : Colors.white70, fontSize: 12)),
          const SizedBox(height: 5),
          Text("Designed and Developed by You",
              style: TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                  fontSize: 12)),
        ],
      ),
    );
  }
}

// ---------------- FOOTER WIDGETS ----------------

class _FooterLogo extends StatelessWidget {
  const _FooterLogo();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset("assets/img/logo.png", height: 55,
            errorBuilder: (_, __, ___) =>
                const Icon(Icons.school, color: Colors.white, size: 50)),
        const SizedBox(height: 10),
        const Text("Tuition Services",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
      ],
    );
  }
}

class _FooterCol extends StatelessWidget {
  final String title;
  final List<String> list;
  const _FooterCol({required this.title, required this.list});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style:
                const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 10),
        for (var e in list)
          Text(e, style: const TextStyle(color: Colors.white70)),
      ],
    );
  }
}

class _FooterContact extends StatelessWidget {
  const _FooterContact();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text("Contact",
            style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
        SizedBox(height: 10),
        Text("tuition@example.com\n+91 98765 43210",
            style: TextStyle(color: Colors.white70)),
        SizedBox(height: 10),
        Row(
          children: [
            Icon(Icons.facebook, color: Colors.white, size: 22),
            SizedBox(width: 10),
            Icon(Icons.chat, color: Colors.white, size: 22),
            SizedBox(width: 10),
            Icon(Icons.camera_alt, color: Colors.white, size: 22),
          ],
        )
      ],
    );
  }
}
