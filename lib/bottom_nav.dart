part of 'main.dart';

/// Bottom navigation sesuai frame Figma: bar putih penuh dengan sudut atas
/// membulat dan tombol pencarian besar yang menonjol di tengah.
class NesaBottomNav extends StatelessWidget {
  final int index;
  final ValueChanged<int> onTap;
  const NesaBottomNav({super.key, required this.index, required this.onTap});

  static const double _barHeight = 72;
  static const double _barRadius = 24;
  static const double _fabSize = 70;

  /// Jarak aman agar konten tidak tertutup navigation bar.
  static const double contentBottomPadding = 124;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewPaddingOf(context).bottom;
    final totalHeight = _barHeight + bottomInset;

    return SizedBox(
      height: totalHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: totalHeight,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(_barRadius),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x1F003770),
                    blurRadius: 18,
                    offset: Offset(0, -4),
                  ),
                ],
                border: Border(
                  top: BorderSide(color: Color(0xFFEAF1FA), width: 1),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: bottomInset,
            height: _barHeight,
            child: Row(
              children: [
                Expanded(child: Center(child: _item(Icons.home_rounded, 0))),
                Expanded(
                    child: Center(child: _item(Icons.favorite_rounded, 1))),
                const Expanded(child: SizedBox()),
                Expanded(
                    child: Center(child: _item(Icons.chat_bubble_rounded, 3))),
                Expanded(child: Center(child: _item(Icons.person_rounded, 4))),
              ],
            ),
          ),
          Positioned(
            top: -16,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => onTap(2),
                child: Container(
                  width: _fabSize,
                  height: _fabSize,
                  decoration: const BoxDecoration(
                    color: AppColors.blue,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x33003770),
                        blurRadius: 14,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.search_rounded,
                    color: Colors.white,
                    size: 34,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _item(IconData icon, int i) {
    final selected = index == i;
    return IconButton(
      onPressed: () => onTap(i),
      splashRadius: 24,
      constraints: const BoxConstraints.tightFor(width: 48, height: 48),
      padding: EdgeInsets.zero,
      icon: Icon(
        icon,
        size: 29,
        color: selected ? AppColors.navy : const Color(0xFFA2A2A2),
      ),
    );
  }
}
