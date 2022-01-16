import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trash_it/Resources/Resources.dart';

// ignore: must_be_immutable
class InputWidget extends StatelessWidget {
  String? hintText;
  bool? obscureText = false;
  final Function? validator;
  final Function? onSaved;
  final Function? onChanged;
  final Function? toggleEye;
  final TextInputType? keyboard;
  final String? init;
  final bool? isPassword;
  final Color? isPasswordColor;
  final bool? showObscureText;
  final Color? styleColor;
  final Color? hintStyleColor;
  final bool? enable;
  final String? labelText;
  final String? errorText;
  final dynamic maxLines;
  final Color? borderColor;
  final Color? fillColor;
  final Color? hintColor;
  final Color? textColor;
  final Color? labelColor;

  final Widget? prefix;
  final Widget? suffix;
  final Key? key;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final bool? alignLabelWithHint;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final Function? onTap;
  final double? borderRadius;
  InputWidget(
      {this.hintText,
      required this.obscureText,
      this.validator,
      this.onSaved,
      this.onChanged,
      this.toggleEye,
      this.keyboard,
      this.init,
      this.isPassword,
      this.isPasswordColor,
      this.showObscureText,
      this.styleColor,
      this.hintStyleColor,
      this.enable,
      this.labelText,
      this.errorText,
      this.maxLines,
      this.borderColor,
      this.fillColor,
      this.hintColor,
      this.textColor,
      this.labelColor,
      this.prefix,
      this.suffix,
      this.key,
      this.controller,
      this.inputFormatters,
      this.focusNode,
      this.alignLabelWithHint,
      this.floatingLabelBehavior,
      this.onTap,
      this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        shape: BoxShape.rectangle,
        color: R.colors.whiteMainColor,
      ),
      child:   TextFormField(
                onTap: onTap?.call(),
                focusNode: focusNode,
                inputFormatters: inputFormatters,
                controller: controller,
                key: key,
                enabled: enable,
                style: TextStyle(color: textColor ?? Color(0xFF3C4043)),
                cursorColor: styleColor,
                obscureText: obscureText!,
                maxLines: maxLines,
                onChanged: onChanged?.call(),
                decoration: InputDecoration(
                  floatingLabelBehavior: floatingLabelBehavior,
                  prefixIcon: prefix,
                  // suffixIcon: suffix,
                  filled: true,

                  fillColor: !enable!
                      ? fillColor ?? Color(0xFFeeeeee)
                      : fillColor ?? Colors.transparent,

                  alignLabelWithHint: true,
                  // labelText: labelText,
                  hintText: hintText,
                  errorText: errorText,
                  // prefixIcon: FaIcon(FontAwesomeIcons.arrowLeft, size: 10),
                  hintStyle: TextStyle(color: hintColor ?? Colors.grey),
                  isDense: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius ?? 5),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius ?? 5),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius ?? 5),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius ?? 5),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius ?? 5),
                    borderSide: BorderSide(color:  Colors.black),
                  ),
                  // contentPadding: EdgeInsets.only(top: 10, bottom: 10),
                  suffixIcon: isPassword!
                      ? GestureDetector(
                          onTap: toggleEye?.call(),
                          child: Icon(
                            showObscureText!
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Color(0xFFC0C1C3),
                          ),
                        )
                      : suffix,
                ),
                validator: 
                  validator?.call(),
                
                initialValue: init,
                onSaved: onSaved?.call(),
                keyboardType: keyboard,),
      // child: TextFormField(
      //   obscureText: obscureText!,
      //   decoration: new InputDecoration(
      //     fillColor: R.colors.whiteMainColor,
      //     focusedBorder: OutlineInputBorder(
      //       borderSide: BorderSide(color: R.colors.whiteMainColor, width: 1.0),
      //     ),
      //     enabledBorder: OutlineInputBorder(
      //       borderSide: BorderSide(color: R.colors.whiteMainColor, width: 1.0),
      //     ),
      //     hintText: hintText,
      //   ),
      // ),
    );
  }
}


