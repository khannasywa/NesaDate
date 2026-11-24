part of 'main.dart';

class DiscoverContent extends StatefulWidget {
  const DiscoverContent({super.key});
  @override
  State<DiscoverContent> createState() => _DiscoverContentState();
}

class _DiscoverContentState extends State<DiscoverContent> {
  int person = 0;
  final people = const [
    ('Nabila, 21', 'Cimahi, Jawa Barat', 'UNESA Kampus 1 Ketintang'),
    ('Juliana, 20', 'Bandung, Jawa Barat', 'UNESA Kampus 2 Lidah Wetan'),
    ('Aurel, 19', 'Surabaya, Jawa Timur', 'UNESA Kampus 1 Ketintang'),
  ];

  @override
  Widget build(BuildContext context) {
    final data = people[person % people.length];
    final height = MediaQuery.sizeOf(context).height;
    return Container(
      color: AppColors.discoverBg,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: height * .67,
            child: const ColoredBox(color: AppColors.blue),
          ),
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(18, 26, 18, 8),
                  child: Center(
                    child: Text(
                      'Discover',
                      style: TextStyle(
                        color: AppColors.navy,
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(26, 8, 26, 10),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          left: -18,
                          top: 24,
                          bottom: 24,
                          child: Container(
                            width: 42,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: .55),
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                        ),
                        Positioned(
                          right: -18,
                          top: 24,
                          bottom: 24,
                          child: Container(
                            width: 42,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: .55),
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            border: Border.all(color: Colors.white, width: 4),
                            boxShadow: const [
                              BoxShadow(
                                  color: Color(0x26003770),
                                  blurRadius: 18,
                                  offset: Offset(0, 10)),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                PhotoCover(
                                    name: data.$1, radius: BorderRadius.zero),
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        22, 80, 22, 24),
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.transparent,
                                          Color(0xB3000000)
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          data.$1,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 32,
                                            fontWeight: FontWeight.w800,
                                            letterSpacing: -0.4,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          data.$2,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 13, vertical: 5),
                                          decoration: BoxDecoration(
                                            color: Colors.white
                                                .withValues(alpha: .22),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                              color: Colors.white
                                                  .withValues(alpha: .6),
                                            ),
                                          ),
                                          child: Text(
                                            data.$3,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6, bottom: 112),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _action(
                        Icons.close_rounded,
                        () => setState(() => person++),
                      ),
                      _action(
                        Icons.favorite_rounded,
                        () {
                          final matchedName = data.$1;

                          setState(() => person++);

                          go(
                            context,
                            MatchedScreen(matchedName: matchedName),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _action(IconData icon, VoidCallback onTap) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: 72,
          height: 72,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  color: Color(0x22003770),
                  blurRadius: 12,
                  offset: Offset(0, 5)),
            ],
          ),
          child: Icon(icon, color: AppColors.blue, size: 42),
        ),
      );
}
