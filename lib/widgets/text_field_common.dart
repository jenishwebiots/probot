import '../config.dart';

class TextFieldCommon extends StatelessWidget {
  final String hintText;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final Widget? suffixIcon, prefixIcon;
  final Color? fillColor;
  final bool obscureText;
  final InputBorder? border;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final int? maxLength;

  const TextFieldCommon(
      {Key? key,
        required this.hintText,
        this.validator,
        this.controller,
        this.suffixIcon,
        this.prefixIcon,
        this.border,
        this.obscureText = false,
        this.fillColor,
        this.keyboardType,
        this.onChanged,
        this.maxLength})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Text field common
    return TextFormField(
        obscureText: obscureText,
        keyboardType: keyboardType,
        validator: validator,
        controller: controller,
        onChanged: onChanged,
        maxLength: maxLength,
        decoration: InputDecoration(
            fillColor: appCtrl.appTheme.boxBg,
            filled: true,
            border: const OutlineInputBorder(
                borderRadius:
                BorderRadius.all(Radius.circular(AppRadius.r8)),
                borderSide:
                BorderSide(width: 0, style: BorderStyle.none)),
            contentPadding: const EdgeInsets.symmetric(
                horizontal: Insets.i15, vertical: Insets.i10),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            hintStyle: AppCss.outfitMedium14
                .textColor(appCtrl.appTheme.lightText),
            hintText: hintText.tr));
  }
}