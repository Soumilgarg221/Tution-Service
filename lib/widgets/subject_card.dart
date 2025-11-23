import 'package:flutter/material.dart';
import '../models/course_model.dart';

class SubjectCard extends StatelessWidget {
  final CourseModel course;
  final String imagePath;
  final bool isHovered;
  final VoidCallback onTap;

  const SubjectCard({
    super.key,
    required this.course,
    required this.imagePath,
    required this.isHovered,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          transformAlignment: Alignment.center,
          transform: isHovered ? (Matrix4.identity()..scale(1.04)) : Matrix4.identity(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: isDark ? const Color(0xFF22304A) : const Color(0xFFDDE8FF),
            boxShadow: [
              BoxShadow(
                color: isHovered
                    ? Colors.blue.withOpacity(0.35)
                    : Colors.black.withOpacity(0.08),
                blurRadius: isHovered ? 20 : 8,
                spreadRadius: isHovered ? 3 : 1,
                offset: Offset(0, isHovered ? 8 : 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ★ BIG ICON AREA
                Expanded(
                  flex: 55,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                // ★ COURSE TITLE + SHORT DESC
                Expanded(
                  flex: 25,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        course.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : const Color(0xFF0D47A1),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        course.description,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          color: isDark ? Colors.white70 : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),

                // ★ BUTTON
                Expanded(
                  flex: 20,
                  child: Center(
                    child: ElevatedButton(
                      onPressed: onTap,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1565C0),
                        foregroundColor: Colors.white,
                        shape: const StadiumBorder(),
                        padding:
                            const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      ),
                      child: const Text("Enroll"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