class Input extends StatelessWidget {
  final String? hintText;
  final Function validator;
  final Function onSaved;
  final Function onChanged;
  final Function? toggleEye;
  final TextInputType? keyboard;
  final String? init;
  final bool? isPassword;
  final Color? isPasswordColor;
  final bool? showObscureText;
  final bool? obscureText;
  final Color? styleColor;
  final Color? hintStyleColor;
  final bool? enable;
  final String? labelText;
  final String? errorText;
  final dynamic maxLines;
  final Color? borderColor;
  final Color? fillColor;
  final Color? hintColor;
  final Color? textColor;
  final Color? labelColor;
  final String? inputIcon;
  final Widget? prefix;
  final Widget? suffix;
  final Key? key;
  final TextEditingController? controller;
  //final List<TextInputFormatter> inputFormatters;
  final FocusNode? focusNode;
  final bool? alignLabelWithHint;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final Function onTap;
  final double? borderRadius;
  Input(
      {this.hintText,
      this.labelColor,
      this.fillColor,
      this.textColor,
      this.borderRadius,
      required this.validator,
      this.hintColor,
      required this.onSaved,
      required this.toggleEye,
      this.init,
      this.isPassword = false,
      this.isPasswordColor,
      this.showObscureText,
      this.obscureText = false,
      this.keyboard,
      this.styleColor,
      this.hintStyleColor,
      this.enable = true,
      this.labelText,
      this.maxLines = 1,
      this.borderColor = Colors.grey,
      required this.onChanged,
      this.prefix,
      this.suffix,
      this.key,
      this.controller,
      this.focusNode,
      this.alignLabelWithHint,
      this.floatingLabelBehavior,
      required this.onTap,
      this.errorText,
      this.inputIcon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboard,
      controller: controller,
      key: key,
      enabled: enable,
      // onTap: onTap!(),
      // onChanged: onChanged!(),
      decoration: InputDecoration(
        suffixIcon: suffix,
            fillColor: !enable!
                      ? fillColor ?? Color(0xFFeeeeee)
                      : fillColor ?? Colors.white,
       // fillColor: Colors.white,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: R.colors.splashScreenViewPagerSelectedIndicatorColor,
            width: 1.0,
          ),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: hintStyleColor ?? Colors.grey,
          fontSize: 14,
        ),
        // prefixIcon: GestureDetector(
        //   onTap: toggleEye?.call(),
        //   child: Container(
        //     width: 60,
        //     height: 60,
        //     decoration: BoxDecoration(
        //         color: Colors.grey,
        //         border: Border.all(color:Colors.grey),
        //         borderRadius: BorderRadius.circular(18)),
        //    // margin: EdgeInsets.only(right: 20),
        //    // child: Center(child: SvgPicture.asset("assets/icons/$inputIcon")),
        //   ),
        // ),
      ),
    );
  }
}


enum KeyboardType { NUMBER, TEXT, EMAIL, PHONE }



// class DatePickerInput extends StatefulWidget {
//   String? hintText;
//   String? labelText;
//   Function validator;
//   Function onSaved;
//   Function onChanged;
//   VoidCallback? onTap;
//   String? init;
//   Function(DateTime) dateChanged;
//   DateTime? lastDate;
//   DateTime? initialDate;
//   DateTime? firstDate;
//   Color? hintColor;

//   DatePickerInput(
//       {Key? key,
//       this.hintText,
//       this.hintColor,
//       this.labelText,
//       required this.validator,
//       required this.onSaved,
//       required this.onChanged,
//       this.onTap,
//       this.init,
//       required this.dateChanged,
//       this.firstDate,
//       this.lastDate,
//       this.initialDate})
//       : super(key: key);

//   @override
//   _DatePickerInputState createState() => _DatePickerInputState();
// }

// class _DatePickerInputState extends State<DatePickerInput> {
//   DateTime selectedDate = DateTime.now();
//   FocusNode _focusNode = new FocusNode();

//   void _onDatePicked(DateTime picked) {
//     setState(() {
//       selectedDate = picked;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () async {
//         final DateTime data = await selectDate(
//             context: context,
//             initialDate: widget.initialDate ?? selectedDate,
//             firstDate: widget.firstDate ?? DateTime(2000),
//             lastDate: widget.lastDate ?? DateTime(2220));
//         widget.dateChanged(data);
//       },
//       child: TextFormField(
//         focusNode: _focusNode,
//         autovalidateMode: AutovalidateMode.onUserInteraction,
//         enabled: false,
//         decoration: InputDecoration(
//             contentPadding: EdgeInsets.zero,
//             isDense: true,
//             hintText: widget.hintText,
//             labelText: widget.labelText,
//             enabledBorder: InputBorder.none,
//             errorBorder: InputBorder.none,
//             border: InputBorder.none,
//             errorStyle: const TextStyle(height: 0),
//             focusedErrorBorder: InputBorder.none,
//             disabledBorder: InputBorder.none,
//             hintStyle: TextStyle(color: widget.hintColor ?? MyColors.grey2),
//             labelStyle: TextStyle(fontSize: 12.0, color: MyColors.black),
//             // suffixIcon: SvgPicture.asset(
//             //   'assets/images/calendar.svg',
//             //   fit: BoxFit.cover,
//             //   height: 10,
//             //   width: 10,
//             // ),
//             suffixIconConstraints: BoxConstraints(
//               minHeight: 32,
//               minWidth: 32,
//             )),
//         validator: widget.validator,
//         initialValue: widget.init,
//         onSaved: widget.onSaved,
//       ),
//     );
//   }
// }
