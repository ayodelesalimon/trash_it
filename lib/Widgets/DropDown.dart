import 'package:flutter/material.dart';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:trash_it/Resources/Resources.dart';



DropDownSelect(
    {String? title,
    String? selected,
    double? height,
    List? items,
    @required BuildContext? context}) {
  if (context != null) {
    FocusScope.of(context).unfocus();
  }

  return showCupertinoModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context!,
      builder: (context) {
        return ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
          child: Material(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 10,),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: 5,
                      width: 40,
                      color: Color(0x80808080),
                    ),
                  ),
                ),
                  SizedBox(height: 10,),
                Padding(
                  padding:
                      EdgeInsets.only(top: 10, right: 20, left: 15, bottom: 10),
                  child: Text(
                    '$title',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: R.colors.splashScreenViewPagerSelectedIndicatorColor),
                  ),
                ),
               SizedBox(height: 10,),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ...items!
                            .map((x) => ListTile(
                                tileColor: x.name == selected
                                    ?R.colors.splashScreenViewPagerSelectedIndicatorColor
                                    : Colors.white,
                                onTap: () {
                                  Navigator.pop(context, x);
                                },
                                title: Text(
                                  '${x.name}',
                                  style: TextStyle(
                                      color: x.name == selected
                                          ? Colors.white
                                          : Colors.black),
                                ),
                                selectedTileColor: R.colors.splashScreenViewPagerSelectedIndicatorColor))
                            .toList()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}


// DropDownSelectSector(
//     {String title,
//     String selected,
//     double height,
//     List items,
//     @required BuildContext context}) {
//   if (context != null) {
//     FocusScope.of(context).unfocus();
//   }

//   return showCupertinoModalBottomSheet(
//       backgroundColor: Colors.transparent,
//       context: context,
//       builder: (context) {
//         return ClipRRect(
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(16.0),
//             topRight: Radius.circular(16.0),
//           ),
//           child: Material(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Space.spacerH10,
//                 Center(
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(20),
//                     child: Container(
//                       height: 5,
//                       width: 40,
//                       color: Color(0x80808080),
//                     ),
//                   ),
//                 ),
//                 Space.spacerH10,
//                 Padding(
//                   padding:
//                       EdgeInsets.only(top: 10, right: 20, left: 15, bottom: 10),
//                   child: Text(
//                     '$title',
//                     style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.w400,
//                         color: AppColors.kamivestBlue),
//                   ),
//                 ),
//                 Space.spacerH10,
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         ...items
//                             .map((x) => ListTile(
//                                 tileColor: x.sector == selected
//                                     ? AppColors.kamivestBlue
//                                     : Colors.white,
//                                 onTap: () {
//                                   Navigator.pop(context, x);
//                                 },
//                                 title: Text(
//                                   '${x.sector}',
//                                   style: TextStyle(
//                                       color: x.sector == selected
//                                           ? Colors.white
//                                           : Colors.black),
//                                 ),
//                                 selectedTileColor: AppColors.kamivestBlue))
//                             .toList()
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       });
// }

// DropDownSelectMonthIcome(
//     {String title,
//     String selected,
//     double height,
//     List items,
//     @required BuildContext context}) {
//   if (context != null) {
//     FocusScope.of(context).unfocus();
//   }

//   return showCupertinoModalBottomSheet(
//       backgroundColor: Colors.transparent,
//       context: context,
//       builder: (context) {
//         return ClipRRect(
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(16.0),
//             topRight: Radius.circular(16.0),
//           ),
//           child: Material(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Space.spacerH10,
//                 Center(
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(20),
//                     child: Container(
//                       height: 5,
//                       width: 40,
//                       color: Color(0x80808080),
//                     ),
//                   ),
//                 ),
//                 Space.spacerH10,
//                 Padding(
//                   padding:
//                       EdgeInsets.only(top: 10, right: 20, left: 15, bottom: 10),
//                   child: Text(
//                     '$title',
//                     style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.w400,
//                         color: AppColors.kamivestBlue),
//                   ),
//                 ),
//                 Space.spacerH10,
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         ...items
//                             .map((x) => ListTile(
//                                 tileColor: x.id == selected
//                                     ? AppColors.kamivestBlue
//                                     : Colors.white,
//                                 onTap: () {
//                                   Navigator.pop(context, x);
//                                 },
//                                 title: Text(
//                                   '${x.lowerBound} - ${x.upperBound}',
//                                   style: TextStyle(
//                                       color: x.id == selected
//                                           ? Colors.white
//                                           : Colors.black),
//                                 ),
//                                 selectedTileColor: AppColors.kamivestBlue))
//                             .toList()
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       });
// }

// DropDownSelectStatus(
//     {String title,
//     String selected,
//     double height,
//     List items,
//     @required BuildContext context}) {
//   if (context != null) {
//     FocusScope.of(context).unfocus();
//   }

//   return showCupertinoModalBottomSheet(
//       backgroundColor: Colors.transparent,
//       context: context,
//       builder: (context) {
//         return ClipRRect(
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(16.0),
//             topRight: Radius.circular(16.0),
//           ),
//           child: Material(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Space.spacerH10,
//                 Center(
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(20),
//                     child: Container(
//                       height: 5,
//                       width: 40,
//                       color: Color(0x80808080),
//                     ),
//                   ),
//                 ),
//                 Space.spacerH10,
//                 Padding(
//                   padding:
//                       EdgeInsets.only(top: 10, right: 20, left: 15, bottom: 10),
//                   child: Text(
//                     '$title',
//                     style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.w400,
//                         color: AppColors.kamivestBlue),
//                   ),
//                 ),
//                 Space.spacerH10,
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         ...items
//                             .map((x) => ListTile(
//                                 tileColor: x == selected
//                                     ? AppColors.kamivestBlue
//                                     : Colors.white,
//                                 onTap: () {
//                                   Navigator.pop(context, x);
//                                 },
//                                 title: Text(
//                                   '${x}',
//                                   style: TextStyle(
//                                       color: x == selected
//                                           ? Colors.white
//                                           : Colors.black),
//                                 ),
//                                 selectedTileColor: AppColors.kamivestBlue))
//                             .toList()
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       });
// }