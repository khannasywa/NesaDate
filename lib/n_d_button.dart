part of 'main.dart';

class NDButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool outlined;
  final bool whiteOutline;
  final double height;
  final double? textSize;
  const NDButton(
    this.text, {
    super.key,
    required this.onTap,
    this.outlined = false,
    this.whiteOutline = false,
    this.height = 52,
    this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = whiteOutline ? Colors.white : AppColors.blue;
    return SizedBox(
      height: height,
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: outlined ? Colors.transparent : AppColors.blue,
          foregroundColor: Colors.white,
          side: BorderSide(
            color: borderColor,
            width: outlined ? 1.6 : 0,
          ),
          shape: const StadiumBorder(),
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: textSize ?? 15,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
          ),
        ),
      ),
    );
  }
}
