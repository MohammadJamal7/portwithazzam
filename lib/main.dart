import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart' as sp;
import 'pages/services_page.dart';
import 'pages/home_page.dart';
import 'pages/about_page.dart';
import 'pages/contact_page.dart';
import 'pages/terms_page.dart';
import 'pages/faq_page.dart';
import 'pages/why_choose_us_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'شركة العزام',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // Force RTL for the entire app to ensure Arabic layouts are correct
      builder: (context, child) => Directionality(
        textDirection: TextDirection.rtl,
        child: child!,
      ),
      supportedLocales: const [
        Locale('ar'),
        Locale('en'),
      ],
      locale: const Locale('ar'),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1A3A52), // Deep Navy Blue
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Cairo',
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentPageIndex = 0;
  bool _privacyAccepted = false;

  @override
  void initState() {
    super.initState();
    _checkPrivacyAccepted();
  }

  Future<void> _checkPrivacyAccepted() async {
    final prefs = await sp.SharedPreferences.getInstance();
    final accepted = prefs.getBool('privacyAccepted') ?? false;
    if (!accepted) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _showPrivacyDialog());
    } else {
      setState(() => _privacyAccepted = true);
    }
  }

  Future<void> _showPrivacyDialog() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('سياسة الخصوصية'),
        content: SingleChildScrollView(
          child: Text(_privacyPolicyText, textAlign: TextAlign.right),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              final prefs = await sp.SharedPreferences.getInstance();
              await prefs.setBool('privacyAccepted', true);
              setState(() => _privacyAccepted = true);
              Navigator.of(context).pop();
            },
            child: const Text('موافق'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text('شركة العزام'),
            Text('الاستيراد والتصدير', style: TextStyle(fontSize: 14)),
          ],
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF1A3A52),
        foregroundColor: Colors.white,
        elevation: 4,
        actions: [
          IconButton(
            icon: const Icon(Icons.question_answer),
            tooltip: 'الأسئلة الشائعة',
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const FAQPage()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            tooltip: 'مشاركة التطبيق',
            onPressed: () async {
              const appLink = 'https://azzam-company.com/app';
              final text = 'جرب تطبيق شركة العزام للاستيراد والتصدير:\n$appLink';
              await launchUrl(Uri.parse('https://wa.me/?text=${Uri.encodeComponent(text)}'), mode: LaunchMode.externalApplication);
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentPageIndex,
        children: [
          HomePage(),
          ServicesPage(),
          AboutPage(),
          ContactPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        backgroundColor: const Color(0xFF1A3A52),
        selectedItemColor: const Color(0xFFD4A574),
        unselectedItemColor: Colors.white70,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'الخدمات',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'عننا',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.phone),
            label: 'التواصل',
          ),
        ],
      ),
    );
  }
}

