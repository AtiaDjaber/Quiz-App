import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    required this.title,
    Key? key,
  }) : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text(title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
