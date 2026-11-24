part of 'main.dart';

class WhitePanel extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final double radius;
  const WhitePanel({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
    this.radius = 34,
  });

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        padding: padding,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius),
          boxShadow: const [
            BoxShadow(
                color: AppColors.softShadow,
                blurRadius: 18,
                offset: Offset(0, 8)),
          ],
        ),
        child: child,
      );
}
