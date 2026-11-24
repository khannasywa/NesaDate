import 'package:flutter/material.dart';

void main() => runApp(const NesaDateApp());

class AppColors {
  static const blue = Color(0xFF6EB2FD);
  static const lightBlue = Color(0xFFAED8FF);
  static const pale = Color(0xFFEAF4FF);
  static const navy = Color(0xFF123D68);
  static const grey = Color(0xFF9A9A9A);
  static const line = Color(0xFFD9E7F5);
}

class NesaDateApp extends StatelessWidget {
  const NesaDateApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'NesaDate',
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: AppColors.pale,
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.blue),
          fontFamily: 'Arial',
        ),
        home: const SplashScreen(),
      );
}

void go(BuildContext context, Widget page) =>
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));

class NDButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool outlined;

  const NDButton(
    this.text, {
    super.key,
    required this.onTap,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 48,
        width: double.infinity,
        child: OutlinedButton(
          onPressed: onTap,
          style: OutlinedButton.styleFrom(
            backgroundColor: outlined ? Colors.transparent : AppColors.blue,
            foregroundColor: outlined ? AppColors.blue : Colors.white,
            side: BorderSide(
              color: AppColors.blue,
              width: outlined ? 1.5 : 0,
            ),
            shape: const StadiumBorder(),
          ),
          child: Text(
            text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      );
}

class NDField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final bool obscure;

  const NDField(
    this.hint, {
    super.key,
    this.icon = Icons.circle_outlined,
    this.obscure = false,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 48,
        child: TextField(
          obscureText: obscure,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: Color(0xFFB8C0C8),
              fontSize: 14,
            ),
            prefixIcon: Icon(
              icon,
              color: const Color(0xFFB8C0C8),
              size: 21,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 18),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28),
              borderSide: const BorderSide(color: Color(0xFFD5D5D5)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28),
              borderSide: const BorderSide(color: AppColors.blue),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      );
}

class BrandLogo extends StatelessWidget {
  final double size;

  const BrandLogo({super.key, this.size = 86});

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              Icon(Icons.all_inclusive_rounded,
                  size: size, color: Colors.white),
              const Icon(Icons.favorite, color: Colors.white, size: 23),
            ],
          ),
          const Text(
            'NesaDate',
            style: TextStyle(
              color: Colors.white,
              fontSize: 27,
              fontWeight: FontWeight.w800,
              letterSpacing: -.8,
            ),
          ),
        ],
      );
}

class PageTitle extends StatelessWidget {
  final String title, subtitle;

  const PageTitle(
    this.title, {
    super.key,
    this.subtitle = '',
  });

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              color: AppColors.navy,
              fontWeight: FontWeight.w800,
            ),
          ),
          if (subtitle.isNotEmpty) ...[
            const SizedBox(height: 7),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
          ],
        ],
      );
}

