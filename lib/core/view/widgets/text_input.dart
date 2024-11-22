import '../../../export.dart';

// TextField that takes TextEditingController from the main controller(ex:LoginController) to control text from outside to be independent widget
class TextInput extends StatelessWidget {
  const TextInput({
    super.key,
    this.focus,
    this.controller,
    this.function,
    required this.hint,
    this.spaceAfter = true,
    this.inputType,
    this.maxLength,
    this.registerFocus = false,
    this.isPass = false,
    this.onTap,
    this.disableInput = false,
    this.enabled = true,
    this.borderColor = kPrimaryColor,
    this.validate,
    this.suffixIcon,
    this.prefixIcon,
    this.fontSize,
    this.alignLabelWithHint = true,
    this.color = kGrey,
    this.onChanged,
    this.textColor = kWhite,
    this.showUnderline = true,
    this.hintColor = kWhite,
    this.autofillHints,
    this.minLines,
    this.maxLines,
    this.contentPadding,
    this.cursorColor,
  });

  final FocusNode? focus;
  final Function? function;
  final String hint;
  final bool spaceAfter;
  final TextInputType? inputType;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final Function(String value)? onChanged;
  final double? fontSize;
  final bool registerFocus;
  final bool? alignLabelWithHint;
  final bool isPass;
  final Function()? onTap;
  final bool disableInput;
  final bool enabled;
  final Color? borderColor;
  final Color? cursorColor;
  final String? Function(String?)? validate;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? color;
  final Color? textColor;
  final Color? hintColor;
  final EdgeInsets? contentPadding;
  final TextEditingController? controller;
  final bool showUnderline;
  final Iterable<String>? autofillHints;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.r,
      child: TextFormField(
        autofillHints: autofillHints,
        onTapOutside: (event) => FocusManager.instance.primaryFocus!.unfocus(),
        style: TextStyle(color: textColor ?? borderColor),
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          alignLabelWithHint: alignLabelWithHint,
          // to hide maxLength counter
          counterText: '',
          floatingLabelBehavior: FloatingLabelBehavior.never,
          contentPadding: contentPadding ?? const EdgeInsets.all(8),
          errorStyle: const TextStyle(fontSize: 12, height: 0.8),
          filled: color != null,
          fillColor: color,
          labelStyle: hintColor != null
              ? TextStyle(color: hintColor, fontSize: fontSize)
              : borderColor != null
                  ? TextStyle(color: borderColor, fontSize: fontSize)
                  : TextStyle(fontSize: fontSize),
          hintStyle: borderColor != null
              ? TextStyle(color: borderColor, fontSize: fontSize)
              : TextStyle(fontSize: fontSize),
          labelText: hint.toTitleCase(),
          suffixIcon: suffixIcon,
          suffixIconConstraints: const BoxConstraints(
            minWidth: 80,
          ),
          prefixIcon: prefixIcon,
          prefixIconConstraints: const BoxConstraints(
            minWidth: 80,
          ),
          border: !showUnderline
              ? InputBorder.none
              : const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                  Radius.circular(10),
                )),
          enabledBorder: borderColor != null
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                    width: 2.0,
                  ),
                )
              : null,
          focusedBorder: borderColor != null
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: borderColor!,
                    width: 2.0,
                  ),
                )
              : null,
        ),
        onTap: onTap,
        cursorColor: cursorColor ?? borderColor,
        onChanged: onChanged,
        minLines: minLines,
        maxLines: maxLines,
        textInputAction: TextInputAction.next,
        autofocus: registerFocus,
        enableInteractiveSelection: !disableInput,
        enabled: enabled,
        keyboardType: inputType,
        obscureText: isPass,
        inputFormatters: [
          if (inputType == TextInputType.number)
            FilteringTextInputFormatter.allow(RegExp("[-0-9,.]")),
        ],
        readOnly: disableInput,
        maxLength: maxLength,
        onFieldSubmitted: (v) async {
          FocusScope.of(context).requestFocus(focus);
          try {
            await function!();
          } catch (e) {}
        },
        validator: validate,
      ),
    );
  }
}
