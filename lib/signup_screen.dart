part of 'main.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  void _register() {
    if (_formKey.currentState?.validate() ?? false) {
      AppState.nickname = _name.text.trim();

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const BasicInfoScreen()),
        (route) => false,
      );
    }
  }

  void _goToLogin() {
    final navigator = Navigator.of(context);
    if (navigator.canPop()) {
      navigator.pop();
    } else {
      navigator.pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: AppColors.blue,
      body: Column(
        children: [
          SizedBox(
            height: height * .31,
            child: Stack(
              children: [
                Positioned.fill(
                  child: NesaHeaderBackdrop(
                    height: height * .31,
                    bottomLeftFactor: 1,
                    bottomRightFactor: 1,
                  ),
                ),
                const SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(24, 0, 24, 18),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        BrandLogo(size: 200),
                        SizedBox(height: 4),
                        Text(
                          'Sign in to continue',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(46)),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(40, 42, 40, 28),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Text(
                        'Sign up to join',
                        style: TextStyle(
                          fontSize: 24,
                          color: Color(0xFFC4C4C4),
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.2,
                        ),
                      ),
                      const SizedBox(height: 10),
                      NDField(
                        'Name',
                        icon: Icons.person,
                        controller: _name,
                        validator: (v) {
                          final value = v?.trim() ?? '';
                          if (value.isEmpty) return 'Nama wajib diisi';
                          if (value.length < 2) {
                            return 'Nama minimal 2 karakter';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      NDField(
                        'Email Address',
                        icon: Icons.mail_outline,
                        controller: _email,
                        keyboardType: TextInputType.emailAddress,
                        compact: true,
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
                      const SizedBox(height: 10),
                      NDField(
                        'Password',
                        icon: Icons.lock,
                        controller: _password,
                        obscure: _obscurePassword,
                        suffix: IconButton(
                          onPressed: () => setState(
                              () => _obscurePassword = !_obscurePassword),
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: const Color(0xFFB9B9B9),
                            size: 20,
                          ),
                        ),
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return 'Password wajib diisi';
                          }
                          if (v.length < 6) {
                            return 'Password minimal 6 karakter';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      NDField(
                        'Re enter Password',
                        icon: Icons.lock,
                        controller: _confirm,
                        obscure: _obscureConfirm,
                        suffix: IconButton(
                          onPressed: () => setState(
                              () => _obscureConfirm = !_obscureConfirm),
                          icon: Icon(
                            _obscureConfirm
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: const Color(0xFFB9B9B9),
                            size: 20,
                          ),
                        ),
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return 'Konfirmasi password wajib diisi';
                          }
                          if (v != _password.text) {
                            return 'Konfirmasi password tidak sama';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 38),
                      NDButton(
                        'Sign up',
                        onTap: _register,
                        height: 55,
                        textSize: 14,
                      ),
                      const SizedBox(height: 22),
                      const _OrDivider(),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 53,
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: _register,
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.facebook,
                            shape: const StadiumBorder(),
                          ),
                          child: const Row(
                            children: [
                              SizedBox(width: 34),
                              Text(
                                'f',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                child: Text(
                                  'Sign up with facebook',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(width: 24),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          const Text(
                            'Have an account? ',
                            style: TextStyle(
                              color: Color(0xFFC4C4C4),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          GestureDetector(
                            onTap: _goToLogin,
                            child: const Text(
                              'Login in',
                              style: TextStyle(
                                color: AppColors.blue,
                                fontSize: 14,
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
          ),
        ],
      ),
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider();
  @override
  Widget build(BuildContext context) => Row(
        children: [
          const Expanded(child: Divider(color: Color(0xFFC4C4C4), height: 1)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Text(
              'or',
              style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
            ),
          ),
          const Expanded(child: Divider(color: Color(0xFFC4C4C4), height: 1)),
        ],
      );
}