class WhitePanel extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;

  const WhitePanel({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
  });

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        padding: padding,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(36),
          boxShadow: const [
            BoxShadow(
              color: Color(0x22000000),
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: child,
      );
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) go(context, const LoginScreen());
    });
  }

  @override
  Widget build(BuildContext context) => const Scaffold(
        backgroundColor: AppColors.blue,
        body: Center(child: BrandLogo(size: 112)),
      );
}

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColors.blue,
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 25),
              const BrandLogo(),
              const SizedBox(height: 25),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(34, 35, 34, 20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(42),
                    ),
                  ),
                  child: ListView(
                    children: [
                      const Text(
                        'Sign up to join',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 32),
                      const NDField('Name', icon: Icons.person),
                      const SizedBox(height: 12),
                      const NDField('Email Address', icon: Icons.mail_outline),
                      const SizedBox(height: 12),
                      const NDField('Password',
                          icon: Icons.lock, obscure: true),
                      const SizedBox(height: 12),
                      const NDField(
                        'Re enter Password',
                        icon: Icons.lock,
                        obscure: true,
                      ),
                      const SizedBox(height: 28),
                      NDButton(
                        'Sign up',
                        onTap: () => go(context, const BasicInfoScreen()),
                      ),
                      const SizedBox(height: 16),
                      const Center(
                        child: Text('or', style: TextStyle(color: Colors.grey)),
                      ),
                      const SizedBox(height: 12),
                      NDButton(
                        'f   Sign up with facebook',
                        onTap: () => go(context, const BasicInfoScreen()),
                      ),
                      const SizedBox(height: 24),
                      Center(
                        child: Wrap(
                          children: [
                            const Text(
                              'Have an account? ',
                              style: TextStyle(color: Colors.grey),
                            ),
                            GestureDetector(
                              onTap: () => go(context, const LoginScreen()),
                              child: const Text(
                                'Login in',
                                style: TextStyle(
                                  color: AppColors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}

Widget _social(IconData icon, String label) => Column(
      children: [
        Container(
          width: 65,
          height: 55,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: Icon(icon, size: 32, color: AppColors.blue),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(color: Colors.grey, fontSize: 11),
        ),
      ],
    );

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColors.blue,
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 24),
              const BrandLogo(size: 104),
              const SizedBox(height: 32),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: WhitePanel(
                    padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Login to join',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 35),
                        const NDField(
                          'Email Address',
                          icon: Icons.mail_outline,
                        ),
                        const SizedBox(height: 14),
                        const NDField(
                          'Password',
                          icon: Icons.lock,
                          obscure: true,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                        NDButton(
                          'Login',
                          onTap: () => go(context, const HomeScreen()),
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          '────────────     or     ────────────',
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _social(Icons.g_mobiledata, 'Google'),
                            _social(Icons.apple, 'Apple'),
                            _social(Icons.flutter_dash, 'Twitter'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 22),
              const Text(
                'Meet, Match, Make Memories',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 18),
            ],
          ),
        ),
      );
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
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColors.pale,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                color: AppColors.blue,
                padding: const EdgeInsets.fromLTRB(22, 12, 22, 24),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.arrow_back,
                            color: AppColors.navy,
                          ),
                        ),
                        Expanded(
                          child: PageTitle(title, subtitle: subtitle),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Transform.translate(
                  offset: const Offset(0, -2),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: SingleChildScrollView(
                      child: WhitePanel(child: content),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 10, 40, 8),
                child: NDButton(action, onTap: onNext),
              ),
              if (onSkip != null)
                TextButton(
                  onPressed: onSkip,
                  child: const Text(
                    'skip',
                    style: TextStyle(color: AppColors.blue, fontSize: 17),
                  ),
                ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      );
}

class BasicInfoScreen extends StatefulWidget {
  const BasicInfoScreen({super.key});

  @override
  State<BasicInfoScreen> createState() => _BasicInfoScreenState();
}

class _BasicInfoScreenState extends State<BasicInfoScreen> {
  String gender = 'Boy';
  String interest = 'Both';

  @override
  Widget build(BuildContext context) => OnboardScaffold(
        title: 'Basic Information',
        subtitle: 'Jawabanmu akan tersimpan di\nhalaman Profile.',
        step: 1,
        action: 'next',
        onNext: () => go(context, const CampusScreen()),
        onSkip: () => go(context, const CampusScreen()),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _q('1. Nama panggilan'),
            const NDField('enter your nickname...', icon: Icons.person_outline),
            const SizedBox(height: 17),
            _q('2. Berapa umurmu'),
            const NDField('enter your age...', icon: Icons.cake_outlined),
            const SizedBox(height: 17),
            _q('3. Apa jenis kelaminmu'),
            Row(
              children: ['Boy', 'Girl'].map((e) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: ChoiceChip(
                      label: SizedBox(
                        width: double.infinity,
                        child: Center(child: Text(e)),
                      ),
                      selected: gender == e,
                      onSelected: (_) => setState(() => gender = e),
                      selectedColor: const Color(0xFFD1E5FF),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                child: const Text(
                  'skip',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 10),
            _q('4. Kamu tertarik menemukan koneksi dengan siapa?'),
            DropdownButtonFormField<String>(
              initialValue: interest,
              items: ['Both', 'Boy', 'Girl']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) {
                if (v != null) setState(() => interest = v);
              },
              decoration: _dec('Drop down'),
            ),
            _step(1),
          ],
        ),
      );
}

Widget _q(String text) => Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.navy,
          fontSize: 17,
          fontWeight: FontWeight.w800,
        ),
      ),
    );

InputDecoration _dec(String hint) => InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.line),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.blue),
      ),
    );

class CampusScreen extends StatelessWidget {
  const CampusScreen({super.key});

