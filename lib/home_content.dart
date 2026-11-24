part of 'main.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.homeBg,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // HEADER
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 18),
              child: Row(
                children: [
                  const NesaMark(
                    size: 34,
                    color: AppColors.navy,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'NesaDate',
                          style: TextStyle(
                            color: AppColors.navy,
                            fontSize: 21,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.7,
                          ),
                        ),
                        Text(
                          'Hello, ${AppState.nickname} 👋',
                          style: const TextStyle(
                            color: Color(0xFF778DA5),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Material(
                    color: Colors.white,
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () => go(
                        context,
                        const NotificationScreen(),
                      ),
                      child: const SizedBox(
                        width: 44,
                        height: 44,
                        child: Icon(
                          Icons.notifications_none_rounded,
                          color: AppColors.navy,
                          size: 23,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // CONTENT
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 125),
                children: [
                  // HERO
                  const _WelcomeBanner(),

                  const SizedBox(height: 27),

                  // ORGANISASI LUAR DAERAH
                  const _HomeSectionTitle(
                    title: 'Organisasi Luar Daerah',
                    subtitle: 'Meet students from different regions',
                    icon: Icons.groups_rounded,
                    action: 'See all',
                  ),

                  const SizedBox(height: 14),

                  SizedBox(
                    height: 188,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      clipBehavior: Clip.none,
                      children: const [
                        OrgCard(
                          'Stopia',
                          'Himpunan Mahasiswa Jabodetabek UNESA',
                          username: '@stopia.unesa',
                          colors: [
                            Color(0xFF477DA9),
                            Color(0xFF91C3FD),
                          ],
                        ),
                        OrgCard(
                          'Nabasa',
                          'Komunitas Mahasiswa Bandung UNESA',
                          username: '@nabasa.unesa',
                          colors: [
                            Color(0xFF6D9BB9),
                            Color(0xFFB5D8F1),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 29),

                  // PEOPLE
                  const _HomeSectionTitle(
                    title: 'People You May Know',
                    subtitle: 'Discover people around your campus',
                    icon: Icons.favorite_outline_rounded,
                    action: 'See all',
                  ),

                  const SizedBox(height: 14),

                  SizedBox(
                    height: 247,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      clipBehavior: Clip.none,
                      children: const [
                        PersonCard(
                          'Bunga, 19',
                          'UNESA Kampus 1 Ketintang',
                        ),
                        PersonCard(
                          'Anna, 20',
                          'UNESA Kampus 2',
                        ),
                        PersonCard(
                          'Hanni, 21',
                          'UNESA Kampus 2 Liwet',
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 29),

                  // EXPLORE
                  const _HomeSectionTitle(
                    title: 'Explore UNESA',
                    subtitle: 'Find your community and interests',
                    icon: Icons.explore_outlined,
                    action: 'See all',
                  ),

                  const SizedBox(height: 14),

                  SizedBox(
                    height: 188,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      clipBehavior: Clip.none,
                      children: const [
                        OrgCard(
                          'SRE Unesa',
                          'Society of Renewable Energy UNESA',
                          username: '@sre_unesa',
                          colors: [
                            Color(0xFF58A995),
                            Color(0xFFA9D9CB),
                          ],
                        ),
                        OrgCard(
                          'BEM Unesa',
                          'Badan Eksekutif Mahasiswa UNESA',
                          username: '@bem_unesa',
                          colors: [
                            Color(0xFFE3AD64),
                            Color(0xFFF4D9A9),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // FOOTER
                  Center(
                    child: Column(
                      children: [
                        const NesaMark(
                          size: 28,
                          color: AppColors.navy,
                        ),
                        const SizedBox(height: 9),
                        const Text(
                          'Meet, Match, Make Memories',
                          style: TextStyle(
                            color: AppColors.navy,
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Make your campus life more meaningful.',
                          style: TextStyle(
                            color: Color(0xFF91A5BB),
                            fontSize: 9,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'NesaDate © 2026',
                          style: TextStyle(
                            color: Color(0xFF9EADBD),
                            fontSize: 9,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ======================================================
// WELCOME BANNER
// ======================================================

class _WelcomeBanner extends StatelessWidget {
  const _WelcomeBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 205,
      padding: const EdgeInsets.fromLTRB(19, 17, 8, 17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(23),
        border: Border.all(
          color: const Color(0xFFDCE9F7),
          width: 1,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x10003770),
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.pale,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'YOUR CAMPUS COMPANION',
                    style: TextStyle(
                      color: AppColors.navy,
                      fontSize: 7.5,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  'Find Your People,\nFind Your Place.',
                  style: TextStyle(
                    color: AppColors.navy,
                    fontSize: 21,
                    height: 1.2,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.7,
                  ),
                ),
                const SizedBox(height: 9),
                const Text(
                  'Temukan teman baru dan komunitas yang sesuai dengan minatmu.',
                  style: TextStyle(
                    color: Color(0xFF71869C),
                    fontSize: 9.5,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 3),
          Expanded(
            flex: 5,
            child: Image.asset(
              'assets/images/illustrations/welcome_phone.png',
              fit: BoxFit.contain,
              alignment: Alignment.center,
            ),
          ),
        ],
      ),
    );
  }
}

// ======================================================
// SECTION TITLE
// ======================================================

class _HomeSectionTitle extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final String action;

  const _HomeSectionTitle({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 39,
          height: 39,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: AppColors.navy,
            size: 20,
          ),
        ),
        const SizedBox(width: 11),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.navy,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Color(0xFF8499AE),
                  fontSize: 9,
                ),
              ),
            ],
          ),
        ),
        Text(
          action,
          style: const TextStyle(
            color: AppColors.navy,
            fontSize: 10,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(width: 3),
        const Icon(
          Icons.arrow_forward_ios_rounded,
          size: 10,
          color: AppColors.navy,
        ),
      ],
    );
  }
}
