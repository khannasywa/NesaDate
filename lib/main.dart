import "dart:math" as math;

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";

part 'app_avatar.dart';
part 'app_colors.dart';
part 'app_state.dart';
part 'basic_info_screen.dart';
part 'bottom_nav.dart';
part 'campus_screen.dart';
part 'chat_content.dart';
part 'chat_room_screen.dart';
part 'discover_content.dart';
part 'edit_profile_screen.dart';
part 'home_content.dart';
part 'home_screen.dart';
part 'interests_screen.dart';
part 'likes_content.dart';
part 'login_screen.dart';
part 'main_shell.dart';
part 'matched_screen.dart';
part 'n_d_button.dart';
part 'n_d_field.dart';
part 'nesa_logo.dart';
part 'nesa_date_app.dart';
part 'notification_screen.dart';
part 'onboard_scaffold.dart';
part 'org_card.dart';
part 'page_title.dart';
part 'person_card.dart';
part 'photo_profile_screen.dart';
part 'profile_content.dart';
part 'signup_screen.dart';
part 'splash_screen.dart';
part 'white_panel.dart';

void main() => runApp(const NesaDateApp());

/// Membungkus aplikasi dengan bingkai layar HP saat dibuka di browser desktop.
/// Di perangkat mobile asli, widget ini langsung meneruskan [child] tanpa bingkai.
class AppFrame extends StatelessWidget {
  final Widget child;
  const AppFrame({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) return child;

    final width = MediaQuery.sizeOf(context).width;
    if (width <= 600) return child;

    return ColoredBox(
      color: const Color(0xFFDDE3EA),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x33000000),
                    blurRadius: 24,
                    offset: Offset(0, 12),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void go(BuildContext context, Widget page) =>
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));

Widget _q(String text, {bool small = false}) => Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Text(
        text,
        style: TextStyle(
          color: AppColors.navy,
          fontSize: small ? 14 : 18,
          height: 1.3,
          fontWeight: FontWeight.w700,
        ),
      ),
    );

Widget _step(int n) => Padding(
      padding: const EdgeInsets.only(top: 18, bottom: 2),
      child: Row(
        children: [
          const Expanded(child: Divider(color: Color(0xFFC4C4C4), height: 1)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              '$n/4',
              style: const TextStyle(color: AppColors.ink, fontSize: 15),
            ),
          ),
          const Expanded(child: Divider(color: Color(0xFFC4C4C4), height: 1)),
        ],
      ),
    );
