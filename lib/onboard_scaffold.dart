part of 'main.dart';

/// Latar biru dengan potongan diagonal di bagian bawah, sesuai header
/// halaman onboarding pada frame Figma.
class NesaHeaderBackdrop extends StatelessWidget {
  final double height;
  final double bottomLeftFactor;
  final double bottomRightFactor;
  const NesaHeaderBackdrop({
    super.key,
    required this.height,
    this.bottomLeftFactor = .46,
    this.bottomRightFactor = .54,
  });

  @override
  Widget build(BuildContext context) => ClipPath(
        clipper: _NesaHeaderClipper(
          bottomLeftFactor: bottomLeftFactor,
          bottomRightFactor: bottomRightFactor,
        ),
        child: Container(height: height, color: AppColors.blue),
      );
}

class _NesaHeaderClipper extends CustomClipper<Path> {
  final double bottomLeftFactor;
  final double bottomRightFactor;
  const _NesaHeaderClipper({
    required this.bottomLeftFactor,
    required this.bottomRightFactor,
  });

  @override
  Path getClip(Size size) => Path()
    ..moveTo(0, 0)
    ..lineTo(size.width, 0)
    ..lineTo(size.width, size.height * bottomRightFactor)
    ..quadraticBezierTo(
      size.width * .55,
      size.height * (bottomRightFactor + .015),
      0,
      size.height * bottomLeftFactor,
    )
    ..close();

  @override
  bool shouldReclip(covariant _NesaHeaderClipper oldClipper) =>
      oldClipper.bottomLeftFactor != bottomLeftFactor ||
      oldClipper.bottomRightFactor != bottomRightFactor;
}

class OnboardScaffold extends StatelessWidget {
  final String title, subtitle;
  final int step;
  final Widget content;
  final String action;
  final VoidCallback onNext;
  final VoidCallback? onSkip;
  const OnboardScaffold({
    super.key,
    required this.title,
    required this.subtitle,
    required this.step,
    required this.content,
    required this.action,
    required this.onNext,
    this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: AppColors.pale,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: screenHeight * .58,
              child: const NesaHeaderBackdrop(
                height: double.infinity,
                bottomLeftFactor: .72,
                bottomRightFactor: .9,
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 30, 18, 18),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.maybePop(context),
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: AppColors.navy,
                          size: 21,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: PageTitle(title, subtitle: subtitle),
                        ),
                      ),
                      const SizedBox(width: 36),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(19, 0, 19, 20),
                    child: Column(
                      children: [
                        WhitePanel(
                          radius: 24,
                          padding: const EdgeInsets.fromLTRB(24, 30, 24, 22),
                          child: content,
                        ),
                        const SizedBox(height: 22),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: NDButton(
                            action,
                            onTap: onNext,
                            height: 41,
                            textSize: 18,
                          ),
                        ),
                        if (onSkip != null)
                          TextButton(
                            onPressed: onSkip,
                            style: TextButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 6),
                            ),
                            child: const Text(
                              'skip',
                              style: TextStyle(
                                color: AppColors.blue,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
