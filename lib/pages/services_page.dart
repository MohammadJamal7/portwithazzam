import 'package:flutter/material.dart';
import 'service_request_page.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final services = [
      {
        'title': 'الاستيراد',
        'icon': Icons.shopping_cart_outlined,
        'description': 'خدمات استيراد متخصصة من أفضل الأسواق العالمية مع متابعة كاملة حتى وصول البضائع إلى باب العميل.',
        'details': 'نساعدك في استيراد المنتجات من مصادر موثوقة حول العالم، مع توفير الاستشارات الجمركية واللوجستية، وضمان أفضل الأسعار والجودة.',
        'useCases': [
          'استيراد مواد خام أو بضائع بالجملة',
          'البحث عن موردين جدد',
          'تخليص جمركي للبضائع المستوردة',
        ],
        'extra': [
          {'name': 'origin_country', 'label': 'بلد المنشأ', 'type': 'text', 'required': true},
          {'name': 'product_type', 'label': 'نوع المنتج', 'type': 'text'},
          {'name': 'quantity', 'label': 'الكمية', 'type': 'text'},
        ],
      },
      {
        'title': 'التصدير',
        'icon': Icons.flight_takeoff,
        'description': 'تصدير منتجات محلية بجودة عالية وأسعار تنافسية إلى الأسواق العالمية.',
        'details': 'نقدم خدمات تصدير متكاملة من التعبئة والتغليف إلى الشحن والتخليص، مع دعم كامل في جميع مراحل العملية.',
        'useCases': [
          'تصدير منتجات زراعية أو صناعية',
          'الوصول إلى أسواق جديدة',
          'إعداد الوثائق والشهادات المطلوبة للتصدير',
        ],
        'extra': [
          {'name': 'destination_country', 'label': 'بلد الوجهة', 'type': 'text', 'required': true},
          {'name': 'product_details', 'label': 'تفاصيل المنتج', 'type': 'multiline'},
          {'name': 'quantity', 'label': 'الكمية', 'type': 'text'},
        ],
      },
      {
        'title': 'التخليص الجمركي',
        'icon': Icons.assignment_turned_in,
        'description': 'خدمات تخليص جمركي سريعة وموثوقة لجميع أنواع البضائع.',
        'details': 'نتولى جميع إجراءات التخليص الجمركي، من إعداد المستندات إلى دفع الرسوم، لتسهيل دخول أو خروج بضائعك من وإلى الأردن.',
        'useCases': [
          'تخليص شحنات مستوردة أو مصدرة',
          'استشارات حول الرسوم الجمركية',
          'تسريع إجراءات التخليص',
        ],
        'extra': [
          {'name': 'hs_code', 'label': 'رمز البند الجمركي (HS Code)', 'type': 'text', 'required': true},
          {'name': 'invoice_value', 'label': 'قيمة الفاتورة', 'type': 'text'},
          {'name': 'port', 'label': 'ميناء الوصول', 'type': 'text'},
        ],
      },
      {
        'title': 'الشحن واللوجستيات',
        'icon': Icons.local_shipping_outlined,
        'description': 'حلول شحن وتوزيع متكاملة داخل وخارج الأردن، برّاً وبحراً وجوّاً.',
        'details': 'نرتب لك الشحن الداخلي والدولي، مع تتبع الشحنات، وتقديم أفضل الخيارات من حيث الوقت والتكلفة.',
        'useCases': [
          'شحن بضائع من وإلى الأردن',
          'توزيع محلي للشركات',
          'خدمات شحن سريع أو مبرد',
        ],
        'extra': [
          {'name': 'weight', 'label': 'الوزن (كجم)', 'type': 'text', 'required': true},
          {'name': 'dimensions', 'label': 'الأبعاد (طولxعرضxارتفاع)', 'type': 'text'},
          {'name': 'incoterms', 'label': 'Incoterms (اختياري)', 'type': 'text'},
        ],
      },
      {
        'title': 'الاستشارات التجارية',
        'icon': Icons.support_agent,
        'description': 'استشارات متخصصة لتطوير عملك التجاري وزيادة فرص النجاح.',
        'details': 'نقدم نصائح عملية حول التصدير والاستيراد، اختيار الأسواق، وتطوير العمليات التجارية.',
        'useCases': [
          'دراسة جدوى مشاريع تجارية',
          'تحليل الأسواق الخارجية',
          'تطوير استراتيجيات التصدير',
        ],
        'extra': [
          {'name': 'preferred_date', 'label': 'الموعد المفضل للاستشارة', 'type': 'text'},
          {'name': 'company_size', 'label': 'حجم الشركة', 'type': 'text'},
        ],
      },
      {
        'title': 'إدارة المخزون',
        'icon': Icons.warehouse,
        'description': 'خدمات تخزين وإدارة مخزون احترافية مع تقارير دورية.',
        'details': 'نوفر حلول تخزين آمنة ومرنة، مع إدارة دقيقة للمخزون وتقارير مخصصة حسب احتياجك.',
        'useCases': [
          'تخزين بضائع لفترات قصيرة أو طويلة',
          'إدارة مخزون الشركات الصغيرة والمتوسطة',
          'تقارير دورية عن حالة المخزون',
        ],
        'extra': [
          {'name': 'storage_volume', 'label': 'حجم التخزين المطلوب', 'type': 'text', 'required': true},
          {'name': 'duration', 'label': 'المدة (بالأيام أو الأشهر)', 'type': 'text'},
        ],
      },
    ];

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'خدماتنا',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A3A52),
                ),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.1,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: services.length,
              itemBuilder: (context, index) {
                final service = services[index];
                return InkWell(
                  onTap: () {
                    final extra = service['extra'] as List<Map<String, dynamic>>? ?? [];
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => ServiceRequestPage(
                        serviceTitle: service['title'] as String,
                        extraFields: extra,
                        description: service['description'] as String?,
                        details: service['details'] as String?,
                        useCases: service['useCases'] as List<String>?,
                      ),
                    ));
                  },
                  child: ServiceCard(
                    title: service['title'] as String,
                    icon: service['icon'] as IconData,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const ServiceCard({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: const Color(0xFFD4A574),
              width: 3,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                icon,
                size: 40,
                color: const Color(0xFF1A3A52),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A3A52),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
