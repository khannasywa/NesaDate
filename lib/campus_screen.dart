part of 'main.dart';

class CampusScreen extends StatefulWidget {
  const CampusScreen({super.key});

  @override
  State<CampusScreen> createState() => _CampusScreenState();
}

class _CampusScreenState extends State<CampusScreen> {
  static const List<String> _campuses = [
    'Unesa Kampus 1, Ketintang',
    'Unesa Kampus 2, Lidah Wetan',
    'Unesa Kampus 3, Magetan',
    'Unesa Kampus 4, Gedangan',
    'Unesa Kampus 5, Magetan',
    'Unesa Kampus 6, Pacet',
    'Unesa Kampus 7, IKN',
    'Unesa Kampus 8, Manyar',
    'Unesa Kampus 9, Kawung',
    'Unesa Kampus 10, Teratai',
    'Unesa Kampus 11, Prigen',
  ];

  late String campus;
  late final TextEditingController _faculty;
  late final TextEditingController _program;
  late final TextEditingController _year;

  @override
  void initState() {
    super.initState();

    campus =
        _campuses.contains(AppState.campus) ? AppState.campus : _campuses.first;

    _faculty = TextEditingController(text: AppState.faculty);
    _program = TextEditingController(text: AppState.program);
    _year = TextEditingController(text: AppState.year);
  }

  @override
  void dispose() {
    _faculty.dispose();
    _program.dispose();
    _year.dispose();
    super.dispose();
  }

  void _save() {
    AppState.campus = campus;
    AppState.faculty = _faculty.text.trim();
    AppState.program = _program.text.trim();
    AppState.year = _year.text.trim();
  }

  void _next() {
    _save();
    go(context, const InterestsScreen());
  }

  void _skip() {
    _save();
    go(context, const InterestsScreen());
  }

  @override
  Widget build(BuildContext context) => OnboardScaffold(
        title: 'Campus Information',
        subtitle: 'Tell us about your university life.',
        step: 2,
        action: 'next',
        onNext: _next,
        onSkip: _skip,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 2),
            _sectionLabel('01', 'Kamu berasal dari kampus UNESA mana?'),
            const SizedBox(height: 11),
            DropdownButtonFormField<String>(
              initialValue: campus,
              isExpanded: true,
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColors.blue,
              ),
              style: const TextStyle(
                color: AppColors.navy,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              items: _campuses.map((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(
                    e,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => campus = value);
                }
              },
              decoration: _inputDecoration(
                'Pilih kampus',
                Icons.location_on_outlined,
              ),
            ),
            const SizedBox(height: 24),
            _sectionLabel('02', 'Fakultas apa?'),
            const SizedBox(height: 11),
            NDField(
              'Enter your faculty...',
              controller: _faculty,
              compact: true,
              icon: Icons.account_balance_outlined,
            ),
            const SizedBox(height: 24),
            _sectionLabel('03', 'Program studi apa?'),
            const SizedBox(height: 11),
            NDField(
              'Enter your program study...',
              controller: _program,
              compact: true,
              icon: Icons.menu_book_outlined,
            ),
            const SizedBox(height: 24),
            _sectionLabel('04', 'Angkatan tahun berapa?'),
            const SizedBox(height: 11),
            NDField(
              'Enter your year...',
              controller: _year,
              compact: true,
              keyboardType: TextInputType.number,
              icon: Icons.calendar_month_outlined,
            ),
            const SizedBox(height: 25),
            _step(2),
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

  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: Color(0xFFABB4C0),
        fontSize: 13,
      ),
      prefixIcon: Icon(
        icon,
        color: AppColors.blue,
        size: 19,
      ),
      filled: true,
      fillColor: const Color(0xFFF8FAFD),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 15,
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
    );
  }
}
