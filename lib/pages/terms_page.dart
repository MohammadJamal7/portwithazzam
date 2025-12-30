import 'package:flutter/material.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  static const String _termsText = '''
شروط الخدمة

مرحباً بكم في تطبيق شركة العزام للاستيراد والتصدير. باستخدامك لهذا التطبيق، فإنك توافق على الالتزام بالشروط والأحكام التالية:

1. التعريفات
• "الخدمة": أي ميزات أو محتوى يتم توفيره من خلال التطبيق.

2. استخدام الخدمة
• لا يجوز استخدام التطبيق لأي غرض غير قانوني أو يخل بحقوق الغير.
• المستخدم مسؤول عن دقة المعلومات التي يقدمها عند طلب الخدمات.

3. الطلبات والتواصل
• التطبيق يقوم بمساعدة المستخدم على التواصل مع الشركة (مثل فتح رسالة واتساب)؛ الطلبات لا تُرسل أو تُنفذ تلقائياً دون تأكيد المستخدم.

4. المسؤولية
• الشركة لا تتحمل أي مسؤولية عن خسائر غير مباشرة أو تبعية ناجمة عن استخدام التطبيق.

5. التغييرات
• تحتفظ شركة العزام بالحق في تعديل شروط الخدمة في أي وقت، وسيتم نشر أي تحديث في هذه الصفحة.

6. القانون المطبق
• تخضع هذه الشروط وتفسر وفقاً لقوانين المملكة الأردنية الهاشمية.

إذا كانت لديك أي أسئلة حول شروط الخدمة هذه، يمكنك التواصل معنا عبر معلومات الاتصال المتوفرة في التطبيق.
''';

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('شروط الخدمة'),
          backgroundColor: const Color(0xFF1A3A52),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
                ),
                child: Text(
                  _termsText,
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontSize: 15, height: 1.6, color: Colors.black87),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
