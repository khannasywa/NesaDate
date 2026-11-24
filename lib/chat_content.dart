part of 'main.dart';

// JUMLAH STORY SETIAP USER
int storyCountFor(String name) {
  switch (name.toLowerCase()) {
    case 'naila':
      return 3;
    case 'raisha':
      return 1;
    case 'aurel':
      return 2;
    case 'naura':
      return 3;
    case 'diva':
      return 1;
    case 'azka':
      return 2;
    case 'bunga':
      return 1;
    default:
      return 1;
  }
}
// ======================================================
// STORY IMAGE ASSET
// ======================================================

String storyAssetFor(String name) {
  return 'assets/images/stories/${name.toLowerCase()}.jpg';
}

class ChatContent extends StatefulWidget {
  const ChatContent({super.key});

  @override
  State<ChatContent> createState() => _ChatContentState();
}

class _ChatContentState extends State<ChatContent> {
  String selectedFilter = 'All';

  final Set<String> viewedStories = {};

  final List<_ChatData> chats = const [
    _ChatData(
      name: 'Naila',
      message: 'Jurusan apaa?',
      unread: 2,
      online: true,
      favorite: true,
    ),
    _ChatData(
      name: 'Raisha',
      message: 'Hehe',
      unread: 7,
      online: true,
      favorite: true,
    ),
    _ChatData(name: 'Azka', message: 'Ayoo main', unread: 4, online: true),
    _ChatData(
      name: 'SRE Unesa',
      message: 'Bima: Info WFC dongg',
      unread: 9,
      group: true,
    ),
    _ChatData(
      name: 'STOPIA',
      message: 'Lia: Kumpul di Gazebo Teknik yaa!',
      unread: 9,
      group: true,
    ),
    _ChatData(
      name: 'BEM Unesa',
      message: 'Devi: Ayoo rek nongkrong',
      unread: 9,
      group: true,
    ),
    _ChatData(
      name: 'Aurel',
      message: 'Suka main voli juga?',
      unread: 6,
      favorite: true,
    ),
    _ChatData(name: 'Naura', message: 'Asli mana kamuuu', unread: 1),
    _ChatData(name: 'Diva', message: 'Salken yaaa', unread: 7),
    _ChatData(name: 'Nala', message: 'Wkwkwk', unread: 4),
    _ChatData(name: 'Nela', message: 'Masia iyaa?', unread: 9),
    _ChatData(name: 'Mila', message: 'Coba tebaak', unread: 6),
    _ChatData(name: 'Laura', message: 'Aku asli Surabayaaa', unread: 1),
  ];

  List<_ChatData> get filteredChats {
    if (selectedFilter == 'Group') {
      return chats.where((chat) => chat.group).toList();
    }

    if (selectedFilter == 'Favorite') {
      return chats.where((chat) => chat.favorite).toList();
    }

    return chats;
  }

