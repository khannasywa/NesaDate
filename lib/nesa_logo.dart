part of 'main.dart';

/// Logo NesaDate (huruf N dengan hati kecil di kanan atas).
class NesaMark extends StatelessWidget {
  final double size;
  final Color color;
  const NesaMark({super.key, this.size = 112, this.color = Colors.white});

  static const _white = 'assets/images/illustrations/mark_white.png';
  static const _navy = 'assets/images/illustrations/mark_navy.png';
  static const _blue = 'assets/images/illustrations/mark_blue.png';

  @override
  Widget build(BuildContext context) {
    final src = color == Colors.white
        ? _white
        : color == AppColors.navy
            ? _navy
            : _blue;
    return Image.asset(
      src,
      width: size,
      height: size * .76,
      fit: BoxFit.contain,
      filterQuality: FilterQuality.high,
    );
  }
}

/// Logo lengkap (mark + tulisan NesaDate) untuk Splash, Sign up, dan Login.
class BrandLogo extends StatelessWidget {
  final double size;
  final String text;
  final Color color;
  const BrandLogo({
    super.key,
    this.size = 150,
    this.text = 'NesaDate',
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    if (color != Colors.white) {
      // Versi berwarna memakai mark + teks agar tetap tajam di latar terang.
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          NesaMark(size: size * .62, color: color),
          const SizedBox(height: 2),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: size * .26,
              fontWeight: FontWeight.w800,
              letterSpacing: -.8,
            ),
          ),
        ],
      );
    }
    return Image.asset(
      'assets/images/illustrations/logo_white.png',
      width: size,
      fit: BoxFit.contain,
      filterQuality: FilterQuality.high,
    );
  }
}
