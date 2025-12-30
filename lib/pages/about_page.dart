import 'package:flutter/material.dart';
import '../pages/why_choose_us_page.dart';
import '../pages/terms_page.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Color(0xFF1A3A52),
              ),
              child: const Text(
                'من نحن',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.star, color: Color(0xFFD4A574)),
                      label: const Text('لماذا نحن؟'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1A3A52),
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => const WhyChooseUsPage()));
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'عن شركة العزام',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A3A52),
                    ),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'تأسست شركة العزام بهدف توفير خدمات استيراد وتصدير متميزة وموثوقة. نتمتع بخبرة طويلة في مجال التجارة الخارجية وعلاقات قوية مع الموردين والعملاء حول العالم.',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black87,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 24),
                  // ...existing company info and values...
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
