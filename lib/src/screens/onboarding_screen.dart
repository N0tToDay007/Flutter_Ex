// AI-ASSISTED: Modified by assistant on 2026-01-19
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _ctrl = PageController();
  int _page = 0;

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _next() {
    if (_page < 2) _ctrl.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
    else Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _ctrl,
                onPageChanged: (i) => setState(() => _page = i),
                children: [
                  _buildPage('Welcome', 'จัดการรายการซื้อของนอกบ้านได้ง่ายๆ'),
                  _buildPage('Organize', 'เพิ่ม ลบ หรือจัดลำดับรายการได้ตามต้องการ'),
                  _buildPage('Ready', 'เริ่มใช้งานเพื่อสร้างรายการซื้อของของคุณ'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // wrap skip with animated button
                  GestureDetector(onTap: () => Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false), child: const Text('ข้าม')),
                  Row(
                    children: List.generate(3, (i) => Container(margin: const EdgeInsets.symmetric(horizontal: 4), width: 10, height: 10, decoration: BoxDecoration(color: i == _page ? Colors.black : Colors.grey, shape: BoxShape.circle))),
                  ),
                  GestureDetector(onTap: _next, child: Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(8)), child: Text(_page < 2 ? 'ต่อไป' : 'เริ่มใช้งาน', style: const TextStyle(color: Colors.white)))),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPage(String title, String body) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Text(title, style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          Text(body, style: const TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
