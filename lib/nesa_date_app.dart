part of 'main.dart';

class NesaDateApp extends StatelessWidget {
  const NesaDateApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'NesaDate',
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: AppColors.pale,
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.blue,
            primary: AppColors.blue,
            secondary: AppColors.navy,
          ),
          fontFamily: 'PlusJakartaSans',
          splashFactory: InkSparkle.splashFactory,
          textTheme: const TextTheme(
            bodyMedium: TextStyle(color: AppColors.ink),
          ),
        ),
        builder: (context, child) =>
            AppFrame(child: child ?? const SizedBox.shrink()),
        home: const SplashScreen(),
      );
}
