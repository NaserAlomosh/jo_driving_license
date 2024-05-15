// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:pinput/pinput.dart';

// class CustomOtpTextField extends StatelessWidget {
//   final TextEditingController controller;
//   final GlobalKey<FormState> formKey;
//   const CustomOtpTextField({
//     super.key,
//     required this.controller,
//     required this.formKey,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: formKey,
//       child: Pinput(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         defaultPinTheme: PinTheme(
//           width: 56,
//           height: 56,
//           textStyle: const TextStyle(
//             fontSize: 20,
//             color: Color.fromRGBO(30, 60, 87, 1), // Dark blue
//             fontWeight: FontWeight.w600,
//           ),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             color: const Color.fromRGBO(220, 230, 240, 1), // Light gray-blue
//           ),
//         ),
//         focusedPinTheme: PinTheme(
//           width: 56,
//           height: 56,
//           textStyle: const TextStyle(
//             fontSize: 20,
//             color: Color.fromRGBO(30, 60, 87, 1), // Dark blue
//             fontWeight: FontWeight.w600,
//           ),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             color: const Color.fromARGB(255, 234, 234, 234), // White
//           ),
//         ),
//         length: 6,
//         validator: (value) {
//           if (value!.isEmpty) {
//             return 'OTP not valid';
//           } else if (value.length < 6) {
//             return 'Enter 6 degets';
//           }
//           return null;
//         },
//         onCompleted: (pin) => log(pin),
//       ),
//     );
//   }
// }
