part of 'main.dart';

class PersonCard extends StatelessWidget {
  final String name, campus;
  const PersonCard(this.name, this.campus, {super.key});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => go(context, ChatRoomScreen(name: name.split(',').first)),
        child: Container(
          width: 168,
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: const [
              BoxShadow(
                  color: AppColors.softShadow,
                  blurRadius: 12,
                  offset: Offset(0, 6)),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Stack(
              fit: StackFit.expand,
              children: [
                PhotoCover(name: name, radius: BorderRadius.zero),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(12, 36, 12, 12),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.transparent, Color(0xCC000000)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: .22),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            campus,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 8.5),
                          ),
                        ),
                        const SizedBox(height: 6),
                        SizedBox(
                          height: 20,
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: () => go(
                              context,
                              ChatRoomScreen(name: name.split(',').first),
                            ),
                            style: FilledButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: AppColors.blue,
                              padding: EdgeInsets.zero,
                              shape: const StadiumBorder(),
                            ),
                            child: const Text(
                              'Message',
                              style: TextStyle(
                                  fontSize: 9, fontWeight: FontWeight.w500),
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
      );
}
