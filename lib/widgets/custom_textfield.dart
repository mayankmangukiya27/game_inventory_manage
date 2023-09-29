import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String? label, hint;
  final String? title;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final TextInputType? inputType;
  final int? maxLength;
  final bool? readOnly;
  final bool? obscureText;

  final Widget? suffixIcon;
  final Widget? prefixIcon;
  TextEditingController? controller = TextEditingController();
  String? Function(String?)? validator;
  String? Function(String?)? onFieldSubmitted;
  String? Function(String?)? onSave;
  void Function(bool)? onFocusChange;
  void Function(PointerDownEvent)? onTapOutside;
  Color? fillColor;
  List<TextInputFormatter>? inputFormatters;
  CustomTextField({
    Key? key,
    this.title,
    this.label,
    this.onFieldSubmitted,
    this.suffixIcon,
    this.prefixIcon,
    this.hint,
    this.controller,
    this.onTap,
    this.onChanged,
    this.inputType,
    this.maxLength,
    this.readOnly,
    this.obscureText,
    this.fillColor,
    this.validator,
    this.onFocusChange,
    this.onSave,
    this.onTapOutside,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Focus(
          onFocusChange: onFocusChange,
          child: TextFormField(
            obscureText: obscureText ?? false,
            enableInteractiveSelection: true,
            onTapOutside: onTapOutside,
            readOnly: readOnly ?? false,
            maxLength: maxLength,
            onTap: onTap,
            inputFormatters: inputFormatters,
            onChanged: onChanged,
            onFieldSubmitted: onFieldSubmitted,
            controller: controller,
            keyboardType: inputType,
            validator: validator,
            onSaved: onSave,
            decoration: InputDecoration(
                filled: true,
                fillColor: fillColor ?? Colors.white24,
                contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                counterText: "",
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.black)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.black)),
                disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.black)),
                hintText: hint ?? "",
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
                floatingLabelBehavior: FloatingLabelBehavior.never),
          ),
        ),
      ],
    );
  }
}
