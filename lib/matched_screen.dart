part of 'main.dart';

class MatchedScreen extends StatelessWidget {
  final String matchedName;

  const MatchedScreen({
    super.key,
    required this.matchedName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.chatBg,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // CLOSE BUTTON
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(22, 12, 0, 0),
                child: GestureDetector(
                  onTap: () => Navigator.maybePop(context),
                  child: Container(
                    width: 46,
                    height: 46,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x22000000),
                          blurRadius: 8,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.close_rounded,
                      color: Color(0xFFAAAAAA),
                      size: 27,
                    ),
                  ),
                ),
              ),
            ),

            // PHOTO SECTION
            Expanded(
              flex: 5,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final w = constraints.maxWidth;
                  final h = constraints.maxHeight;

                  final cardWidth = w * 0.43;
                  final cardHeight = cardWidth * 1.22;

                  return Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      // FIRST PHOTO
                      Positioned(
                        left: w * 0.08,
                        top: h * 0.18,
                        child: Transform.rotate(
                          angle: -0.09,
                          child: SizedBox(
                            width: cardWidth,
                            height: cardHeight,
                            child: _photoCard('Nathan'),
                          ),
                        ),
                      ),

                      // SECOND PHOTO
                      Positioned(
                        right: w * 0.08,
                        top: h * 0.34,
                        child: Transform.rotate(
                          angle: 0.09,
                          child: SizedBox(
                            width: cardWidth,
                            height: cardHeight,
                            child: _photoCard(matchedName),
                          ),
                        ),
                      ),

                      // HEART
                      Container(
                        width: 66,
                        height: 66,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x22000000),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.favorite_rounded,
                          color: Color(0xFF91C2FF),
                          size: 40,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            // TITLE
            const Text(
              'You matched!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                color: Color(0xFF293A40),
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
            ),

            const SizedBox(height: 8),

            // SUBTITLE
            Text(
              'You and $matchedName have Matched!\nLets Talk!',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF293A40),
                height: 1.45,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 20),

            // MESSAGE
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 65),
              child: NDButton(
                'Message',
                height: 46,
                textSize: 14,
                onTap: () {
                  go(
                    context,
                    ChatRoomScreen(name: matchedName),
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            // LATER
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 65),
              child: SizedBox(
                height: 46,
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.maybePop(context),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    side: const BorderSide(
                      color: Colors.white,
                      width: 2,
                    ),
                    shape: const StadiumBorder(),
                  ),
                  child: const Text(
                    'Later',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 94),
          ],
        ),
      ),

      // BOTTOM NAVIGATION
      bottomNavigationBar: NesaBottomNav(
        index: 2,
        onTap: (i) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => MainShell(initial: i),
            ),
          );
        },
      ),
    );
  }

  // PHOTO CARD
  Widget _photoCard(String name) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.white,
          width: 4,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: PhotoCover(
          name: name,
          radius: BorderRadius.zero,
        ),
      ),
    );
  }
}
