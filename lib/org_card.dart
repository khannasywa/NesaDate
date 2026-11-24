part of 'main.dart';

class OrgCard extends StatelessWidget {
  final String name, desc, username;
  final List<Color> colors;

  const OrgCard(
    this.name,
    this.desc, {
    super.key,
    this.username = '@unesa_community',
    this.colors = const [
      Color(0xFF365D7A),
      Color(0xFF789DB8),
    ],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 288,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(19),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: const Color(0xFFE8EDF2),
          width: 1,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x100F2438),
            blurRadius: 14,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ORGANIZATION INFORMATION
          Expanded(
            child: Row(
              children: [
                OrgLogo(
                  name: name,
                  colors: colors,
                  size: 61,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xFF203A56),
                          fontSize: 19,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.4,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        desc,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xFF65778A),
                          fontSize: 11,
                          height: 1.4,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        username,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xFF98A5B3),
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // JOIN BUTTON
          SizedBox(
            height: 37,
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Bergabung dengan $name'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF365D7A),
                foregroundColor: Colors.white,
                elevation: 0,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
              child: const Text(
                'Join Community',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ======================================================
// ORGANIZATION LOGO
// ======================================================

class OrgLogo extends StatelessWidget {
  final String name;
  final List<Color> colors;
  final double size;
  final String? asset;

  const OrgLogo({
    super.key,
    required this.name,
    this.colors = const [
      Color(0xFF365D7A),
      Color(0xFF789DB8),
    ],
    this.size = 64,
    this.asset,
  });

  @override
  Widget build(BuildContext context) {
    final source =
        (asset == null || asset!.isEmpty) ? orgAssetFor(name) : asset;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: const Color(0xFFE8EDF2),
          width: 1,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x120F2438),
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: source == null
          ? Text(
              name.length > 4
                  ? name.substring(0, 3).toUpperCase()
                  : name.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: size * 0.24,
                fontWeight: FontWeight.w900,
              ),
            )
          : ClipOval(
              child: Image.asset(
                source,
                width: size,
                height: size,
                fit: BoxFit.cover,
              ),
            ),
    );
  }
}
