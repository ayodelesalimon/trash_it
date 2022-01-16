
// import 'package:flutter/material.dart';
// import 'package:trash_it/Resources/Resources.dart';


// class CustomButton extends StatelessWidget {
//   Function? onTap;
//   Widget? data;
//   String? text;
//   Color? color;
//   Color? borderColor;
//   Color? textColor;
//   double? height;
//   double? width;
//   double? borderRadius;
//   bool? enable;
//   CustomButton(
//       {Key? key,
//       required this.onTap,
//       this.data,
//       @required this.text,
//       this.color = R.colors.splashScreenViewPagerSelectedIndicatorColor,
//       this.borderColor = R.colors.splashScreenViewPagerSelectedIndicatorColor,
//       this.textColor = Colors.white,
//       this.height,
//       this.width = double.infinity,
//       this.enable = true,
//       this.borderRadius = 5})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return IgnorePointer(
//       ignoring: !enable!,
//       child: GestureDetector(
//           onTap: onTap!.call(),
//           child: Container(
//             decoration: BoxDecoration(
//                 color: enable ? color : Color(0xFFD9D9D9),
//                 borderRadius: BorderRadius.circular(borderRadius),
//                 border: Border.all(
//                     color: enable ? borderColor : Color(0xFFD9D9D9))),
//             width: width,
//             height: height != null ? height : 45,
//             child: Center(
//                 child: data != null
//                     ? data
//                     : Text(
//                         text.toUpperCase(),
//                         style: TextStyle(
//                             color: textColor, fontWeight: FontWeight.w500),
//                       )),
//           )),
//     );
//   }
// }
