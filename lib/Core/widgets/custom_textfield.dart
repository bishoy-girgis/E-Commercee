import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? initialValue, hint;
  final String? Function(String?)? onValidate;
  final void Function(String?)? onChanged, onFieldSubmitted, onSaved;
  final void Function()? onTap, onEditingComplete;
  final int? maxLines, minLines, maxLength;
  final bool? isPassword, enabled;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final AutovalidateMode? autovalidateMode;
  final Widget? prefix;
  final double radiusBorder;

  const CustomTextField(
      {super.key,
      this.radiusBorder = 15,
      this.prefix,
      this.hint,
      this.inputFormatters,
      this.autovalidateMode,
      this.focusNode,
      this.enabled,
      this.controller,
      this.initialValue,
      this.onValidate,
      this.onChanged,
      this.onFieldSubmitted,
      this.onSaved,
      this.onTap,
      this.onEditingComplete,
      this.maxLines,
      this.minLines,
      this.maxLength,
      this.isPassword,
      this.keyboardType});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      initialValue: widget.initialValue,
      validator: widget.onValidate,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onFieldSubmitted,
      onSaved: widget.onSaved,
      onTap: widget.onTap,
      onEditingComplete: widget.onEditingComplete,
      maxLines: (widget.isPassword ?? false) ? 1 : widget.maxLines,
      minLines: widget.minLines,
      maxLength: widget.maxLength,
      obscureText: widget.isPassword ?? false ? obscureText : false,
      obscuringCharacter: "*",
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      enabled: widget.enabled,
      autovalidateMode: widget.autovalidateMode,
      focusNode: widget.focusNode,
      decoration: InputDecoration(
        prefixIcon: widget.prefix,
        suffixIcon: widget.isPassword == true
            ? IconButton(
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
              )
            : null,
        hintText: widget.hint,
        hintStyle: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.w300, color: Colors.black),
        fillColor: Colors.white,
        filled: true,
        border:  OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(widget.radiusBorder)),
          borderSide: const BorderSide(color: Color(0XFF004182), width: 1),
        ),
        contentPadding: const EdgeInsets.only(left: 15, right: 15),
        enabledBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(widget.radiusBorder)),
          borderSide: const BorderSide(color: Color(0XFF004182), width: 1),
        ),
      ),
    );
  }
}
