part of 'main.dart';

class PhotoProfileScreen extends StatefulWidget {
  const PhotoProfileScreen({super.key});

  @override
  State<PhotoProfileScreen> createState() => _PhotoProfileScreenState();
}

class _PhotoProfileScreenState extends State<PhotoProfileScreen> {
  final ImagePicker _picker = ImagePicker();

  Uint8List? _bytes;

  @override
  void initState() {
    super.initState();
    _bytes = AppState.photoBytes;
  }

  Future<void> _pickImage() async {
    try {
      final file = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 900,
        imageQuality: 85,
      );

      if (file == null) return;

      final bytes = await file.readAsBytes();

      if (!mounted) return;

      setState(() {
        _bytes = bytes;
      });
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Gagal memilih foto. Silakan coba lagi.'),
        ),
      );
    }
  }

  void _save() {
    AppState.photoBytes = _bytes;

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => const HomeScreen(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) => OnboardScaffold(
        title: 'Photo Profile',
        subtitle: 'Pilih foto profil yang ingin kamu\ntampilkan di Discover.',
        step: 4,
        action: 'save',
        onNext: _save,
        content: Column(
          children: [
            const SizedBox(height: 34),
            LayoutBuilder(
              builder: (context, constraints) {
                final size = math.min(
                  336.0,
                  constraints.maxWidth,
                );

                return SizedBox(
                  height: size,
                  child: Center(
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          width: size,
                          height: size,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.blue,
                              width: 4,
                            ),
                            color: const Color(0xFFF2F8FF),
                          ),
                          child: ClipOval(
                            child: _bytes != null
                                ? Image.memory(
                                    _bytes!,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    AppState.photoAsset ??
                                        'assets/images/people/nathan.png',
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        Positioned(
                          right: 8,
                          bottom: 8,
                          child: GestureDetector(
                            onTap: _pickImage,
                            child: Container(
                              width: 72,
                              height: 72,
                              decoration: BoxDecoration(
                                color: AppColors.blue,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x22000000),
                                    blurRadius: 8,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.camera_alt_rounded,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 26),
            _step(4),
          ],
        ),
      );
}
