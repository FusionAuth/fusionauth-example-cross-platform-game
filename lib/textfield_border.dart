import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BorderedTextField extends StatelessWidget {
  final String? hintText;
  final String? helperText;
  final Widget? prefixIcon;
  final Widget? suffix;
  final String? labelText;
  final String? initialValue;
  final Color? fillColor;
  final bool? enabled;
  final TextInputAction textInputAction;
  final TextInputType? inputType;
  final FocusNode? currentfocus;
  final FocusNode? nextfocus;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsetsGeometry? contentPadding;
  final TextEditingController? controller;
  final Function(String val)? onChanged;
  final String? Function(String? val)? validator;
  final Function()? toggleVisibility;
  final bool obscured;
  final bool showSuffix;
  final formKey;

  const BorderedTextField(
      {this.hintText,
      this.inputFormatters,
      this.toggleVisibility,
      this.validator,
      this.showSuffix = false,
      this.obscured = false,
      this.textInputAction = TextInputAction.next,
      this.helperText,
      this.suffix,
      this.enabled = true,
      this.prefixIcon,
      this.onChanged,
      this.labelText,
      this.initialValue,
      this.fillColor,
      this.controller,
      this.contentPadding,
      this.currentfocus,
      this.inputType,
      this.nextfocus,
      this.formKey});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      
      inputFormatters: inputFormatters,
      textInputAction: textInputAction,
      keyboardType: inputType,
      initialValue: initialValue,
      controller: controller,
      onChanged: onChanged,
      cursorColor: Theme.of(context).primaryColor,
      obscureText: obscured,
      onFieldSubmitted: (value) {},
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'Please fill field';
            }
            return null;
          },
      decoration: InputDecoration(
          focusColor: Theme.of(context).primaryColor,
          border:  OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          enabled: enabled ?? false,
          hintText: hintText,
          labelText: labelText,
          helperText: helperText,
          suffixIcon: showSuffix
              ? IconButton(
                  onPressed: toggleVisibility,
                  icon: Icon(
                    obscured ? Icons.visibility : Icons.visibility_off,
                    color: Theme.of(context).primaryColor,
                  ),
                )
              : const SizedBox()),
    );
  }
}
