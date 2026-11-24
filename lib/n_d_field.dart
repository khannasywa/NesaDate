part of 'main.dart';

class NDField extends StatelessWidget {
  final String hint;
  final IconData? icon;
  final bool obscure;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final Widget? suffix;
  final String? Function(String?)? validator;
  final bool filled;

  /// Gaya ringkas untuk form onboarding (tinggi ±41 px di frame desain).
  final bool compact;
  final Color borderColor;
  const NDField(
    this.hint, {
    super.key,
    this.icon,
    this.obscure = false,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.suffix,
    this.validator,
    this.filled = true,
    this.compact = false,
    this.borderColor = const Color(0xFFC4C4C4),
  });

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(compact ? 21 : 27);
    final hintColor =
        compact ? const Color(0xFFB9B9B9) : const Color(0xFFB9B9B9);
    final field = TextFormField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      onChanged: onChanged,
      validator: validator,
      style: TextStyle(
        fontSize: compact ? 14 : 14,
        color: const Color(0xFF293A40),
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: hintColor, fontSize: compact ? 14 : 14),
        prefixIcon: icon == null
            ? null
            : Padding(
                padding: EdgeInsets.only(
                  left: compact ? 17 : 18,
                  right: compact ? 8 : 12,
                ),
                child: Icon(
                  icon,
                  color: const Color(0xFFB9B9B9),
                  size: compact ? 20 : 22,
                ),
              ),
        prefixIconConstraints: const BoxConstraints(minWidth: 0),
        suffixIcon: suffix,
        errorStyle: const TextStyle(fontSize: 11, height: 1.1),
        contentPadding: EdgeInsets.symmetric(
          horizontal: compact ? 17 : 20,
          vertical: compact ? 10 : 16,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(
            color: compact ? AppColors.blue : borderColor,
            width: compact ? 1.2 : 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(
            color: AppColors.blue,
            width: compact ? 1.4 : 1.6,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.4),
        ),
        filled: filled,
        fillColor: Colors.white,
        isDense: compact,
      ),
    );
    if (!compact) return field;
    return SizedBox(height: 42, child: field);
  }
}
