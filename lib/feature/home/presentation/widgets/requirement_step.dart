import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/methods/common_methods.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';
import 'package:khizmat_new/feature/home/data/models/step_requirement_model.dart';
import 'package:khizmat_new/feature/home/data/providers/controllers_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class RequirementStep extends ConsumerStatefulWidget {
  final List<Requirement> stepRequirement;
  final int documentId;
  const RequirementStep({
    super.key,
    required this.stepRequirement,
    required this.documentId,
  });

  @override
  ConsumerState<RequirementStep> createState() => _RequirementStepState();
}

class _RequirementStepState extends ConsumerState<RequirementStep> {
  @override
  Widget build(BuildContext context) {
    final size = AdaptiveSizes(context);
    final formProvider = ref.watch(formProviderFamily(widget.documentId));
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size.otstup10),
            color: Color(0xFFfff4dc),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.otstup10,
              vertical: size.otstup15,
            ),
            child: Column(
              children: [
                Text(
                  'Напоминаем Вам, что в результате подачи этого заявления, если вам предоставлены лицензия и разрешение, или если вы получили уведомление о начале деятельности, напоминаем,что в процессе своей деятельности вы должны неукоснительно соблюдать следующие требования и условия, в случае несоблюдения этих требований вы можете быть привлечены к ответственности в соответствии с действующим законодательством:',
                  style: TextStyle(fontSize: 15, height: 2),
                ),
              ],
            ),
          ),
        ),
        ...widget.stepRequirement.map((stepR) {
          return Column(
            children: [
              SizedBox(height: size.otstup15),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFFf7f7f7),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.otstup15,
                    vertical: size.otstup10,
                  ),
                  child: Row(
                    children: [
                      Checkbox(
                        activeColor: primaryButtonColor,
                        value: formProvider.getValue(stepR.id.toString()) ?? false,
                        onChanged: (newValue) {
                          formProvider.setValue(stepR.id.toString(), newValue);
                        },
                      ),
                      SizedBox(
                        width: size.screenWidth * 0.7,
                        child: Html(
                          data: stepR.content.ru,
                          onLinkTap: (url, _, _) {
                            if (url != null) {
                              openUrl(url);
                            }
                          },
                          style: {
                            "p": Style(fontSize: FontSize(16)),
                            "strong": Style(fontWeight: FontWeight.bold),
                            "a": Style(
                              color: Colors.blue,
                              textDecoration: TextDecoration.none,
                            ),
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: size.otstup15),
            ],
          );
        }),
      ],
    );
  }
}

// Future<void> openUrl(String url) async {
//   final uri = Uri.parse(url);
//   try {
//     await launchUrl(uri, mode: LaunchMode.externalApplication);
//   } catch (e) {
//     print('Could not launch $url: $e');
//   }
// }
