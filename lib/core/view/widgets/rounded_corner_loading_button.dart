import '../../../export.dart';

class RoundedCornerLoadingButton extends StatefulWidget {
  const RoundedCornerLoadingButton({
    super.key,
    required this.onPressed,
    this.child,
    this.text,
    this.color,
    this.isOutlined = false,
    this.borderColor = kGreyColor,
    this.width,
    this.height,
  });

  final Function()? onPressed;
  final Color? color;
  final Color? borderColor;
  final Widget? child;
  final String? text;
  final double? width;
  final double? height;
  final bool isOutlined;

  @override
  State<RoundedCornerLoadingButton> createState() =>
      _RoundedCornerLoadingButtonState();
}

class _RoundedCornerLoadingButtonState
    extends State<RoundedCornerLoadingButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? double.infinity,
      height: widget.height ?? 48.h,
      child: ElevatedButton(
        style: widget.isOutlined
            ? ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: kPrimaryColor),
                )))
            : ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    widget.color ?? kPrimaryColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side:
                            BorderSide(color: widget.borderColor ?? kBlack)))),
        onPressed: widget.onPressed == null
            ? null
            : isLoading
                ? null
                : () async {
                    if (mounted) {
                      setState(() {
                        isLoading = true;
                      });
                    }
                    try {
                      await widget.onPressed!();
                    } catch (e, stackTrace) {
                      Logger().e(e);
                      Logger().e(stackTrace);
                    }
                    if (mounted) {
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
        child: (isLoading
            ? const Center(child: CircularProgressIndicator(color: kWhite))
            : widget.child ??
                Text((widget.text ?? '').toTitleCase(),
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(color: kWhite))),
      ),
    );
  }
}
