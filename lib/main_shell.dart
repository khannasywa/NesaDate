part of 'main.dart';

class MainShell extends StatefulWidget {
  final int initial;
  const MainShell({super.key, this.initial = 0});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  late int index;
  final pages = const [
    HomeContent(),
    LikesContent(),
    DiscoverContent(),
    ChatContent(),
    ProfileContent(),
  ];

  @override
  void initState() {
    super.initState();
    index = widget.initial;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        extendBody: true,
        body: IndexedStack(index: index, children: pages),
        bottomNavigationBar: NesaBottomNav(
          index: index,
          onTap: (i) => setState(() => index = i),
        ),
      );
}
