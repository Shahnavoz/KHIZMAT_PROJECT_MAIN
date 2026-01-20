import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/feature/home/data/models/shagi_polucheniye_uslugi_model.dart';

class InputTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final double? width;
  final TextEditingController controller;
  // final void Function(String)? onFieldSubmitted;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final Key? formKey;
  final AdaptiveSizes size;
  final void Function()? onTap;
  final int maxLength;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final bool? isFocused;
  final bool? readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final Field field;
  const InputTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    this.width,
    required this.controller,
    // required this.onFieldSubmitted,
    required this.onChanged,
    required this.validator,
    this.suffixIcon,
    required this.formKey,
    required this.size,
    required this.onTap,
    this.maxLength = 1,
    this.keyboardType,
    this.focusNode,
    this.isFocused,
    this.readOnly,
    this.inputFormatters,
    required this.field,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: labelText,
                style: TextStyle(
                  color: primaryButtonColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              field.required == true
                  ? TextSpan(
                    text: '* ',
                    style: TextStyle(color: primaryButtonColor, fontSize: 16),
                  )
                  : TextSpan(),
            ],
          ),
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: () {},
          child: SizedBox(
            key: formKey,
            width: width ?? double.infinity,
            child: Padding(
              padding: EdgeInsets.only(bottom: size.otstup10),
              child: TextFormField(
                inputFormatters: inputFormatters,
                readOnly: readOnly ?? false,
                showCursor: isFocused,
                focusNode: focusNode,
                cursorOpacityAnimates: false,
                keyboardType: keyboardType,
                maxLines: maxLength,
                validator: validator,
                // onFieldSubmitted: onFieldSubmitted,
                onChanged: onChanged,
                controller: controller,
                scrollPadding: EdgeInsets.zero,

                decoration: InputDecoration(
                  suffixIcon: suffixIcon, 
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: greyTextFBorderColor,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: primaryButtonColor),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  hintText: hintText,
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis,
                  ),

                  // suffixIcon: Icon(Icons.abc),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 14,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
