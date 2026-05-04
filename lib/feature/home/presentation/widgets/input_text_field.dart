import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';

class InputTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final double? width;
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final Key? formKey;
  final AdaptiveSizes size;
  final void Function()? onTap;
  /// maxLength maps to TextFormField.maxLines (1 = single line, null = unlimited)
  final int? maxLength;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final bool? isFocused;
  final bool? readOnly;
  final List<TextInputFormatter>? inputFormatters;
  /// Whether to show the required asterisk (*). Overrides [isRequired] from field.
  final bool? isRequired;

  const InputTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    this.width,
    required this.controller,
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
    this.isRequired,
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
                style: const TextStyle(
                  color: primaryButtonColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (isRequired == true)
                const TextSpan(
                  text: '* ',
                  style: TextStyle(color: primaryButtonColor, fontSize: 16),
                ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: onTap,
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
                onChanged: onChanged,
                controller: controller,
                scrollPadding: EdgeInsets.zero,
                decoration: InputDecoration(
                  suffixIcon: suffixIcon,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: greyTextFBorderColor,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: primaryButtonColor),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                  hintText: hintText,
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis,
                  ),
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
