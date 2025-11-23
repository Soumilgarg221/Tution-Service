import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/course_model.dart';
import '../widgets/subject_card.dart';
import 'enroll.dart';
import 'about.dart';
import 'contact.dart';

class HomePage extends StatefulWidget {
  final VoidCallback toggleTheme;
  const HomePage({super.key, required this.toggleTheme});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CourseModel> courses = [];
  int hoveredIndex = -1;

  Future<void> loadCourses() async {
    final jsonData = await DefaultAssetBundle.of(context)
        .loadString('assets/json/courses.json');
    final List decoded = json.decode(jsonData);
    courses = decoded.map((e) => CourseModel.fromJson(e)).toList();
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset("assets/img/logo.png", height: 36),
            const SizedBox(width: 10),
            const Text("Tuition Services"),
          ],
        ),
        actions: _buildActions(context),
      ),

      drawer: _buildDrawer(context),

      body: courses.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : _buildScrollablePage(context),
    );
  }

  /// ------------------ SCROLLABLE CONTENT + FOOTER -------------------------
  Widget _buildScrollablePage(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 10),

          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  final c = courses[index];
                  return MouseRegion(
                    onEnter: (_) => setState(() => hoveredIndex = index),
                    onExit: (_) => setState(() => hoveredIndex = -1),
                    child: SubjectCard(
                      course: c,
                      imagePath: getImg(c.id),
                      isHovered: hoveredIndex == index,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EnrollPage(
                            subject: c.title,
                            description: c.longDescription,
                            imagePath: getImg(c.id),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          _buildFooter(context),
        ],
      ),
    );
  }

  /// ------------------ NAV BAR ACTIONS -------------------------
  List<Widget> _buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: widget.toggleTheme,
        icon: const Icon(Icons.dark_mode, color: Colors.white),
      ),
      _navButton("About", () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutPage()));
      }),
      _navButton("Contact", () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => const ContactPage()));
      }),
    ];
  }

  Widget _navButton(String text, VoidCallback fn) {
    return TextButton(
      onPressed: fn,
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }

  /// ------------------ HAMBURGER MENU -------------------------
  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF1565C0)),
            child: Center(
              child: Text("Menu", style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
          ),
          ListTile(
            title: const Text("Toggle Dark Mode"),
            leading: const Icon(Icons.dark_mode),
            onTap: widget.toggleTheme,
          ),
          ListTile(
            title: const Text("About"),
            leading: const Icon(Icons.info),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AboutPage()),
            ),
          ),
          ListTile(
            title: const Text("Contact"),
            leading: const Icon(Icons.call),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ContactPage()),
            ),
          ),
        ],
      ),
    );
  }

  /// ------------------ IMAGE MAPPER -------------------------
  String getImg(String id) {
    switch (id) {
      case "1":
        return "assets/img/math.png";
      case "2":
        return "assets/img/physics.png";
      case "3":
        return "assets/img/history.png";
      case "4":
        return "assets/img/chemistry.png";
      default:
        return "assets/img/logo.png";
    }
  }

  /// ------------------ FOOTER (FULL WIDTH) -------------------------
  Widget _buildFooter(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 850;

    return Container(
      width: double.infinity,
      color: const Color(0xFF1565C0),
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    _FooterLogoSection(),
                    SizedBox(height: 20),
                    _FooterCoursesSection(),
                    SizedBox(height: 20),
                    _FooterLinksSection(),
                    SizedBox(height: 20),
                    _FooterContactSection(),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    _FooterLogoSection(),
                    _FooterCoursesSection(),
                    _FooterLinksSection(),
                    _FooterContactSection(),
                  ],
                ),
          const SizedBox(height: 25),
          const Divider(color: Colors.white24),
          const SizedBox(height: 10),
          const Text(
            "© 2025 Tuition Services. All rights reserved.",
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

/// ------------------ FOOTER WIDGETS -------------------------
class _FooterLogoSection extends StatelessWidget {
  const _FooterLogoSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset("assets/img/logo.png", height: 55, color: Colors.white),
        const SizedBox(height: 8),
        const Text(
          "Tuition Services",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ],
    );
  }
}

class _FooterCoursesSection extends StatelessWidget {
  const _FooterCoursesSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        _FooterTitle("Courses"),
        SizedBox(height: 8),
        _FooterItem("Mathematics"),
        _FooterItem("Physics"),
        _FooterItem("History"),
        _FooterItem("Chemistry"),
      ],
    );
  }
}

class _FooterLinksSection extends StatelessWidget {
  const _FooterLinksSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        _FooterTitle("Useful Links"),
        SizedBox(height: 8),
        _FooterItem("About"),
        _FooterItem("Contact"),
        _FooterItem("Enroll"),
      ],
    );
  }
}

class _FooterContactSection extends StatelessWidget {
  const _FooterContactSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _FooterTitle("Contact"),
        const SizedBox(height: 8),
        const _FooterItem("tuition@example.com"),
        const _FooterItem("+91 98765 43210"),
        const _FooterItem("Your City, India"),
        const SizedBox(height: 10),
        Row(
          children: const [
            Icon(Icons.facebook, color: Colors.white, size: 22),
            SizedBox(width: 12),
            Icon(Icons.message, color: Colors.white, size: 22),
            SizedBox(width: 12),
            Icon(Icons.camera_alt, color: Colors.white, size: 22),
          ],
        ),
      ],
    );
  }
}

/// FOOTER TEXT WIDGETS
class _FooterTitle extends StatelessWidget {
  final String text;
  const _FooterTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
    );
  }
}

class _FooterItem extends StatelessWidget {
  final String text;
  const _FooterItem(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(color: Colors.white70, fontSize: 14),
    );
  }
}
