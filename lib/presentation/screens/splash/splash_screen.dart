part of 'splash_imports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    goToHome();
  }

  goToHome() async {
    await Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed(Routes.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.secondary,
      body: Center(
        child: Text(
          "Expense Tracker",
          style: TextStyle(
            color: AppColors.textLight,
          ),
        ),
      ),
    );
  }
}
