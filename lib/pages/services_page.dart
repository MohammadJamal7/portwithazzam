import 'package:flutter/material.dart';
import 'service_request_page.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final services = [
      {
        'title': 'الاستيراد',
        'icon': Icons.import_export,
        'description': 'خدمات استيراد متخصصة من أفضل الأسواق العالمية',
        'extra': [
          {'name': 'origin_country', 'label': 'بلد المنشأ', 'type': 'text', 'required': true},
          {'name': 'product_type', 'label': 'نوع المنتج', 'type': 'text'},
          {'name': 'quantity', 'label': 'الكمية', 'type': 'text'},
        ],
      },
      {
        'title': 'التصدير',
        'icon': Icons.local_shipping,
        'description': 'تصدير منتجات محلية بجودة عالية وأسعار تنافسية',
        'extra': [
          {'name': 'destination_country', 'label': 'بلد الوجهة', 'type': 'text', 'required': true},
          {'name': 'product_details', 'label': 'تفاصيل المنتج', 'type': 'multiline'},
          {'name': 'quantity', 'label': 'الكمية', 'type': 'text'},
        ],
      },
      {
        'title': 'التخليص الجمركي',
        'icon': Icons.verified_user,
        'description': 'خدمات تخليص جمركي سريعة وموثوقة',
        'extra': [
          {'name': 'hs_code', 'label': 'رمز البند الجمركي (HS Code)', 'type': 'text', 'required': true},
          {'name': 'invoice_value', 'label': 'قيمة الفاتورة', 'type': 'text'},
          {'name': 'port', 'label': 'ميناء الوصول', 'type': 'text'},
        ],
      },
      {
        'title': 'الشحن واللوجستيات',
        'icon': Icons.directions_boat,
        'description': 'حلول شحن وتوزيع متكاملة داخل وخارج الأردن',
        'extra': [
          {'name': 'weight', 'label': 'الوزن (كجم)', 'type': 'text', 'required': true},
          {'name': 'dimensions', 'label': 'الأبعاد (طولxعرضxارتفاع)', 'type': 'text'},
          {'name': 'incoterms', 'label': 'Incoterms (اختياري)', 'type': 'text'},
        ],
      },
      {
        'title': 'الاستشارات التجارية',
        'icon': Icons.support_agent,
        'description': 'استشارات متخصصة لتطوير عملك التجاري',
        'extra': [
          {'name': 'preferred_date', 'label': 'الموعد المفضل للاستشارة', 'type': 'text'},
          {'name': 'company_size', 'label': 'حجم الشركة', 'type': 'text'},
        ],
      },
      {
        'title': 'إدارة المخزون',
        'icon': Icons.inventory_2,
        'description': 'خدمات تخزين وإدارة مخزون احترافية',
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
                      ),
                    ));
                  },
                  child: ServiceCard(
                    title: service['title'] as String,
                    icon: service['icon'] as IconData,
                    description: service['description'] as String,
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
  final String description;

  const ServiceCard({
    super.key,
    required this.title,
    required this.icon,
    required this.description,
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
            mainAxisAlignment: MainAxisAlignment.start,
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
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A3A52),
                ),
              ),
              const SizedBox(height: 6),
              Expanded(
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
