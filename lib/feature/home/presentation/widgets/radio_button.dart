import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/global_providers/locale_provider.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/feature/home/data/models/shagi_polucheniye_uslugi_model.dart';

class RadioButton extends ConsumerStatefulWidget {
  final AdaptiveSizes size;
  final List<ChoiceOption> options;
  final ChoiceOption? choice;
  final ValueChanged<Object?>? onChanged;
  final String? Function(ChoiceOption?)? validator;
  const RadioButton({
    super.key,
    required this.size,
    required this.options,
    required this.choice,
    required this.onChanged,
    this.validator,
  });

  @override
  ConsumerState<RadioButton> createState() => _RadioButtonState();
}

class _RadioButtonState extends ConsumerState<RadioButton> {
  @override
  Widget build(BuildContext context) {
    final size = AdaptiveSizes(context);
    final currentLocal = ref.watch(localeProvider);
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: widget.size.otstup10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(widget.size.otstup10),
                ),
                child: Column(
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            // horizontal: widget.size.otstup15,
                            vertical: 8,
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: size.otstup10,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: size.screenWidth * 0.64,
                                      child: Text(
                                        widget.options[index].name.getText(currentLocal),
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Radio.adaptive(
                                      activeColor: primaryButtonColor,
                                      value:
                                          widget
                                              .options[index],
                                      groupValue:
                                          widget.choice,
                                      onChanged: widget.onChanged,
                                      // (ChoiceOption? val) {
                                      //   if (val != null) {
                                      //     setState(() {
                                      //       widget.onChanged?.call(
                                      //         val,
                                      //       ); // уведомляем родителя
                                      //     });
                                      //   }
                                      // },
                                    ),
                                  ],
                                ),
                              ),

                              index < widget.options.length - 1
                                  ? Divider()
                                  : SizedBox.shrink(),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(height: 0),
                      itemCount: widget.options.length,
                    ),
                  ],
                ),
              ),

              // if (field.hasError)
              //   Padding(
              //     padding: EdgeInsets.only(left: 15),
              //     child: Text(
              //       field.errorText!,
              //       style: TextStyle(color: Colors.redAccent),
              //     ),
              //   ),
            ],
          ),
        ),
      ],
    );
  }
}