  @override
  Widget build(BuildContext context) => OnboardScaffold(
        title: 'Campus Information',
        subtitle: 'Beberapa jawabanmu akan\nditampilkan di halaman Profile.',
        step: 2,
        action: 'next',
        onNext: () => go(context, const InterestsScreen()),
        onSkip: () => go(context, const InterestsScreen()),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 28),
            _q('1. Kamu berasal dari kampus UNESA mana?'),
            DropdownButtonFormField<String>(
              items: [
                'Kampus 1 Ketintang',
                'Kampus 2 Lidah Wetan',
                'Kampus 3 Magetan',
              ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (_) {},
              decoration: _dec('Drop down'),
            ),
            const SizedBox(height: 17),
            _q('2. Fakultas apa?'),
            const NDField('enter your faculty...'),
            const SizedBox(height: 17),
            _q('3. Program studi apa?'),
            const NDField('enter your program study...'),
            const SizedBox(height: 17),
            _q('4. Angkatan tahun berapa?'),
            const NDField('enter your year...'),
            _step(2),
          ],
        ),
      );
}

Widget _step(int n) => Padding(
      padding: const EdgeInsets.only(top: 22),
      child: Row(
        children: [
          const Expanded(child: Divider()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              '$n/4',
              style: const TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ),
          const Expanded(child: Divider()),
        ],
      ),
    );

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({super.key});

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  final selected = {'Gaming', 'Sports'};

  final hobbies = [
    'Music',
    'Movies & Series',
    'Gaming',
    'Photography',
    'Traveling',
    'Sports',
    'Reading',
    'Cooking',
    'Art & Design',
    'Fitness',
    'Technology',
    'Cafe Hopping',
    'Dancing',
    'Singing',
  ];

  @override
  Widget build(BuildContext context) => OnboardScaffold(
        title: 'Your Interests',
        subtitle: 'Temukan kesamaan dengan orang lain',
        step: 3,
        action: 'next',
        onNext: () {
          if (selected.length >= 2) {
            go(context, const PhotoProfileScreen());
          }
        },
        onSkip: () => go(context, const PhotoProfileScreen()),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pilih minimal 2 hobi yang kamu sukai:',
              style: TextStyle(
                color: AppColors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 18),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: hobbies.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2.6,
                crossAxisSpacing: 10,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (_, i) {
                final h = hobbies[i];
                final active = selected.contains(h);

                return ChoiceChip(
                  label: SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        h,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  selected: active,
                  onSelected: (v) {
                    setState(() {
                      if (v) {
                        selected.add(h);
                      } else {
                        selected.remove(h);
                      }
                    });
                  },
                  selectedColor: const Color(0xFFD2E6FF),
                  backgroundColor: const Color(0xFFE5E5E5),
                  labelStyle: TextStyle(
                    color: active ? AppColors.blue : Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
            _step(3),
          ],
        ),
      );
}

class PhotoProfileScreen extends StatelessWidget {
  const PhotoProfileScreen({super.key});

  @override
  Widget build(BuildContext context) => OnboardScaffold(
        title: 'Photo Profile',
        subtitle: 'Pilih foto profil yang ingin kamu\ntampilkan di Discover.',
        step: 4,
        action: 'save',
        onNext: () => go(context, const HomeScreen()),
        content: SizedBox(
          height: 390,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: 245,
                    height: 245,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.pale,
                      border: Border.all(color: AppColors.blue, width: 5),
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 130,
                      color: Colors.white,
                    ),
                  ),
                  CircleAvatar(
                    radius: 31,
                    backgroundColor: AppColors.blue,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.camera_alt, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              _step(4),
            ],
          ),
        ),
      );
}

class MainShell extends StatefulWidget {
  final int initial;

  const MainShell({super.key, this.initial = 0});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  late int index;

  final pages = const [
    HomeContent(),
    LikesContent(),
    DiscoverContent(),
    ChatContent(),
    ProfileContent(),
  ];

