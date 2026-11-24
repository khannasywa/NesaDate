part of 'main.dart';

/// Foto profil bulat dengan fallback gradasi + inisial.
class ProfilePhoto extends StatelessWidget {
  final double size;
  final String name;
  final String? asset;
  final Color? borderColor;
  final double borderWidth;
  const ProfilePhoto({
    super.key,
    required this.size,
    this.name = '',
    this.asset,
    this.borderColor,
    this.borderWidth = 0,
  });

  @override
  Widget build(BuildContext context) {
    final palette =
        _avatarPalettes[name.hashCode.abs() % _avatarPalettes.length];
    final source =
        (asset == null || asset!.isEmpty) ? assetForName(name) : asset;
    final content = source == null || source.isEmpty
        ? Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: palette,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              name.isEmpty ? '?' : name.substring(0, 1).toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontSize: size * .38,
                fontWeight: FontWeight.w800,
              ),
            ),
          )
        : Image.asset(source, fit: BoxFit.cover);

    return Container(
      width: size,
      height: size,
      padding: borderWidth > 0 ? EdgeInsets.all(borderWidth) : EdgeInsets.zero,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: borderColor == null
            ? null
            : Border.all(color: borderColor!, width: borderWidth),
      ),
      child: ClipOval(child: content),
    );
  }
}

const _avatarPalettes = <List<Color>>[
  [Color(0xFF6EB2FD), Color(0xFFAED8FF)],
  [Color(0xFFF7C9DC), Color(0xFFE9A7C6)],
  [Color(0xFFBCEBDD), Color(0xFF6FD3B6)],
  [Color(0xFFDCD6FF), Color(0xFFA99CFF)],
  [Color(0xFFFFE8A3), Color(0xFFF4C86A)],
  [Color(0xFF9ED6FF), Color(0xFF5AA7F5)],
];

/// Foto persegi dengan sudut membulat untuk kartu Discover / Home.
class PhotoCover extends StatelessWidget {
  final String name;
  final String? asset;
  final BorderRadius radius;
  const PhotoCover({
    super.key,
    required this.name,
    this.asset,
    this.radius = const BorderRadius.all(Radius.circular(26)),
  });

  @override
  Widget build(BuildContext context) {
    final palette =
        _avatarPalettes[name.hashCode.abs() % _avatarPalettes.length];
    final source =
        (asset == null || asset!.isEmpty) ? assetForName(name) : asset;
    return ClipRRect(
      borderRadius: radius,
      child: source == null || source.isEmpty
          ? Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: palette,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.person,
                  color: Colors.white.withValues(alpha: .55),
                  size: 96,
                ),
              ),
            )
          : Image.asset(source, fit: BoxFit.cover),
    );
  }
}

/// Foto asli yang diekstrak dari referensi desain.
const _peopleAssets = <String, String>{
  'nathan': 'assets/images/people/nathan.png',
  'nabila': 'assets/images/people/nabila.png',
  'juliana': 'assets/images/people/juliana.png',
  'hanni': 'assets/images/people/hanni.png',
  'bunga': 'assets/images/people/bunga.png',
  'anna': 'assets/images/people/anna.png',
  'naila': 'assets/images/people/naila.png',
  'raisha': 'assets/images/people/raisha.png',
  'azka': 'assets/images/people/azka.png',
  'aurel': 'assets/images/people/aurel.png',
  'naura': 'assets/images/people/naura.png',
  'diva': 'assets/images/people/diva.png',
  'nala': 'assets/images/people/nala.png',
  'nela': 'assets/images/people/nela.png',
  'mila': 'assets/images/people/mila.png',
  'laura': 'assets/images/people/laura.png',
  'rey': 'assets/images/people/rey.png',
  'cika': 'assets/images/people/cika.png',
  'lisa': 'assets/images/people/lisa.png',
  'intan': 'assets/images/people/intan.png',
  'putri': 'assets/images/people/putri.png',
  'yuna': 'assets/images/people/yuna.png',
  'zahra': 'assets/images/people/zahra.png',
  'naomi': 'assets/images/people/naomi.png',
  'luna': 'assets/images/people/luna.png',
  'reva': 'assets/images/people/reva.png',
  'yukii': 'assets/images/people/yukii.png',
  'vanessha': 'assets/images/people/vanessha.png',
};

const _orgAssets = <String, String>{
  'sre unesa': 'assets/images/orgs/sre.png',
  'stopia': 'assets/images/orgs/stopia.png',
  'bem unesa': 'assets/images/orgs/bem.png',
  'imami unesa': 'assets/images/orgs/imami.png',
  'narasa': 'assets/images/orgs/narasa.png',
  'girl up': 'assets/images/orgs/girlup.png',
};

String? assetForName(String name) =>
    _peopleAssets[name.split(',').first.trim().toLowerCase()];

String? orgAssetFor(String name) => _orgAssets[name.trim().toLowerCase()];

/// Foto kedua untuk kartu bertumpuk di halaman Likes.
String? secondPhotoForName(String name) {
  switch (name.split(',').first.trim().toLowerCase()) {
    case 'rey':
      return 'assets/images/people/rey2.png';
    case 'lisa':
      return 'assets/images/people/lisa2.png';
    case 'yuna':
      return 'assets/images/people/yuna2.png';
    case 'zahra':
      return 'assets/images/people/zahra2.png';
    case 'luna':
      return 'assets/images/people/luna2.png';
    default:
      return null;
  }
}
