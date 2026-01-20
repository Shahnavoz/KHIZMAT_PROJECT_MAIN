import 'package:flutter/material.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/feature/home/data/models/shagi_polucheniye_uslugi_model.dart';

Widget buildDropdownSkeleton(
  Field field, {
  bool isLoading = false,
  String? error,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 8, bottom: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${field.title.ru} *",
          style: const TextStyle(
            color: primaryButtonColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 9),
        if (isLoading) const CircularProgressIndicator(),
        if (error != null)
          Text("Ошибка: $error", style: const TextStyle(color: Colors.red)),
      ],
    ),
  );
}
