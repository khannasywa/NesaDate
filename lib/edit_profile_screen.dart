part of 'main.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _name = TextEditingController(text: AppState.nickname);
  final _age = TextEditingController(text: AppState.age);
  final _faculty = TextEditingController(text: AppState.faculty);
  final _program = TextEditingController(text: AppState.program);

  @override
  void dispose() {
    _name.dispose();
    _age.dispose();
    _faculty.dispose();
    _program.dispose();
    super.dispose();
  }

  void _save() {
    AppState.nickname =
        _name.text.trim().isEmpty ? 'Nathan' : _name.text.trim();
    AppState.age = _age.text.trim().isEmpty ? '19' : _age.text.trim();
    AppState.faculty = _faculty.text.trim();
    AppState.program = _program.text.trim();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColors.pale,
        appBar: AppBar(
          backgroundColor: AppColors.blue,
          foregroundColor: Colors.white,
          title: const Text('Edit Profile'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Center(child: ProfilePhoto(size: 120, name: AppState.nickname)),
            const SizedBox(height: 24),
            _q('Nama panggilan'),
            NDField('Nama panggilan', icon: Icons.person, controller: _name),
            const SizedBox(height: 14),
            _q('Umur'),
            NDField('Umur',
                icon: Icons.cake,
                controller: _age,
                keyboardType: TextInputType.number),
            const SizedBox(height: 14),
            _q('Fakultas'),
            NDField('Fakultas', controller: _faculty),
            const SizedBox(height: 14),
            _q('Program studi'),
            NDField('Program studi', controller: _program),
            const SizedBox(height: 28),
            NDButton('Save', onTap: _save),
          ],
        ),
      );
}
