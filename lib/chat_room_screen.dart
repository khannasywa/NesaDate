part of 'main.dart';

class ChatRoomScreen extends StatefulWidget {
  final String name;
  const ChatRoomScreen({super.key, this.name = 'Naila'});
  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final controller = TextEditingController();
  final scroll = ScrollController();
  bool _isReplying = false;
  final List<_Msg> messages = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToEnd());
  }

  @override
  void dispose() {
    controller.dispose();
    scroll.dispose();
    super.dispose();
  }

  void _scrollToEnd() {
    if (!scroll.hasClients) return;
    scroll.animateTo(
      scroll.position.maxScrollExtent,
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOut,
    );
  }

  void _send() {
    final text = controller.text.trim();

    if (text.isEmpty || _isReplying) return;

    setState(() {
      messages.add(_Msg(text, true));
      controller.clear();
      _isReplying = true;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToEnd();
    });

    _automaticReply(text);
  }

  Future<void> _automaticReply(String userMessage) async {
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    final text = userMessage.toLowerCase();

    String reply;

    if (text.contains('halo') || text.contains('hai')) {
      reply = 'Halooo juga! Apa kabar kamuu?';
    } else if (text.contains('nama')) {
      reply = 'Namaku ${widget.name}, kalau kamu siapa?';
    } else if (text.contains('kabar')) {
      reply = 'Aku baik-baik aja nihh, kamu gimana?';
    } else if (text.contains('jurusan')) {
      reply = 'Aku dari jurusan yang seru nihh! Kamu sendiri?';
    } else if (text.contains('makasih')) {
      reply = 'Sama-sama yaaa! 🥰';
    } else if (text.contains('main')) {
      reply = 'Ayooo! Kapan kita main bareng?';
    } else {
      const replies = [
        'Ohh gituu, ceritain lagi dongg!',
        'Wahh menarik banget!',
        'Hehehe iyaaa!',
        'Seriusss? Aku baru tahu!',
        'Btw kamu lagi ngapain?',
        'Hahaha bisa aja kamuu!',
        'Asikk, terus gimana ceritanya?',
      ];

      reply = replies[DateTime.now().millisecondsSinceEpoch % replies.length];
    }

    if (!mounted) return;

    setState(() {
      messages.add(_Msg(reply, false));
      _isReplying = false;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToEnd();
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(6, 6, 10, 10),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.maybePop(context),
                      icon: const Icon(Icons.arrow_back_ios_new_rounded,
                          color: AppColors.navy),
                    ),
                    Stack(
                      children: [
                        ProfilePhoto(size: 48, name: widget.name),
                        Positioned(
                          right: 0,
                          bottom: 2,
                          child: Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              color: AppColors.online,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF111111),
                            ),
                          ),
                          const Text(
                            'Online',
                            style:
                                TextStyle(fontSize: 12, color: AppColors.grey),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () =>
                          ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Panggilan suara segera hadir')),
                      ),
                      icon:
                          const Icon(Icons.call_rounded, color: AppColors.grey),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.more_vert_rounded,
                          color: AppColors.grey),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: CustomPaint(painter: _DoodlePainter()),
                    ),
                    ListView(
                      controller: scroll,
                      padding: const EdgeInsets.fromLTRB(18, 18, 18, 12),
                      children: [
                        const Center(child: _TodayChip()),
                        const SizedBox(height: 14),
                        for (final m in messages) _Bubble(message: m),
                        if (_isReplying)
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                'Sedang mengetik...',
                                style: TextStyle(
                                  color: AppColors.grey,
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
                decoration: const BoxDecoration(color: Color(0xFFF5F5F5)),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add_rounded,
                          color: AppColors.grey, size: 30),
                    ),
                    Expanded(
                      child: Container(
                        height: 44,
                        padding: const EdgeInsets.only(left: 18, right: 2),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: controller,
                                textInputAction: TextInputAction.send,
                                onSubmitted: (_) => _send(),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '',
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.mic_none_rounded,
                                  color: AppColors.grey, size: 26),
                            ),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: _send,
                      icon: const Icon(Icons.send_rounded,
                          color: AppColors.blue, size: 26),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}

