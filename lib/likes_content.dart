part of 'main.dart';

class LikesContent extends StatelessWidget {
  const LikesContent({super.key});

  @override
  Widget build(BuildContext context) {
    final data = <String, List<_LikeItem>>{
      'Last 7 days': const [
        _LikeItem('Rey', 'and two other liked your Photo'),
        _LikeItem('Cika', 'You matched with Cika',
            matched: true, message: true),
        _LikeItem('Lisa', 'and two other liked your Photo'),
        _LikeItem('Intan', 'liked your Photo', message: true),
        _LikeItem('Putri', 'liked your Photo', message: true),
        _LikeItem('Yuna', 'and two other liked your Photo'),
        _LikeItem('Zahra', 'and two other liked your Photo'),
        _LikeItem('Naomi', 'You matched with Naomi',
            matched: true, message: true),
      ],
      'Last 14 days': const [
        _LikeItem('Luna', 'and two other liked your Photo'),
        _LikeItem('Reva', 'You matched with Reva',
            matched: true, message: true),
        _LikeItem('Yukii', 'You matched with yukii',
            matched: true, message: true),
        _LikeItem('Vanessha', 'liked your Photo', message: true),
      ],
    };

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 10, 16, 4),
              child: Center(
                child: Text(
                  'Likes You',
                  style: TextStyle(
                    color: AppColors.navy,
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 4, 14, 110),
                children: [
                  for (final entry in data.entries) ...[
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 12,
                        bottom: 8,
                        left: 1,
                      ),
                      child: Text(
                        entry.key,
                        style: const TextStyle(
                          color: AppColors.navy,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    for (final item in entry.value) _LikeTile(item: item),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LikeItem {
  final String name;
  final String subtitle;
  final bool matched;
  final bool message;

  const _LikeItem(
    this.name,
    this.subtitle, {
    this.matched = false,
    this.message = false,
  });
}

class _LikeTile extends StatelessWidget {
  final _LikeItem item;

  const _LikeTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final second = secondPhotoForName(item.name);

    return SizedBox(
      height: 76,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 78,
            height: 70,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                if (second == null)
                  _LikePhotoBadge(
                    name: item.name,
                    matched: item.matched,
                  )
                else ...[
                  Positioned(
                    left: 0,
                    top: 1,
                    child: ProfilePhoto(
                      size: 54,
                      name: item.name,
                    ),
                  ),
                  Positioned(
                    left: 24,
                    top: 16,
                    child: _LikePhotoBadge(
                      name: item.name,
                      asset: second,
                      matched: item.matched,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF111111),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.grey,
                      fontSize: 11,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (item.message)
            SizedBox(
              width: 80,
              height: 27,
              child: FilledButton(
                onPressed: () => go(
                  context,
                  ChatRoomScreen(name: item.name),
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.blue,
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: const Text(
                  'Message',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _LikePhotoBadge extends StatelessWidget {
  final String name;
  final String? asset;
  final bool matched;

  const _LikePhotoBadge({
    required this.name,
    this.asset,
    required this.matched,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 54,
      height: 54,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ProfilePhoto(
            size: 54,
            name: name,
            asset: asset,
          ),
          Positioned(
            right: -2,
            bottom: -2,
            child: Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: matched ? AppColors.blue : const Color(0xFFF42A3C),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
              child: Icon(
                matched ? Icons.people_rounded : Icons.favorite_rounded,
                color: Colors.white,
                size: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
