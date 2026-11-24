part of 'main.dart';

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({super.key});

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  late Set<String> selected;

  final List<String> hobbies = const [
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
  void initState() {
    super.initState();
    selected = AppState.interests.toSet();
  }

  void _save() {
    AppState.interests =
        hobbies.where((hobby) => selected.contains(hobby)).toList();
  }

  void _next() {
    if (selected.length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Pilih minimal 2 hobi terlebih dahulu',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    _save();
    go(context, const PhotoProfileScreen());
  }

  void _skip() {
    _save();
    go(context, const PhotoProfileScreen());
  }

  @override
  Widget build(BuildContext context) => OnboardScaffold(
        title: 'Your Interests',
        subtitle: 'Temukan kesamaan dengan orang lain',
        step: 3,
        action: 'next',
        onNext: _next,
        onSkip: _skip,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            const Text(
              'Pilih minimal 2 hobi yang kamu sukai:',
              style: TextStyle(
                color: AppColors.navy,
                fontWeight: FontWeight.w700,
                fontSize: 18,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 18),
            Wrap(
              spacing: 12,
              runSpacing: 11,
              children: [
                for (final hobby in hobbies)
                  _hobbyChip(
                    hobby,
                    active: selected.contains(hobby),
                    onTap: () {
                      setState(() {
                        if (selected.contains(hobby)) {
                          selected.remove(hobby);
                        } else {
                          selected.add(hobby);
                        }
                      });
                    },
                  ),
              ],
            ),
            _step(3),
          ],
        ),
      );

  Widget _hobbyChip(
    String label, {
    required bool active,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 42,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: active ? AppColors.chipBg : AppColors.chipIdleBg,
          borderRadius: BorderRadius.circular(21),
          border: Border.all(
            color: active ? AppColors.chipBorder : AppColors.chipIdleBorder,
            width: 1.2,
          ),
        ),
        child: Text(
          label,
          maxLines: 1,
          style: TextStyle(
            color: active ? AppColors.chipText : AppColors.grey,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
