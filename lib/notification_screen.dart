part of 'main.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final groups = <String, List<_NotificationItem>>{
      'Last 7 days': const [
        _NotificationItem('Profile Update', 'Lengkapi Profilemu!',
            Icons.person_outline_rounded, _NotifAction.profile),
        _NotificationItem('App Announcement', 'Informasi terbaru NesaDate',
            Icons.info_outline_rounded, _NotifAction.none),
        _NotificationItem('New Message', 'Ada pesan baru masuk',
            Icons.chat_bubble_outline_rounded, _NotifAction.chat),
        _NotificationItem('Chat Reminder', 'Pengingat untuk membalas percakapan',
            Icons.chat_bubble_outline_rounded, _NotifAction.chat),
      ],
      'Last 14 days': const [
        _NotificationItem('New Message', 'Ada pesan baru masuk',
            Icons.chat_bubble_outline_rounded, _NotifAction.chat),
        _NotificationItem('Chat Reminder', 'Pengingat untuk membalas percakapan',
            Icons.chat_bubble_outline_rounded, _NotifAction.chat),
        _NotificationItem('Profile Likes', '2 Orang Menyukai profilemu',
            Icons.favorite_rounded, _NotifAction.likes),
        _NotificationItem('Profile Likes', '6 Orang Menyukai profilemu',
            Icons.favorite_rounded, _NotifAction.likes),
      ],
      'Last 21 days': const [
        _NotificationItem('System Notification',
            'Informasi terkait keamanan akun', Icons.lock_outline_rounded,
            _NotifAction.none),
        _NotificationItem('Profile Likes', '1 Orang Menyukai profilemu',
            Icons.favorite_rounded, _NotifAction.likes),
        _NotificationItem('New Message', 'Ada pesan baru masuk',
            Icons.chat_bubble_outline_rounded, _NotifAction.chat),
      ],
      'Last 28 days': const [
        _NotificationItem('New Message', 'Ada pesan baru masuk',
            Icons.chat_bubble_outline_rounded, _NotifAction.chat),
      ],
    };

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(18, 16, 18, 6),
              child: Center(
                child: Text(
                  'Notification',
                  style: TextStyle(
                    color: AppColors.navy,
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.3,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(22, 2, 22, 124),
                children: [
                  for (final entry in groups.entries) ...[
                    Padding(
                      padding: const EdgeInsets.only(top: 14, bottom: 6),
                      child: Text(
                        entry.key,
                        style: const TextStyle(
                          color: AppColors.navy,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    for (final n in entry.value) _NotificationTile(item: n),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NesaBottomNav(
        index: 0,
        onTap: (i) => Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => MainShell(initial: i)),
        ),
      ),
    );
  }
}

enum _NotifAction { chat, likes, profile, none }

class _NotificationItem {
  final String title, subtitle;
  final IconData icon;
  final _NotifAction action;
  const _NotificationItem(this.title, this.subtitle, this.icon, this.action);
}

class _NotificationTile extends StatelessWidget {
  final _NotificationItem item;
  const _NotificationTile({required this.item});

  @override
  Widget build(BuildContext context) {
    void openChat() => go(context, const ChatRoomScreen());
    return InkWell(
      onTap: () {
        switch (item.action) {
          case _NotifAction.chat:
            openChat();
          case _NotifAction.likes:
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const MainShell(initial: 1)),
            );
          case _NotifAction.profile:
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const MainShell(initial: 4)),
            );
          case _NotifAction.none:
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(item.title)),
            );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.blue, width: 2.5),
              ),
              child: Icon(item.icon, color: AppColors.blue, size: 34),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF111111),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.subtitle,
                    style: const TextStyle(
                      color: AppColors.grey,
                      fontSize: 13,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            if (item.action == _NotifAction.chat)
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: SizedBox(
                  width: 78,
                  height: 32,
                  child: FilledButton(
                    onPressed: openChat,
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.blue,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Message',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
