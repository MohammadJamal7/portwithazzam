import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  static const List<Map<String, String>> faqs = [
    {
      'q': 'ما هي الخدمات التي تقدمها شركة العزام؟',
      'a': 'نقدم خدمات الاستيراد، التصدير، التخليص الجمركي، الشحن واللوجستيات، الاستشارات التجارية، وإدارة المخزون.'
    },
    {
      'q': 'كيف يمكنني طلب خدمة؟',
      'a': 'يمكنك اختيار الخدمة المطلوبة من التطبيق وتعبئة النموذج، وسيتم إرسال طلبك عبر واتساب مباشرة إلى فريقنا.'
    },
    {
      'q': 'هل يمكنني تتبع طلبي؟',
      'a': 'سيتم التواصل معك عبر واتساب أو الهاتف لمتابعة حالة طلبك بعد الإرسال.'
    },
    {
      'q': 'ما هي طرق الدفع المتاحة؟',
      'a': 'طرق الدفع يتم الاتفاق عليها حسب نوع الخدمة، وسيتم توضيحها عند التواصل معك.'
    },
    {
      'q': 'هل تقدمون استشارات مجانية؟',
      'a': 'نعم، نقدم استشارات أولية مجانية حول خدماتنا.'
    },
    {
      'q': 'كم تستغرق عملية الشحن أو التخليص؟',
      'a': 'تختلف المدة حسب نوع الخدمة والدولة، وسيتم إعلامك بالتفاصيل عند تقديم الطلب.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('الأسئلة الشائعة'),
          backgroundColor: const Color(0xFF1A3A52),
        ),
        body: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: faqs.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (context, i) => ExpansionTile(
            title: Text(faqs[i]['q']!, style: const TextStyle(fontWeight: FontWeight.bold)),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Text(faqs[i]['a']!),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
