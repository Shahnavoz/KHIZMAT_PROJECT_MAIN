import 'package:flutter/material.dart';
import 'package:khizmat_new/consts/colors/const_colors.dart';
import 'package:khizmat_new/consts/sizes/adaptive_sizes.dart';

class NeUdayotsaVoytiModalPage extends StatefulWidget {
  const NeUdayotsaVoytiModalPage({super.key});

  @override
  State<NeUdayotsaVoytiModalPage> createState() =>
      _NeUdayotsaVoytiModalPageState();
}

class _NeUdayotsaVoytiModalPageState extends State<NeUdayotsaVoytiModalPage> {
  @override
  Widget build(BuildContext context) {
    final size = AdaptiveSizes(context);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child:
           Container(
            height: size.screenHeight / 1.88,
            decoration: BoxDecoration(
              // border: Border.all(),
              color: primaryButtonColor,
              borderRadius: BorderRadius.circular(18),
            ),
            // child: Padding(
            //   padding: EdgeInsets.symmetric(
            //     horizontal: size.width20,
            //     vertical: size.height18,
            //   ),
            // child:
            //  Form(
            //   key: _formKey,
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         S.of(context).avtorizatsiya,
            //         style: TextStyle(
            //           fontSize: size.fontSize20,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //       SizedBox(height: 35),
            //       MyTextField(
            //         labelText: S.of(context).email,
            //         controller: emailController,
            //         obscureText: false,
            //         validator: (value) {
            //           // if (value == null || value.isEmpty) {
            //           //   return S.of(context).required_pole;
            //           // } else if (value.length < 6) {
            //           //   return S.of(context).minimum_6_ramz;
            //           // }
            //           // return null;
          
            //           if (value == null || value.isEmpty)
            //             return 'Pole obyazatelnoe';
          
            //           final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]');
            //           if (!emailRegex.hasMatch(value)) {
            //             return 'Neverniy format';
            //           }
            //           return null;
            //         },
            //       ),
            //       // MyTextField(
            //       //   labelText: S.of(context).parol,
            //       //   suffixIcon: GestureDetector(
            //       //     onTap: () {
            //       //       ref.read(obsecureProvider.notifier).state =
            //       //           !ref.read(obsecureProvider.notifier).state;
            //       //     },
            //       //     // togglePasswordVisibility,
            //       //     child: Icon(
            //       //       obsecureText == true
            //       //           ? Icons.remove_red_eye
            //       //           : Icons.remove_red_eye_outlined,
            //       //     ),
            //       //   ),
            //       //   controller: passwordController,
            //       //   obscureText: obsecureText,
            //       //   validator: (value) {
            //       //     if (value == null || value.isEmpty) {
            //       //       return S.of(context).required_pole;
            //       //     } else if (value.length < 6) {
            //       //       return S.of(context).minimum_6_ramz;
            //       //     }
            //       //     return null;
            //       //   },
            //       // ),
            //       SizedBox(height: 35),
          
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           MyButton(
            //             text: S.of(context).to_close,
            //             onPressed: () {
            //               FocusScope.of(context).unfocus();
            //               Navigator.pop(context);
            //             },
            //             size: 0.3,
            //           ),
            //           SizedBox(width: 15),
            //           MyButton(
            //             text: S.of(context).enter,
            //             size: 0.3,
            //             onPressed: () {
            //               final form = _formKey.currentState;
            //               if (form != null && form.validate()) {
            //                 login(
            //                   emailController.text,
            //                   passwordController.text,
            //                 );
            //               }
            //             },
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            // ),
          ),
        ),
      ),
    );
  }
}
