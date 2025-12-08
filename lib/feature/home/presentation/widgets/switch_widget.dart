import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';

class SwitchWidget extends StatefulWidget {
  final AdaptiveSizes size;
  final bool isOn;
  final void Function(bool) onToggle;
  final String? Function(bool?)? validator;

  const SwitchWidget({
    super.key,
    required this.size,
    required this.isOn,
    required this.onToggle,
    this.validator,
  });

  @override
  State<SwitchWidget> createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  @override
  Widget build(BuildContext context) {
    final size = AdaptiveSizes(context);
    return FormField<bool>(
      validator: widget.validator,
      initialValue: widget.isOn,
      builder: (FormFieldState<bool> field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: widget.size.otstup10),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: widget.size.otstup10,
                    vertical: widget.size.otstup15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '* ',
                            style: TextStyle(color: primaryButtonColor, fontSize: 16),
                          ),
                          SizedBox(width: 10),
                          SizedBox(
                            width: widget.size.screenWidth * 0.55,
                            child: Text(
                              'Подтверждаю ответственность за сохранность пароля ключа сертификата электронной подписи',
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      FlutterSwitch(
                        width: 60,
                        height: 30 ,
                        value: field.value ?? widget.isOn,
                        activeSwitchBorder: Border.all(
                          color: primaryButtonColor,
                          width: 2,
                        ),
                        activeColor: Colors.transparent,
                        inactiveColor: Colors.transparent,
                        inactiveToggleColor: Colors.grey,
                        inactiveSwitchBorder: Border.all(
                          color: Colors.grey,
                          width: 2,
                        ),
                        activeToggleColor: primaryButtonColor,
                        onToggle: (val) {
                          field.didChange(val); // обновляем FormField
                          widget.onToggle(val);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),

            if (field.hasError)
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text(
                  field.errorText!,
                  style: TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
          ],
        );
      },
    );
  }
}
