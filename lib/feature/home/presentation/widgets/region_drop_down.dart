import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/feature/home/data/models/drop_down_options_model.dart';
import 'package:khizmat_new/feature/home/data/models/shagi_polucheniye_uslugi_model.dart';

class RegionDropdown extends StatefulWidget {
  final List<ChoiceOption> itemList;
  final String textSpanText;
  final String placeholder;
  final String value;
  final ValueChanged<String?>? onChanged;
  const RegionDropdown({
    super.key,
    required this.itemList,
    required this.textSpanText,
    required this.placeholder,
    required this.value,
    required this.onChanged,
  });

  @override
  State<RegionDropdown> createState() => _RegionDropdownState();
}

class _RegionDropdownState extends State<RegionDropdown> {
  String? selectedRegion;
  bool showError = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8,bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SizedBox(height: 8),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: widget.textSpanText,
                  style: TextStyle(
                    color: primaryButtonColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: '* ',
                  style: TextStyle(color: primaryButtonColor, fontSize: 16),
                ),
              ],
            ),
          ),
          const SizedBox(height: 9),
          DropdownButtonFormField2<String>(
            value: widget.value,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey[400]!, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: primaryButtonColor),
              ),
            ),
            hint: Text(widget.placeholder),
            items:
                widget.itemList.map((region) {
                  if (selectedRegion != null &&
                          !widget.itemList.contains(selectedRegion) ||
                      widget.itemList.isEmpty) {
                    selectedRegion = null;
                  }
                  return DropdownMenuItem<String>(
                    
                    value: region.name.ru,
                    
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            region.name.ru!,
                            style:
                                region == selectedRegion
                                    ? TextStyle(color: primaryButtonColor)
                                    : null,
                          ),
                          if (region != widget.itemList.last)
                            Divider(height: 16, color: Colors.grey[100]!),
                        ],
                      ),
                    ),
                  );
                }).toList(),
            selectedItemBuilder: (context) {
              return widget.itemList.map((region) {
                return Text(region.name.ru!);
              }).toList();
            },
            onChanged: widget.onChanged,
            dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
