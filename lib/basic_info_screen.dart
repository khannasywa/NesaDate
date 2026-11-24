part of 'main.dart';

class BasicInfoScreen extends StatefulWidget {
  const BasicInfoScreen({super.key});

  @override
  State<BasicInfoScreen> createState() => _BasicInfoScreenState();
}

class _BasicInfoScreenState extends State<BasicInfoScreen> {
  final _nickname = TextEditingController();
  final _age = TextEditingController();

  String gender = 'Boy';
  String interest = 'Both';

  @override
  void dispose() {
    _nickname.dispose();
    _age.dispose();
    super.dispose();
  }

  void _save() {
    AppState.nickname =
        _nickname.text.trim().isEmpty ? 'Nathan' : _nickname.text.trim();

    AppState.age = _age.text.trim().isEmpty ? '19' : _age.text.trim();

    AppState.gender = gender;
  }

  void _next() {
    _save();
    go(context, const CampusScreen());
  }

  @override
  Widget build(BuildContext context) => OnboardScaffold(
        title: 'Basic Information',
        subtitle: 'Tell us a little about yourself',
        step: 1,
        action: 'next',
        onNext: _next,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 2),

            // NICKNAME
            _sectionLabel('01', 'Nama panggilan'),
            const SizedBox(height: 10),
            NDField(
              'Enter your nickname...',
              controller: _nickname,
              compact: true,
              icon: Icons.person_outline_rounded,
            ),

            const SizedBox(height: 23),

            // AGE
            _sectionLabel('02', 'Berapa umurmu?'),
            const SizedBox(height: 10),
            NDField(
              'Enter your age...',
              controller: _age,
              compact: true,
              keyboardType: TextInputType.number,
              icon: Icons.cake_outlined,
            ),

            const SizedBox(height: 25),

            // GENDER
            _sectionLabel('03', 'Apa jenis kelaminmu?'),
            const SizedBox(height: 5),
            const Text(
              'Pilih salah satu yang sesuai dengan dirimu.',
              style: TextStyle(
                color: Color(0xFF929EAD),
                fontSize: 11,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 13),

            Row(
              children: [
                Expanded(
                  child: _genderOption(
                    label: 'Boy',
                    subtitle: 'Male',
                    icon: Icons.male_rounded,
                    selectedColor: const Color(0xFF559CF0),
                    selectedBg: const Color(0xFFEAF3FF),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _genderOption(
                    label: 'Girl',
                    subtitle: 'Female',
                    icon: Icons.female_rounded,
                    selectedColor: const Color(0xFFD58ACB),
                    selectedBg: const Color(0xFFFCF0FA),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 26),

            // INTEREST
            _sectionLabel(
              '04',
              'Kamu tertarik menemukan koneksi dengan siapa?',
            ),
            const SizedBox(height: 11),

            DropdownButtonFormField<String>(
              initialValue: interest,
              isExpanded: true,
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColors.blue,
              ),
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.navy,
                fontWeight: FontWeight.w600,
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Both',
                  child: Text('Everyone'),
                ),
                DropdownMenuItem(
                  value: 'Boy',
                  child: Text('Boy'),
                ),
                DropdownMenuItem(
                  value: 'Girl',
                  child: Text('Girl'),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() => interest = value);
                }
              },
              decoration: InputDecoration(
                hintText: 'Select your preference',
                filled: true,
                fillColor: const Color(0xFFF8FAFD),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 15,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: Color(0xFFE2EAF4),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: AppColors.blue,
                    width: 1.4,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // PROGRESS
            _step(1),
          ],
        ),
      );

  Widget _sectionLabel(String number, String title) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 25,
          height: 25,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFFEAF3FF),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            number,
            style: const TextStyle(
              color: AppColors.blue,
              fontSize: 10,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(
              title,
              style: const TextStyle(
                color: AppColors.navy,
                fontSize: 15,
                fontWeight: FontWeight.w800,
                height: 1.35,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _genderOption({
    required String label,
    required String subtitle,
    required IconData icon,
    required Color selectedColor,
    required Color selectedBg,
  }) {
    final isSelected = gender == label;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(17),
        onTap: () {
          setState(() {
            gender = label;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 12,
          ),
          decoration: BoxDecoration(
            color: isSelected ? selectedBg : Colors.white,
            borderRadius: BorderRadius.circular(17),
            border: Border.all(
              color: isSelected ? selectedColor : const Color(0xFFE6EAF0),
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: isSelected ? selectedColor : const Color(0xFFABB4C0),
                    size: 24,
                  ),
                  const SizedBox(width: 7),
                  Text(
                    label,
                    style: TextStyle(
                      color:
                          isSelected ? selectedColor : const Color(0xFF929EAD),
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                subtitle,
                style: TextStyle(
                  color: isSelected ? selectedColor : const Color(0xFFABB4C0),
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                width: 19,
                height: 19,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? selectedColor : Colors.transparent,
                  border: Border.all(
                    color: isSelected ? selectedColor : const Color(0xFFD6DDE6),
                    width: 1.3,
                  ),
                ),
                child: isSelected
                    ? const Icon(
                        Icons.check_rounded,
                        color: Colors.white,
                        size: 13,
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
