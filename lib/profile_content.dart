part of 'main.dart';

class ProfileContent extends StatefulWidget {
  const ProfileContent({super.key});

  @override
  State<ProfileContent> createState() => _ProfileContentState();
}

class _ProfileContentState extends State<ProfileContent> {
  final _picker = ImagePicker();

  Future<void> _pickImage() async {
    final file = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 900,
    );

    if (file == null) return;

    final bytes = await file.readAsBytes();

    setState(() {
      AppState.photoBytes = bytes;
    });
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        title: const Text(
          'Logout',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: AppColors.navy,
          ),
        ),
        content: const Text(
          'Apakah kamu yakin ingin keluar dari akun?',
          style: TextStyle(fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Fitur logout akan dihubungkan setelah halaman login tersedia.',
                  ),
                ),
              );
            },
            child: const Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInterest(String interest) {
    return Expanded(
      child: Container(
        height: 35,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xFFBBD9FF),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFF72AEF5),
            width: 1.2,
          ),
        ),
        child: Text(
          interest,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Color(0xFF438FEA),
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
    bool isLogout = false,
  }) {
    return SizedBox(
      height: 42,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Row(
            children: [
              SizedBox(
                width: 42,
                child: Icon(
                  icon,
                  color: isLogout
                      ? const Color(0xFFE05252)
                      : const Color(0xFF505050),
                  size: 23,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    color: isLogout
                        ? const Color(0xFFE05252)
                        : const Color(0xFF222222),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final interests = AppState.interests.take(3).toList();

    return Container(
      color: AppColors.blue,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // HEADER
            const Padding(
              padding: EdgeInsets.fromLTRB(18, 16, 18, 4),
              child: Center(
                child: Text(
                  'Profiles',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.3,
                  ),
                ),
              ),
            ),

            // PROFILE CONTENT
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(17, 28, 17, 120),
                children: [
                  // PROFILE CARD + PROFILE IMAGE
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 83),
                        padding: const EdgeInsets.fromLTRB(
                          24,
                          108,
                          24,
                          38,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(38),
                        ),
                        child: Column(
                          children: [
                            // NAME AND GENDER
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Text(
                                    '${AppState.nickname}, ${AppState.age}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: AppColors.navy,
                                      fontSize: 26,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 9),
                                Icon(
                                  AppState.gender == 'Girl'
                                      ? Icons.female_rounded
                                      : Icons.male_rounded,
                                  color: AppColors.blue,
                                  size: 30,
                                ),
                              ],
                            ),

                            const SizedBox(height: 5),

                            // CAMPUS
                            Text(
                              AppState.campus,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xFF999999),
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            const SizedBox(height: 17),

                            // INTERESTS
                            Row(
                              children: [
                                for (int i = 0; i < interests.length; i++) ...[
                                  if (i > 0) const SizedBox(width: 9),
                                  _buildInterest(interests[i]),
                                ],
                              ],
                            ),

                            const SizedBox(height: 25),

                            // EDIT PROFILE BUTTON
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 17,
                              ),
                              child: SizedBox(
                                width: double.infinity,
                                height: 57,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFFBBD9FF),
                                        Color(0xFF78B6F8),
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    borderRadius: BorderRadius.circular(18),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0x55777777),
                                        blurRadius: 5,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      go(
                                        context,
                                        const EditProfileScreen(),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      foregroundColor: Colors.white,
                                      shadowColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18),
                                        side: const BorderSide(
                                          color: Colors.white,
                                          width: 1.5,
                                        ),
                                      ),
                                    ),
                                    child: const Text(
                                      'Edit Profile',
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // PROFILE PHOTO
                      Positioned(
                        top: 0,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: 184,
                              height: 184,
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.blue,
                                    width: 4,
                                  ),
                                ),
                                child: ClipOval(
                                  child: AppState.photoBytes != null
                                      ? Image.memory(
                                          AppState.photoBytes!,
                                          width: 172,
                                          height: 172,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset(
                                          AppState.photoAsset ??
                                              'assets/images/people/nathan.png',
                                          width: 172,
                                          height: 172,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                            ),

                            // CAMERA BUTTON
                            Positioned(
                              right: 5,
                              bottom: 19,
                              child: GestureDetector(
                                onTap: _pickImage,
                                child: Container(
                                  width: 49,
                                  height: 49,
                                  decoration: BoxDecoration(
                                    color: AppColors.blue,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2.5,
                                    ),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0x44777777),
                                        blurRadius: 5,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt_rounded,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 13),

                  // SETTINGS CARD
                  Container(
                    padding: const EdgeInsets.fromLTRB(
                      27,
                      22,
                      22,
                      22,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(38),
                    ),
                    child: Column(
                      children: [
                        _buildSettingItem(
                          icon: Icons.accessibility_new_rounded,
                          title: 'Your activity',
                          onTap: () => go(
                            context,
                            const SettingsDetailScreen(
                              title: 'Your activity',
                            ),
                          ),
                        ),

                        _buildSettingItem(
                          icon: Icons.access_time_rounded,
                          title: 'Time management',
                          onTap: () => go(
                            context,
                            const SettingsDetailScreen(
                              title: 'Time management',
                            ),
                          ),
                        ),

                        _buildSettingItem(
                          icon: Icons.lock_rounded,
                          title: 'Profile privacy',
                          onTap: () => go(
                            context,
                            const SettingsDetailScreen(
                              title: 'Profile privacy',
                            ),
                          ),
                        ),

                        _buildSettingItem(
                          icon: Icons.block_rounded,
                          title: 'Blocked',
                          onTap: () => go(
                            context,
                            const SettingsDetailScreen(
                              title: 'Blocked',
                            ),
                          ),
                        ),

                        _buildSettingItem(
                          icon: Icons.favorite_border_rounded,
                          title: 'Favorite',
                          onTap: () => go(
                            context,
                            const SettingsDetailScreen(
                              title: 'Favorite',
                            ),
                          ),
                        ),

                        _buildSettingItem(
                          icon: Icons.volume_off_rounded,
                          title: 'Muted',
                          onTap: () => go(
                            context,
                            const SettingsDetailScreen(
                              title: 'Muted',
                            ),
                          ),
                        ),

                        _buildSettingItem(
                          icon: Icons.devices_rounded,
                          title: 'Device Permissions',
                          onTap: () => go(
                            context,
                            const SettingsDetailScreen(
                              title: 'Device Permissions',
                            ),
                          ),
                        ),

                        _buildSettingItem(
                          icon: Icons.info_rounded,
                          title: 'About APP',
                          onTap: () => go(
                            context,
                            const SettingsDetailScreen(
                              title: 'About APP',
                            ),
                          ),
                        ),

                        // LOGOUT
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Divider(
                            color: Color(0xFFEEEEEE),
                            height: 1,
                          ),
                        ),

                        _buildSettingItem(
                          icon: Icons.logout_rounded,
                          title: 'Logout',
                          isLogout: true,
                          onTap: _showLogoutDialog,
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

class SettingsDetailScreen extends StatelessWidget {
  final String title;

  const SettingsDetailScreen({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pale,
      appBar: AppBar(
        backgroundColor: AppColors.blue,
        foregroundColor: AppColors.navy,
        elevation: 0,
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Text(
            'Halaman $title',
            style: const TextStyle(
              fontSize: 20,
              color: AppColors.navy,
            ),
          ),
        ),
      ),
    );
  }
}
