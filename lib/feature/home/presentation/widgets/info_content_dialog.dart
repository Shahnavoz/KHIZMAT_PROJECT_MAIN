import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';

class InfoContentDialog extends StatefulWidget {
  final String data;
  const InfoContentDialog({super.key, required this.data});

  @override
  State<InfoContentDialog> createState() => _InfoContentDialogState();
}

class _InfoContentDialogState extends State<InfoContentDialog> {
  @override
  Widget build(BuildContext context) {
    final size = AdaptiveSizes(context);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.otstup15,
              vertical: size.otstup15,
            ),
            child: Html(
              data: widget.data,
              style: {
                "p": Style(fontSize: FontSize(16), color: Colors.black),
                "strong": Style(fontWeight: FontWeight.bold),
                "li": Style(fontSize: FontSize(15)),
              },
            ),
          ),
        ),
      ],
    );
  }

  TextStyle deleteTextStyle(AdaptiveSizes size) {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: Colors.grey[500],
    );
  }
}