// Services page is moved to: lib/pages/services_page.dart
// Existing implementation extracted to keep main.dart minimal.


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
                  const SizedBox(height: 8),
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

                  // Company info card
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'معلومات الشركة',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1A3A52),
                            ),
                            textAlign: TextAlign.right,
                          ),
                          const SizedBox(height: 12),
                          _buildInfoRow(Icons.business, 'الاسم', 'شركة العزام للاستيراد والتصدير'),
                          const SizedBox(height: 8),
                          _buildInfoRow(Icons.confirmation_number, 'رقم السجل التجاري', 'غير متوفر - يرجى التحديث'),
                          const SizedBox(height: 8),
                          _buildInfoRow(Icons.location_on, 'العنوان', 'شارع الهاشمي، إربد - 21110'),
                          const SizedBox(height: 8),
                          _buildInfoRow(Icons.access_time, 'ساعات الدعم', 'الأحد - الخميس، 9:00 - 17:00'),
                          const SizedBox(height: 8),
                          _buildInfoRow(Icons.email, 'البريد الإلكتروني', 'azzamsuleimanimportandexport@outlook.com'),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const TermsPage()));
                                  },
                                  child: const Text('شروط الخدمة'),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('سياسة الخصوصية'),
                                        content: SingleChildScrollView(
                                          child: Text(_privacyPolicyText, textAlign: TextAlign.right),
                                        ),
                                        actions: [
                                          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('إغلاق')),
                                        ],
                                      ),
                                    );
                                  },
                                  child: const Text('سياسة الخصوصية'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                  const Text(
                    'قيمنا',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A3A52),
                    ),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 12),
                  _buildValueItem('الأمانة والثقة', Icons.verified),
                  _buildValueItem('الجودة والاحترافية', Icons.star),
                  _buildValueItem('الالتزام بالمواعيد', Icons.schedule),
                  _buildValueItem('خدمة العملاء الممتازة', Icons.handshake),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildValueItem(String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Icon(
            icon,
            color: const Color(0xFFD4A574),
            size: 24,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFFD4A574), size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(value, style: const TextStyle(fontSize: 15, color: Colors.black87, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ],
    );
  }
}

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  void _launchWhatsApp() async {
    const phoneNumber = '+962778622461';
    const message = 'مرحبا، أود الاستفسار عن خدماتكم أو طلب استشارة';
    final url =
        'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}';

    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      debugPrint('Error launching WhatsApp: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Color(0xFF1A3A52),
            ),
            child: const Text(
              'التواصل معنا',
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                const Text(
                  'نحن هنا لخدمتك',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A3A52),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.whatshot,
                          size: 50,
                          color: Color(0xFF25D366),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'تواصل معنا عبر واتس آب',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A3A52),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'للطلبات والاستفسارات والاستشارات التجارية',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton.icon(
                          onPressed: _launchWhatsApp,
                          icon: const Icon(Icons.phone, size: 24),
                          label: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                              '+962778622461',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF25D366),
                            foregroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  'معلومات التواصل',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A3A52),
                  ),
                ),
                const SizedBox(height: 16),
                _buildContactInfo(
                  Icons.phone,
                  'الهاتف',
                  '+962 (0) 778 622 461',
                ),
                _buildContactInfo(
                  Icons.location_on,
                  'الموقع',
                  'شارع الهاشمي، إربد - 21110',
                ),
                _buildContactInfo(
                  Icons.email,
                  'البريد الإلكتروني',
                  'azzamsuleimanimportandexport@outlook.com',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6), // Reduced padding
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Align to top for multi-line
        children: [
          Icon(
            icon,
            color: const Color(0xFFD4A574),
            size: 28,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                SelectableText(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

const String _privacyPolicyText = '''
سياسة الخصوصية هذه توضح كيف تقوم شركة العزام بجمع واستخدام وحماية المعلومات الشخصية الخاصة بك عند استخدامك لتطبيقنا.

**المعلومات التي نجمعها:**

عند استخدامك لتطبيقنا، قد نقوم بجمع معلومات معينة عنك، بما في ذلك ولكن لا تقتصر على:
- الاسم
- عنوان البريد الإلكتروني
- رقم الهاتف
- المعلومات المالية (مثل تفاصيل بطاقة الائتمان)
- معلومات الموقع

**كيفية استخدام المعلومات:**

نحن نستخدم المعلومات التي نجمعها لتحسين خدماتنا وتقديم تجربة مستخدم مخصصة. قد نستخدم معلوماتك أيضًا لـ:
- التواصل معك بشأن حسابك أو معاملاتك
- إرسال تحديثات حول خدماتنا
- تقديم دعم العملاء
- معالجة المدفوعات
- الامتثال للقوانين واللوائح المعمول بها

**حماية المعلومات:**

نحن نتخذ تدابير أمنية مناسبة لحماية معلوماتك الشخصية من الوصول غير المصرح به أو الاستخدام أو الكشف. نحن نستخدم تقنيات مثل التشفير والجدران النارية لحماية بياناتك.

**مشاركة المعلومات:**

لن نقوم ببيع أو تأجير أو تبادل معلوماتك الشخصية مع جهات خارجية دون موافقتك، باستثناء ما هو مطلوب بموجب القانون أو لحماية حقوقنا.

**التغييرات على سياسة الخصوصية:**

قد نقوم بتحديث سياسة الخصوصية هذه من وقت لآخر. سنقوم بإعلامك عن أي تغييرات جوهرية من خلال نشر السياسة المحدثة على هذه الصفحة.

**الاتصال بنا:**

إذا كان لديك أي أسئلة أو مخاوف بشأن سياسة الخصوصية هذه، يرجى الاتصال بنا عبر معلومات الاتصال المتاحة في تطبيقنا.
''';
