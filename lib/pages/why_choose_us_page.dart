import 'package:flutter/material.dart';

class WhyChooseUsPage extends StatelessWidget {
  const WhyChooseUsPage({super.key});

  static const List<String> strengths = [
    'خبرة تزيد عن 15 سنة في مجال الاستيراد والتصدير.',
    'فريق عمل محترف ومتخصص في جميع الخدمات.',
    'شراكات مع شركات نقل وتخليص موثوقة محلياً ودولياً.',
    'خدمة عملاء سريعة واستجابة فورية عبر واتساب والهاتف.',
    'أسعار تنافسية وشفافية في جميع التعاملات.',
    'شهادات جودة واعتمادات رسمية.',
    'توصيات وشهادات من عملائنا.',
  ];

  static const List<String> testimonials = [
    '"خدمة ممتازة وسرعة في الإنجاز!" — عميل من عمان',
    '"تعامل راقٍ واحترافية عالية." — عميل من إربد',
    '"أنصح بالتعامل مع شركة العزام دائماً." — عميل من الزرقاء',
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('لماذا نحن؟'),
          backgroundColor: const Color(0xFF1A3A52),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text('مميزات شركة العزام', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1A3A52))),
            const SizedBox(height: 12),
            ...strengths.map((s) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: Color(0xFFD4A574), size: 20),
                  const SizedBox(width: 10),
                  Expanded(child: Text(s, style: const TextStyle(fontSize: 15))),
                ],
              ),
            )),
            const SizedBox(height: 24),
            const Text('آراء العملاء', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFF1A3A52))),
            const SizedBox(height: 10),
            ...testimonials.map((t) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  const Icon(Icons.format_quote, color: Color(0xFFD4A574), size: 18),
                  const SizedBox(width: 8),
                  Expanded(child: Text(t, style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic))),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
