import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceRequestPage extends StatefulWidget {
  final String serviceTitle;
  final List<Map<String, dynamic>> extraFields;
  final String? description;
  final String? details;
  final List<String>? useCases;

  const ServiceRequestPage({
    super.key,
    required this.serviceTitle,
    this.extraFields = const [],
    this.description,
    this.details,
    this.useCases,
  });

  @override
  State<ServiceRequestPage> createState() => _ServiceRequestPageState();
}

class _ServiceRequestPageState extends State<ServiceRequestPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _companyCtrl = TextEditingController();
  final _detailsCtrl = TextEditingController();

  final Map<String, TextEditingController> _extraCtrls = {};

  static const _whatsappNumber = '+962778622461';

  @override
  void initState() {
    super.initState();
    for (final f in widget.extraFields) {
      final key = f['name'] as String? ?? UniqueKey().toString();
      _extraCtrls[key] = TextEditingController();
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _companyCtrl.dispose();
    _detailsCtrl.dispose();
    for (final c in _extraCtrls.values) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _confirmAndSend() async {
    if (!_formKey.currentState!.validate()) return;

    final name = _nameCtrl.text.trim();
    final phone = _phoneCtrl.text.trim();
    final company = _companyCtrl.text.trim();
    final details = _detailsCtrl.text.trim();

    final buffer = StringBuffer();
    buffer.writeln('مرحباً شركة العزام');
    buffer.writeln('طلب خدمة: ${widget.serviceTitle}');
    buffer.writeln('الاسم: $name');
    buffer.writeln('الهاتف: $phone');
    if (company.isNotEmpty) buffer.writeln('اسم الشركة: $company');
    if (details.isNotEmpty) buffer.writeln('تفاصيل: $details');

    // Append extra fields values
    for (final f in widget.extraFields) {
      final key = f['name'] as String?;
      final label = f['label'] as String? ?? key ?? '';
      if (key != null && _extraCtrls.containsKey(key)) {
        final value = _extraCtrls[key]!.text.trim();
        if (value.isNotEmpty) buffer.writeln('$label: $value');
      }
    }

    final message = buffer.toString();

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تأكيد الإرسال'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('الرسالة التي سترسل عبر واتساب:'),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(message, textAlign: TextAlign.right),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('تعديل'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF25D366)),
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('إرسال'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    final url = 'https://wa.me/$_whatsappNumber?text=${Uri.encodeComponent(message)}';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('لا يمكن فتح واتساب على هذا الجهاز'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('طلب خدمة — ${widget.serviceTitle}'),
        backgroundColor: const Color(0xFF1A3A52),
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              if (widget.description != null || widget.details != null || (widget.useCases != null && widget.useCases!.isNotEmpty))
                Card(
                  color: const Color(0xFFF7F7F7),
                  margin: const EdgeInsets.only(bottom: 18),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.description != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(widget.description!, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                          ),
                        if (widget.details != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(widget.details!, style: const TextStyle(fontSize: 13)),
                          ),
                        if (widget.useCases != null && widget.useCases!.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('أمثلة على الاستخدام:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                              ...widget.useCases!.map((e) => Row(
                                children: [
                                  const Text('• ', style: TextStyle(fontSize: 14)),
                                  Expanded(child: Text(e, style: const TextStyle(fontSize: 12))),
                                ],
                              )),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              TextFormField(
                controller: _nameCtrl,
                textAlign: TextAlign.right,
                decoration: const InputDecoration(
                  labelText: 'الاسم كامل',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'يرجى إدخال الاسم' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _phoneCtrl,
                keyboardType: TextInputType.phone,
                textAlign: TextAlign.right,
                decoration: const InputDecoration(
                  labelText: 'رقم الهاتف',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'يرجى إدخال رقم الهاتف' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _companyCtrl,
                textAlign: TextAlign.right,
                decoration: const InputDecoration(
                  labelText: 'اسم الشركة (اختياري)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _detailsCtrl,
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                textAlign: TextAlign.right,
                decoration: const InputDecoration(
                  labelText: 'تفاصيل الطلب / ملاحظات',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              // Dynamic extra fields for specific services
              ...widget.extraFields.map((f) {
                final key = f['name'] as String? ?? '';
                final label = f['label'] as String? ?? '';
                final type = f['type'] as String? ?? 'text';
                final required = f['required'] as bool? ?? false;

                TextInputType keyboard;
                int maxLines = 1;
                if (type == 'number') {
                  keyboard = TextInputType.number;
                } else if (type == 'multiline') {
                  keyboard = TextInputType.multiline;
                  maxLines = 4;
                } else {
                  keyboard = TextInputType.text;
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    controller: _extraCtrls[key],
                    keyboardType: keyboard,
                    maxLines: maxLines,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      labelText: label,
                      border: const OutlineInputBorder(),
                    ),
                    validator: (v) {
                      if (required && (v == null || v.trim().isEmpty)) {
                        return 'يرجى إدخال $label';
                      }
                      return null;
                    },
                  ),
                );
              }).toList(),

              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.send),
                label: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 14.0),
                  child: Text('أرسل عبر واتساب'),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF25D366),
                  foregroundColor: Colors.white,
                ),
                onPressed: _confirmAndSend,
              ),
              const SizedBox(height: 8),
              OutlinedButton(
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 14.0),
                  child: Text('إلغاء'),
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
