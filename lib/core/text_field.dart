import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gathrr/core/colors.dart';
import 'package:gathrr/core/consts.dart';

class CustomInputField extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? initialValue;
  final Function(String) onChanged;
  final Function(String)? onSubmit;
  final VoidCallback? onSaved;
  final TextInputType textInputType;
  final bool? readOnly;
  final bool isEnabled;
  final String hintText;
  final String? Function(String?) validator;
  final TextEditingController? textController;
  final bool obscureText;
  final bool isViewButtonRequired;
  final int? maxLength;
  final int maxLines;
  final bool isCounttextRequired;
  final bool isAutoValidteRequired;

  const CustomInputField(
      {super.key,
      required this.onChanged,
      this.onSubmit,
      this.onSaved,
      this.initialValue,
      required this.title,
      required this.textInputType,
      this.readOnly = false,
      this.isEnabled = true,
      this.hintText = '',
      required this.validator,
      this.textController,
      this.obscureText = false,
      this.isViewButtonRequired = false,
      this.maxLength,
      this.maxLines = 1,
      this.subtitle = "",
      this.isCounttextRequired = false,
      this.isAutoValidteRequired = false});

  List<TextInputFormatter>? _getInputFormatters(TextInputType inputType) {
    if (inputType == TextInputType.number) {
      return <TextInputFormatter>[
        FilteringTextInputFormatter.allow(
            RegExp(r'[0-9.]')), // Only allow digits and dot (for decimal input)
      ];
    } else if (inputType == TextInputType.text) {
      return <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(
            r'[a-zA-Z0-9\s]')), // Only allow alphanumeric characters and spaces
      ];
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title == ""
            ? const SizedBox()
            : Text(
                title,
                // style: labelTextStyle.copyWith(color: blackColor),
                style: TextStyle(
                  color: primaButtonColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
        title == "" ? const SizedBox() : kheight5,
        subtitle == ""
            ? const SizedBox()
            : Text(
                subtitle,
                // style: labelTextStyle.copyWith(color: blackColor),
                style: const TextStyle(
                  // color: subtitleColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
        subtitle == "" ? const SizedBox() : kheight10,
        kheight5,
        TextFormField(
          maxLines: maxLines,
          maxLength: maxLength,
          controller: textController,
          obscureText: obscureText,
          inputFormatters: _getInputFormatters(textInputType),
          // enabled: isEnabled,
          initialValue: initialValue,
          keyboardType: textInputType,
          readOnly: readOnly ?? false,
          // style: inputFieldsStyle,
          onFieldSubmitted: onSubmit,
          onChanged: (newValue) {
            onChanged(newValue);
            if (isAutoValidteRequired) {
              if (newValue != "") {
                Form.of(context).validate();
              }
            }
          },

          validator: validator,
          decoration: InputDecoration(
            counterText: isCounttextRequired ? null : "",
            errorMaxLines: 1,
            hintText: hintText,
            labelText: hintText,
            hintStyle: TextStyle(
              fontSize: 14,
              color: secondaryTextColor,
              fontWeight: FontWeight.w400,
            ),
            labelStyle: TextStyle(
              fontSize: 14,
              color: hintTextColor,
              fontWeight: FontWeight.w400,
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.only(left: 12, top: 20),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(4),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(4),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(4),
            ),
            errorStyle: const TextStyle(fontSize: 12, color: Colors.red),
          ),
        ),
      ],
    );
  }
}