  @override
  void initState() {
    super.initState();
    index = widget.initial;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: IndexedStack(index: index, children: pages),
        bottomNavigationBar: SizedBox(
          height: 76,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: 62,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(color: Color(0x22000000), blurRadius: 4),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _nav(Icons.home, 0),
                    _nav(Icons.favorite, 1),
                    const SizedBox(width: 62),
                    _nav(Icons.chat_bubble, 3),
                    _nav(Icons.person, 4),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                child: GestureDetector(
                  onTap: () => setState(() => index = 2),
                  child: Container(
                    width: 68,
                    height: 68,
                    decoration: const BoxDecoration(
                      color: AppColors.blue,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x33000000),
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child:
                        const Icon(Icons.search, color: Colors.white, size: 38),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _nav(IconData icon, int i) => IconButton(
        onPressed: () => setState(() => index = i),
        icon: Icon(
          icon,
          size: 29,
          color: index == i ? AppColors.blue : Colors.grey,
        ),
      );
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => const MainShell();
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Column(
          children: [
            Container(
              height: 66,
              color: const Color(0xFFD8E9FF),
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Row(
                children: [
                  const Icon(Icons.all_inclusive,
                      color: AppColors.navy, size: 35),
                  const SizedBox(width: 8),
                  const Text(
                    'NesaDate',
                    style: TextStyle(
                      color: AppColors.navy,
                      fontSize: 23,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => go(context, const NotificationScreen()),
                    icon: const Icon(
                      Icons.notifications_none,
                      color: AppColors.navy,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Container(
                    height: 170,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: const [
                        BoxShadow(color: Color(0x22000000), blurRadius: 4),
                      ],
                    ),
                    child: const Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Meet, Match, Make Memories',
                                style: TextStyle(
                                  color: AppColors.blue,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Find your campus connection',
                                style: TextStyle(
                                  color: AppColors.navy,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.favorite, color: AppColors.blue, size: 70),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _section('Organisasi Mahasiswa'),
                  SizedBox(
                    height: 145,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: const [
                        OrgCard(
                            'STOPIA', 'Himpunan Mahasiswa Jabodetabek UNESA'),
                        OrgCard('N', 'Komunitas mahasiswa'),
                      ],
                    ),
                  ),
                  _section('Orang yang Mungkin Kamu Kenal'),
                  SizedBox(
                    height: 220,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: const [
                        PersonCard('Hanni, 21', 'UNESA Kampus 2 Lidah Wetan'),
                        PersonCard('Bunga, 19', 'UNESA Kampus 1 Ketintang'),
                        PersonCard('Anna, 20', 'UNESA Kampus 2'),
                      ],
                    ),
                  ),
                  _section('Rekomendasi Organisasi di Unesa'),
                  SizedBox(
                    height: 145,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: const [
                        OrgCard(
                            'SRE Unesa', 'Society of Renewable Energy UNESA'),
                        OrgCard('BEM', 'Badan Eksekutif Mahasiswa'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Center(
                    child: Text(
                      'Meet, Match, Make Memories',
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}

Widget _section(String title) => Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 8),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.navy,
          fontSize: 17,
          fontWeight: FontWeight.w900,
        ),
      ),
    );

class OrgCard extends StatelessWidget {
  final String name, desc;

  const OrgCard(this.name, this.desc, {super.key});

  @override
  Widget build(BuildContext context) => Container(
        width: 285,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: const [BoxShadow(color: Color(0x22000000), blurRadius: 4)],
        ),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundColor: AppColors.pale,
                    child: Icon(Icons.groups, color: AppColors.blue, size: 30),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            color: AppColors.navy,
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(desc,
                            maxLines: 2, style: const TextStyle(fontSize: 12)),
                        const Text(
                          '@unesa_community',
                          style: TextStyle(color: Colors.grey, fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 32,
              width: double.infinity,
              child: FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(backgroundColor: AppColors.blue),
                child: const Text('Join'),
              ),
            ),
          ],
        ),
      );
}

class PersonCard extends StatelessWidget {
  final String name, campus;

  const PersonCard(this.name, this.campus, {super.key});

  @override
  Widget build(BuildContext context) => Container(
        width: 175,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: AppColors.lightBlue,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFD5E8F9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.person, color: Colors.white, size: 90),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Text(name,
                      style: const TextStyle(
                          color: AppColors.navy, fontWeight: FontWeight.bold)),
                  Text(campus,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 10)),
                  const SizedBox(height: 5),
                  const Text('Message',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      );
}

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final groups = {
      'Last 7 days': [
        ('Profile Update', 'Lengkapi Profilemu!', Icons.person_outline),
        ('App Announcement', 'Informasi terbaru NesaDate', Icons.info_outline),
        ('New Message', 'Ada pesan baru masuk', Icons.chat_bubble_outline),
        (
          'Chat Reminder',
          'Pengingat untuk membalas percakapan',
          Icons.chat_bubble_outline
        ),
      ],
      'Last 14 days': [
        ('New Message', 'Ada pesan baru masuk', Icons.chat_bubble_outline),
        (
          'Chat Reminder',
          'Pengingat untuk membalas percakapan',
          Icons.chat_bubble_outline
        ),
        ('Profile Likes', '2 Orang Menyukai profilemu', Icons.favorite),
        ('Profile Likes', '6 Orang Menyukai profilemu', Icons.favorite),
      ],
      'Last 21 days': [
        (
          'System Notification',
          'Informasi terkait keamanan akun',
          Icons.lock_outline
        ),
        ('Profile Likes', '1 Orang Menyukai profilemu', Icons.favorite),
        ('New Message', 'Ada pesan baru masuk', Icons.chat_bubble_outline),
      ],
      'Last 28 days': [
        ('New Message', 'Ada pesan baru masuk', Icons.chat_bubble_outline),
      ],
    };

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(18),
              child: Text(
                'Notification',
                style: TextStyle(
                  color: AppColors.navy,
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: groups.entries.expand((g) {
                  return [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        g.key,
                        style: const TextStyle(
                          color: AppColors.navy,
                          fontSize: 19,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    ...g.value.map(
                      (n) => ListTile(
                        leading: Container(
                          width: 58,
                          height: 48,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.blue, width: 2),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Icon(n.$3, color: AppColors.blue),
                        ),
                        title: Text(n.$1,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(n.$2,
                            style: const TextStyle(color: Colors.grey)),
                      ),
                    ),
                  ];
                }).toList(),
              ),
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}

class DiscoverContent extends StatefulWidget {
  const DiscoverContent({super.key});

  @override
  State<DiscoverContent> createState() => _DiscoverContentState();
}

class _DiscoverContentState extends State<DiscoverContent> {
  int person = 0;
  final names = ['Nabila, 21', 'Juliana, 20', 'Aurel, 19'];

  @override
  Widget build(BuildContext context) => Container(
        color: AppColors.blue,
        child: SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(18),
                child: Text(
                  'Discover',
                  style: TextStyle(
                    color: AppColors.navy,
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 12, 30, 15),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD9EAF7),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                    child: Stack(
                      children: [
                        const Center(
                          child: Icon(Icons.person,
                              size: 210, color: Colors.white),
                        ),
                        Positioned(
                          left: 16,
                          bottom: 24,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                names[person % names.length],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 27,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              const Text(
                                'Cimahi, Jawa Barat',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ),
                              const Chip(
                                  label: Text('UNESA Kampus 1 Ketintang')),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _round(Icons.close, () => setState(() => person++)),
                    _round(Icons.favorite, () {
                      setState(() => person++);
                      go(context, const MatchedScreen());
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget _round(IconData i, VoidCallback f) => CircleAvatar(
        radius: 31,
        backgroundColor: Colors.white,
        child: IconButton(
          onPressed: f,
          icon: Icon(i, color: AppColors.blue, size: 35),
        ),
      );
}

class MatchedScreen extends StatelessWidget {
  const MatchedScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xFFCDE3FF),
        body: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 60),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 85,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 100, color: AppColors.blue),
                  ),
                  SizedBox(width: 8),
                  CircleAvatar(
                    radius: 85,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 100, color: AppColors.blue),
                  ),
                ],
              ),
              const SizedBox(height: 65),
              const Text(
                'You matched!',
                style: TextStyle(
                  fontSize: 34,
                  color: Color(0xFF243E4D),
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'You and Juliana has Matched!\nLets Talk!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17, color: AppColors.navy),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 55),
                child: NDButton(
                  'Message',
                  onTap: () => go(context, const ChatRoomScreen()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(55, 12, 55, 90),
                child: NDButton(
                  'Later',
                  outlined: true,
                  onTap: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ),
      );
}

class ChatContent extends StatefulWidget {
  const ChatContent({super.key});

  @override
  State<ChatContent> createState() => _ChatContentState();
}

class _ChatContentState extends State<ChatContent> {
  String tab = 'All';

  final chats = const [
    ('Naila', 'Jurusan apaa?', 2),
    ('Raisha', 'Hehe', 7),
    ('Azka', 'Ayoo main', 4),
    ('SRE Unesa', 'Bima: Info WFC dongg', 9),
    ('STOPIA', 'Lia: Kumpul di Gazebo Teknik yaa!', 9),
    ('Aurel', 'Suka main voli juga?', 6),
    ('Naura', 'Asli mana kamuu', 1),
    ('Diva', 'Salken yaa', 7),
    ('Nala', 'Wkwkwk', 4),
    ('Nela', 'Masa iyaa?', 9),
    ('Mila', 'Coba tebaak', 6),
    ('Laura', 'Aku asli Surabayaaa', 1),
  ];

  @override
  Widget build(BuildContext context) => Container(
        color: const Color(0xFFCDE3FF),
        child: SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  'Chat',
                  style: TextStyle(
                    color: AppColors.navy,
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              SizedBox(
                height: 68,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: List.generate(5, (i) => _storyAvatar()),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(18, 15, 18, 0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(32)),
                  ),
                  child: Column(
                    children: [
                      SegmentedButton<String>(
                        segments: const [
                          ButtonSegment(value: 'All', label: Text('All')),
                          ButtonSegment(value: 'Group', label: Text('Group')),
                          ButtonSegment(
                              value: 'Favorite', label: Text('Favorite')),
                        ],
                        selected: {tab},
                        onSelectionChanged: (s) =>
                            setState(() => tab = s.first),
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            'Messages',
                            style: TextStyle(
                              color: AppColors.navy,
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          children: chats
                              .where((c) => tab != 'Group' || c.$3 == 9)
                              .map(
                                (c) => ListTile(
                                  onTap: () => go(
                                    context,
                                    ChatRoomScreen(name: c.$1),
                                  ),
                                  contentPadding: EdgeInsets.zero,
                                  leading: const CircleAvatar(
                                    radius: 26,
                                    backgroundColor: AppColors.pale,
                                    child: Icon(Icons.person,
                                        color: AppColors.blue),
                                  ),
                                  title: Text(
                                    c.$1,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w900),
                                  ),
                                  subtitle: Text(c.$2,
                                      style:
                                          const TextStyle(color: Colors.grey)),
                                  trailing: CircleAvatar(
                                    radius: 12,
                                    backgroundColor: Colors.lightBlue,
                                    child: Text(
                                      c.$3 > 9 ? '+9' : '${c.$3}',
                                      style: const TextStyle(
                                          fontSize: 10, color: Colors.white),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _storyAvatar() => const Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: CircleAvatar(
          radius: 29,
          backgroundColor: Colors.white,
          child: Icon(Icons.person, color: AppColors.blue, size: 35),
        ),
      );
}

class ChatRoomScreen extends StatefulWidget {
  final String name;

  const ChatRoomScreen({super.key, this.name = 'Naila'});

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final controller = TextEditingController();

  final messages = <String, bool>{
    'Halooo, aku Naila': false,
    'Hai Naila! Salken Aku Nathan. btw kamu asli manaa': true,
    'Hai nathan': false,
    'Aku asli papua, terus ngerantau disby, kalo kamuu?': false,
    'Aku asal bandung Naii': true,
    'Kamu jurusan apa?': true,
    'Aku teknik Sipil nathh': false,
    'Seriuss nai?': true,
    'Kamu angkatan berapa naii emangnyaa?': true,
  };

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            children: [
              const CircleAvatar(
                backgroundColor: AppColors.pale,
                child: Icon(Icons.person, color: AppColors.blue),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.name,
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black)),
                  const Text('Online',
                      style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ],
          ),
          actions: const [
            Icon(Icons.call, color: Colors.grey),
            SizedBox(width: 18),
            Icon(Icons.more_vert, color: Colors.grey),
            SizedBox(width: 12),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                color: const Color(0xFFF3FAFF),
                child: ListView(
                  padding: const EdgeInsets.all(18),
                  children: const [
                    Center(child: Chip(label: Text('Today'))),
                  ],
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add, color: Colors.grey),
                    ),
                    Expanded(
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          hintText: '',
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (controller.text.trim().isNotEmpty) {
                          setState(() {
                            messages[controller.text.trim()] = true;
                            controller.clear();
                          });
                        }
                      },
                      icon: const Icon(Icons.send, color: AppColors.blue),
                    ),
                    const Icon(Icons.camera_alt, color: Colors.grey),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}

class LikesContent extends StatelessWidget {
  const LikesContent({super.key});

  @override
  Widget build(BuildContext context) {
    final data = {
      'Last 7 days': [
        ('Rey', 'and two other liked your Photo', false),
        ('Cika', 'You matched with Cika', true),
        ('Lisa', 'and two other liked your Photo', false),
        ('Intan', 'liked your Photo', false),
        ('Putri', 'liked your Photo', false),
        ('Yuna', 'and two other liked your Photo', false),
        ('Zahra', 'and two other liked your Photo', false),
        ('Naomi', 'You matched with Naomi', true),
      ],
      'Last 14 days': [
        ('Luna', 'and two other liked your Photo', false),
        ('Reva', 'You matched with Reva', true),
        ('Yukii', 'You matched with yukii', true),
        ('Vanessha', 'liked your Photo', false),
      ],
    };

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Likes You',
                style: TextStyle(
                  color: AppColors.navy,
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                children: data.entries.expand((group) {
                  return <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        group.key,
                        style: const TextStyle(
                          color: AppColors.navy,
                          fontSize: 19,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    ...group.value.map(
                      (person) => ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const CircleAvatar(
                          radius: 28,
                          backgroundColor: AppColors.pale,
                          child: Icon(Icons.person, color: AppColors.blue),
                        ),
                        title: Text(
                          person.$1,
                          style: const TextStyle(fontWeight: FontWeight.w900),
                        ),
                        subtitle: Text(person.$2,
                            style: const TextStyle(color: Colors.grey)),
                        trailing: person.$3
                            ? SizedBox(
                                width: 85,
                                height: 32,
                                child: FilledButton(
                                  onPressed: () =>
                                      go(context, const ChatRoomScreen()),
                                  style: FilledButton.styleFrom(
                                    backgroundColor: Colors.lightBlue,
                                    padding: EdgeInsets.zero,
                                  ),
                                  child: const Text('Message',
                                      style: TextStyle(fontSize: 11)),
                                ),
                              )
                            : const Icon(Icons.favorite, color: Colors.red),
                      ),
                    ),
                  ];
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileContent extends StatelessWidget {
  const ProfileContent({super.key});

  @override
  Widget build(BuildContext context) => Container(
        color: AppColors.blue,
        child: SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Profiles',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w900),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    WhitePanel(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: Column(
                        children: [
                          Transform.translate(
                            offset: const Offset(0, -12),
                            child: const CircleAvatar(
                              radius: 72,
                              backgroundColor: AppColors.blue,
                              child: CircleAvatar(
                                radius: 66,
                                backgroundColor: AppColors.pale,
                                child: Icon(Icons.person,
                                    color: AppColors.blue, size: 95),
                              ),
                            ),
                          ),
                          const Text(
                            'Nathan, 19  ♂',
                            style: TextStyle(
                              color: AppColors.navy,
                              fontSize: 25,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const Text(
                            'Unesa Kampus 1, Ketintang',
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            children: ['Sports', 'Music', 'Reading']
                                .map(
                                  (e) => Chip(
                                    label: Text(e),
                                    backgroundColor: const Color(0xFFD5E8FF),
                                    labelStyle: const TextStyle(
                                      color: AppColors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                          const SizedBox(height: 8),
                          NDButton(
                            'Edit Profile',
                            onTap: () => go(context, const EditProfileScreen()),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    WhitePanel(
                      child: Column(
                        children: [
                          for (final item in [
                            (Icons.verified_user, 'Your activity'),
                            (Icons.access_time, 'Time management'),
                            (Icons.lock, 'Profile privacy'),
                            (Icons.block, 'Blocked'),
                            (Icons.favorite_border, 'Favorite'),
                            (Icons.volume_off, 'Muted'),
                            (Icons.devices, 'Device Permissions'),
                            (Icons.info_outline, 'About APP'),
                          ])
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading:
                                  Icon(item.$1, color: Colors.grey.shade700),
                              title: Text(item.$2),
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

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Edit Profile')),
        body: ListView(
          padding: const EdgeInsets.all(22),
          children: [
            const NDField('Nama panggilan', icon: Icons.person),
            const SizedBox(height: 12),
            const NDField('Umur', icon: Icons.cake),
            const SizedBox(height: 12),
            const NDField('Fakultas'),
            const SizedBox(height: 12),
            const NDField('Program studi'),
            const SizedBox(height: 25),
            NDButton('Save', onTap: () => Navigator.pop(context)),
          ],
        ),
      );
}
