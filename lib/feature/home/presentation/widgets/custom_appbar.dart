import 'package:flutter/material.dart';
import 'package:khizmat_new/consts/text_styles/const_text_styles.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? actionWidget;
  const CustomAppbar({super.key, required this.title, this.actionWidget});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: Column(
        children: [
          textWithH1Style(title, fontW: FontWeight.w500, color: Colors.black),
          SizedBox(height: 5),
        ],
      ),
      leading: Padding(
        padding: EdgeInsets.only(left: 25),
        child: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
      ),
      actions: [actionWidget ?? SizedBox.shrink()],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
