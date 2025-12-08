import 'dart:ui';

import 'package:flutter/material.dart';

Widget buildCustomRow(String title, String value, {Color? color, double? fontsize}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Text(
            title,
            maxLines: 2,
            style: TextStyle(
              fontSize: fontsize ?? 18,
              color: Colors.grey[600]!,
              overflow: TextOverflow.ellipsis
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 6,
          child: Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: color,
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    ),
  );
}