  void _openStory(String name) {
    setState(() {
      viewedStories.add(name);
    });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => _StoryViewer(name: name)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.chatBg,
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  _buildFilter(),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      'Messages',
                      style: TextStyle(
                        color: AppColors.navy,
                        fontSize: 21,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.fromLTRB(18, 0, 18, 130),
                      itemCount: filteredChats.length,
                      itemBuilder: (context, index) {
                        final chat = filteredChats[index];

                        return _ChatListTile(
                          chat: chat,
                          onTap: () {
                            go(context, ChatRoomScreen(name: chat.name));
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ======================================================
  // HEADER + STORY
  // ======================================================

  Widget _buildHeader() {
    const storyNames = [
      'Naila',
      'Raisha',
      'Aurel',
      'Naura',
      'Diva',
      'Azka',
      'Bunga',
    ];

    return Container(
      width: double.infinity,
      height: 140,
      color: AppColors.chatBg,
      child: Column(
        children: [
          const SizedBox(height: 4),
          const Text(
            'Chat',
            style: TextStyle(
              color: AppColors.navy,
              fontSize: 26,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: storyNames.length,
              itemBuilder: (context, index) {
                final name = storyNames[index];

                return _StoryAvatar(
                  name: name,
                  viewed: viewedStories.contains(name),
                  online: name == 'Naila',
                  onTap: () => _openStory(name),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ======================================================
  // FILTER
  // ======================================================

  Widget _buildFilter() {
    const filters = ['All', 'Group', 'Favorite'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        height: 43,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: const Color(0xFFD9D9D9),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: filters.map((filter) {
            final selected = selectedFilter == filter;

            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedFilter = filter;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selected ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(
                    filter,
                    style: TextStyle(
                      color: selected
                          ? AppColors.navy
                          : const Color(0xFF555555),
                      fontSize: 16,
                      fontWeight: selected ? FontWeight.w500 : FontWeight.w400,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

// ======================================================
// DATA CHAT
// ======================================================

class _ChatData {
  final String name;
  final String message;
  final int unread;
  final bool online;
  final bool group;
  final bool favorite;

  const _ChatData({
    required this.name,
    required this.message,
    required this.unread,
    this.online = false,
    this.group = false,
    this.favorite = false,
  });
}

// ======================================================
// STORY AVATAR
// ======================================================

class _StoryAvatar extends StatelessWidget {
  final String name;
  final bool online;
  final bool viewed;
  final VoidCallback onTap;

  const _StoryAvatar({
    required this.name,
    required this.onTap,
    this.online = false,
    this.viewed = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 82,
        height: 78,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 72,
              height: 72,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: viewed
                    ? null
                    : const LinearGradient(
                        colors: [
                          Color(0xFF53A3FF),
                          Color(0xFF003770),
                          Color(0xFF91C3FD),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                color: viewed ? AppColors.lightGrey : null,
              ),
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  // FOTO STORIES, BUKAN FOTO PROFIL
                  child: Image.asset(
                    storyAssetFor(name),
                    width: 64,
                    height: 64,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) {
                      return const ColoredBox(
                        color: Color(0xFFEAF3FC),
                        child: Icon(
                          Icons.image_not_supported_rounded,
                          color: AppColors.navy,
                          size: 30,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            if (online)
              Positioned(
                right: 5,
                bottom: 2,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: AppColors.online,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.chatBg, width: 2),
                  ),
                ),
              ),

            Positioned(
              left: 0,
              right: 10,
              bottom: -1,
              child: Text(
                name,
                maxLines: 1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.navy,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ======================================================
// STORY DATA
// ======================================================

class _StoryData {
  final String caption;
  final IconData icon;
  final List<Color> colors;

  const _StoryData({
    required this.caption,
    required this.icon,
    required this.colors,
  });
}

// ======================================================
// FULLSCREEN STORY VIEWER
// ======================================================

class _StoryViewer extends StatefulWidget {
  final String name;

  const _StoryViewer({required this.name});

  @override
  State<_StoryViewer> createState() => _StoryViewerState();
}

class _StoryViewerState extends State<_StoryViewer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  int currentIndex = 0;

  late final List<_StoryData> stories = List.generate(
  storyCountFor(widget.name),
  (index) {
    const storyList = [
      _StoryData(
        number: '1',
        caption: 'Enjoying my day! ☀️',
        icon: Icons.wb_sunny_rounded,
        colors: [Color(0xFF91C3FD), Color(0xFFCEE4FF)],
      ),
      _StoryData(
        number: '2',
        caption: 'Another beautiful moment ✨',
        icon: Icons.auto_awesome_rounded,
        colors: [Color(0xFFB7D9F8), Color(0xFFE5F2FF)],
      ),
      _StoryData(
        number: '3',
        caption: 'See you around campus! 💙',
        icon: Icons.school_rounded,
        colors: [Color(0xFF7CB5EC), Color(0xFFD7EAFE)],
      ),
    ];

    return storyList[index];
  },
);
    _StoryData(
      caption: 'Enjoying my day! ☀️',
      icon: Icons.wb_sunny_rounded,
      colors: [Color(0xFF91C3FD), Color(0xFFCEE4FF)],
    ),
    _StoryData(
      caption: 'Another beautiful moment ✨',
      icon: Icons.auto_awesome_rounded,
      colors: [Color(0xFFB7D9F8), Color(0xFFE5F2FF)],
    ),
    _StoryData(
      caption: 'See you around campus! 💙',
      icon: Icons.school_rounded,
      colors: [Color(0xFF7CB5EC), Color(0xFFD7EAFE)],
    ),
  ];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _nextStory();
      }
    });

    _controller.forward();
  }

  void _nextStory() {
    if (!mounted) return;

    if (currentIndex < stories.length - 1) {
      setState(() {
        currentIndex++;
      });

      _controller.forward(from: 0);
    } else {
      Navigator.pop(context);
    }
  }

  void _previousStory() {
    if (!mounted) return;

    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });

      _controller.forward(from: 0);
    } else {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final story = stories[currentIndex];

    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapUp: (details) {
          final width = MediaQuery.of(context).size.width;

          if (details.localPosition.dx > width / 2) {
            _nextStory();
          } else {
            _previousStory();
          }
        },
        onLongPressStart: (_) {
          _controller.stop();
        },
        onLongPressEnd: (_) {
          _controller.forward();
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            // BACKGROUND FOTO STORIES, BUKAN PROFILE PHOTO
            Image.asset(
              storyAssetFor(widget.name),
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) {
                return const ColoredBox(
                  color: Color(0xFFB7D9F8),
                  child: Center(
                    child: Icon(
                      Icons.image_not_supported_rounded,
                      color: AppColors.navy,
                      size: 55,
                    ),
                  ),
                );
              },
            ),

            // OVERLAY
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.55),
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.55),
                  ],
                  stops: const [0, 0.25, 0.65, 1],
                ),
              ),
            ),

            // CONTENT
            SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 8),

                  // PROGRESS BAR
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: List.generate(stories.length, (index) {
                        return Expanded(
                          child: Container(
                            height: 3,
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: AnimatedBuilder(
                              animation: _controller,
                              builder: (context, child) {
                                double progress = 0;

                                if (index < currentIndex) {
                                  progress = 1;
                                } else if (index == currentIndex) {
                                  progress = _controller.value;
                                }

                                return Align(
                                  alignment: Alignment.centerLeft,
                                  child: FractionallySizedBox(
                                    widthFactor: progress,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      }),
                    ),
                  ),

                  const SizedBox(height: 15),

                  // USER INFORMATION
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Container(
                          width: 39,
                          height: 39,
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: ClipOval(
                            // FOTO PROFIL TETAP DI SINI
                            child: ProfilePhoto(size: 35, name: widget.name),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 13,
                                ),
                              ),
                              const Text(
                                '5 minutes ago',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.close_rounded,
                            color: Colors.white,
                            size: 27,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  // STORY CAPTION
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      children: [
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: story.colors,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            story.icon,
                            size: 42,
                            color: AppColors.navy,
                          ),
                        ),
                        const SizedBox(height: 22),
                        Text(
                          story.caption,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            shadows: [
                              Shadow(color: Colors.black38, blurRadius: 8),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  // REPLY BAR
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 18),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 45,
                            padding: const EdgeInsets.symmetric(horizontal: 17),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.white70),
                            ),
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              'Reply to story...',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Icon(
                          Icons.favorite_border_rounded,
                          color: Colors.white,
                          size: 28,
                        ),
                        const SizedBox(width: 12),
                        const Icon(
                          Icons.send_rounded,
                          color: Colors.white,
                          size: 25,
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

// ======================================================
// CHAT LIST TILE
// ======================================================

class _ChatListTile extends StatelessWidget {
  final _ChatData chat;
  final VoidCallback onTap;

  const _ChatListTile({required this.chat, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: SizedBox(
        height: 82,
        child: Row(
          children: [
            _buildAvatar(),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chat.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF171717),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    chat.message,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFFB9B9B9),
                      fontSize: 10.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 26,
              height: 26,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: AppColors.blue,
                shape: BoxShape.circle,
              ),
              child: Text(
                '${chat.unread}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 4),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    if (chat.group) {
      final asset = orgAssetFor(chat.name);

      return Container(
        width: 56,
        height: 56,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFEAF3FC),
        ),
        child: ClipOval(
          child: asset != null
              ? Image.asset(
                  asset,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return const Icon(
                      Icons.groups_rounded,
                      color: AppColors.navy,
                    );
                  },
                )
              : const Icon(Icons.groups_rounded, color: AppColors.navy),
        ),
      );
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        ProfilePhoto(size: 56, name: chat.name),
        if (chat.online)
          Positioned(
            right: -1,
            bottom: 0,
            child: Container(
              width: 13,
              height: 13,
              decoration: BoxDecoration(
                color: AppColors.online,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
      ],
    );
  }
}
