part of 'main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => const BasicInfoScreen(),
        ),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: AppColors.pale,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: height * .62,
            child: NesaHeaderBackdrop(
              height: height * .62,
              bottomLeftFactor: .76,
              bottomRightFactor: .88,
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 4),
                    child: BrandLogo(size: 220),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 26),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(22, 44, 22, 24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(32),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x1A003770),
                            blurRadius: 24,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            const Text(
                              'Login to join',
                              style: TextStyle(
                                fontSize: 24,
                                color: Color(0xFFC4C4C4),
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.2,
                              ),
                            ),
                            const SizedBox(height: 32),
                            NDField(
                              'Email Address',
                              icon: Icons.mail_outline,
                              controller: _email,
                              keyboardType: TextInputType.emailAddress,
                              validator: (v) {
                                final value = v?.trim() ?? '';
                                if (value.isEmpty) return 'Email wajib diisi';
                                if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                                    .hasMatch(value)) {
                                  return 'Format email tidak valid';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),
                            NDField(
                              'Password',
                              icon: Icons.lock,
                              controller: _password,
                              obscure: _obscure,
                              suffix: IconButton(
                                onPressed: () =>
                                    setState(() => _obscure = !_obscure),
                                icon: Icon(
                                  _obscure
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: const Color(0xFFB9B9B9),
                                  size: 20,
                                ),
                              ),
                              validator: (v) => (v == null || v.isEmpty)
                                  ? 'Password wajib diisi'
                                  : null,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () => ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content:
                                      Text('Fitur reset password segera hadir'),
                                )),
                                style: TextButton.styleFrom(
                                  padding:
                                      const EdgeInsets.only(top: 2, bottom: 8),
                                  minimumSize: Size.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: const Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    color: AppColors.grey,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            NDButton('Login',
                                onTap: _login, height: 53, textSize: 14),
                            const SizedBox(height: 24),
                            const _OrDivider(),
                            const SizedBox(height: 20),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _SocialButton(
                                    label: 'Google', type: _SocialType.google),
                                _SocialButton(
                                    label: 'Apple', type: _SocialType.apple),
                                _SocialButton(
                                    label: 'Twitter',
                                    type: _SocialType.twitter),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Wrap(
                              alignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                const Text(
                                  'Belum punya akun? ',
                                  style: TextStyle(
                                    color: Color(0xFF8FA3B8),
                                    fontSize: 11,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => const RegisterScreen(),
                                    ),
                                  ),
                                  child: const Text(
                                    'Register',
                                    style: TextStyle(
                                      color: AppColors.blue,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        color: Color(0xFFC4C4C4),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'PlusJakartaSans',
                      ),
                      children: [
                        TextSpan(text: 'Meet, Match, '),
                        TextSpan(
                          text: 'Make Memories',
                          style: TextStyle(color: AppColors.blue),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum _SocialType { google, apple, twitter }

class _SocialButton extends StatelessWidget {
  final String label;
  final _SocialType type;
  const _SocialButton({required this.label, required this.type});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Container(
            width: 70,
            height: 53,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF8A8A8A)),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            alignment: Alignment.center,
            child: _icon(),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(color: AppColors.grey, fontSize: 10),
          ),
        ],
      );

  Widget _icon() {
    final asset = switch (type) {
      _SocialType.google => 'assets/images/icons/google.png',
      _SocialType.apple => 'assets/images/icons/apple.png',
      _SocialType.twitter => 'assets/images/icons/twitter.png',
    };
    return Image.asset(asset, width: 26, height: 26, fit: BoxFit.contain);
  }
}
