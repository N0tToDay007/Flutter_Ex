import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  const BottomNavBar({Key? key, required this.currentIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color bottomBar = Color(0xFF67B0A8);
    return Container(
      height: 64,
      color: bottomBar,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildItem(context, 0, Icons.home, 'Home'),
          _buildItem(context, 1, Icons.edit, 'Add'),
          _buildItem(context, 2, Icons.list_alt, 'Details'),
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index, IconData icon, String label) {
  // selected unused for now but kept for future styling - reference to avoid lint
  // no-op referencing selected to avoid analyzer unused-variable warning
  final bool _selectedUsed = index == currentIndex;
  // ignore: unused_local_variable
  _selectedUsed;
    return InkWell(
      onTap: () {
        if (index == currentIndex) return;
        if (index == 0) Navigator.pushNamed(context, '/home');
        if (index == 1) Navigator.pushNamed(context, '/add');
        if (index == 2) Navigator.pushNamed(context, '/details');
      },
      child: SizedBox(
        width: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(icon, color: Colors.black), const SizedBox(height: 4), Text(label, style: const TextStyle(fontSize: 12))],
        ),
      ),
    );
  }
}
