import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

var phoneFormatter = MaskTextInputFormatter(
  mask: '+998 (00) 000-00-00',
  filter: {"0": RegExp(r'[0-9]')},
  type: MaskAutoCompletionType.lazy,
);

var innFormatter = MaskTextInputFormatter(
  mask: '0000000000', 
  filter: {"0": RegExp(r'[0-9]')},
);

var dateFormatter = MaskTextInputFormatter(
  mask: '00.00.0000',
  filter: {"0": RegExp(r'[0-9]')},
  type: MaskAutoCompletionType.lazy,
);