class _Msg {
  final String text;
  final bool mine;
  const _Msg(this.text, this.mine);
}

class _TodayChip extends StatelessWidget {
  const _TodayChip();
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFE8E8E8),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Text('Today', style: TextStyle(fontSize: 12)),
      );
}

class _Bubble extends StatelessWidget {
  final _Msg message;
  const _Bubble({required this.message});

  @override
  Widget build(BuildContext context) => Align(
        alignment: message.mine ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 270),
          margin: const EdgeInsets.symmetric(vertical: 7),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: message.mine ? AppColors.bubble : const Color(0xFFE4E4E4),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            message.text,
            style: const TextStyle(
              color: Color(0xFF293A40),
              fontSize: 15,
              height: 1.3,
            ),
          ),
        ),
      );
}

class _DoodlePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.lightBlue.withValues(alpha: .22)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    const step = 74.0;
    final cols = (size.width / step).ceil() + 1;
    final rows = (size.height / step).ceil() + 1;
    for (var r = 0; r < rows; r++) {
      for (var c = 0; c < cols; c++) {
        final motif = (r * 5 + c * 3) % 7;
        final jitterX = ((r * 17 + c * 29) % 21) - 10;
        final jitterY = ((r * 13 + c * 19) % 19) - 9;
        final center = Offset(
          c * step + step / 2 + jitterX,
          r * step + step / 2 + jitterY,
        );
        canvas.save();
        canvas.translate(center.dx, center.dy);
        canvas.rotate((((r + c) % 5) - 2) * .09);
        switch (motif) {
          case 0:
            _heart(canvas, paint, 12);
          case 1:
            _star(canvas, paint, 11);
          case 2:
            _bubble(canvas, paint);
          case 3:
            canvas.drawCircle(Offset.zero, 10, paint);
            canvas.drawCircle(const Offset(7, 7), 2.5, paint);
          case 4:
            canvas.drawRRect(
              RRect.fromRectAndRadius(
                Rect.fromCenter(center: Offset.zero, width: 24, height: 20),
                const Radius.circular(5),
              ),
              paint,
            );
            canvas.drawLine(const Offset(-7, 6), const Offset(7, -6), paint);
          case 5:
            _camera(canvas, paint);
          default:
            canvas.drawCircle(const Offset(-7, 0), 3, paint);
            canvas.drawLine(const Offset(-7, 0), const Offset(4, 0), paint);
            canvas.drawLine(const Offset(4, 0), const Offset(1, -5), paint);
        }
        canvas.restore();
      }
    }
  }

  void _heart(Canvas canvas, Paint paint, double s) {
    final path = Path()
      ..moveTo(0, s * .55)
      ..cubicTo(-s * 1.3, -s * .25, -s * .42, -s * .95, 0, -s * .38)
      ..cubicTo(s * .42, -s * .95, s * 1.3, -s * .25, 0, s * .55);
    canvas.drawPath(path, paint);
  }

  void _star(Canvas canvas, Paint paint, double s) {
    final path = Path();
    for (var i = 0; i < 8; i++) {
      final radius = i.isEven ? s : s * .42;
      final angle = -1.5708 + i * .7854;
      final point = Offset(
        radius * 0.86 * math.cos(angle),
        radius * 0.86 * math.sin(angle),
      );
      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  void _bubble(Canvas canvas, Paint paint) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset.zero, width: 26, height: 18),
        const Radius.circular(7),
      ),
      paint,
    );
    final tail = Path()
      ..moveTo(-5, 8)
      ..lineTo(-9, 13)
      ..lineTo(2, 8);
    canvas.drawPath(tail, paint);
    canvas.drawCircle(const Offset(-6, 0), 1.1, paint);
    canvas.drawCircle(const Offset(0, 0), 1.1, paint);
    canvas.drawCircle(const Offset(6, 0), 1.1, paint);
  }

  void _camera(Canvas canvas, Paint paint) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset.zero, width: 26, height: 17),
        const Radius.circular(4),
      ),
      paint,
    );
    canvas.drawCircle(Offset.zero, 5, paint);
    canvas.drawLine(const Offset(-7, -8), const Offset(-3, -8), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
