part of 'routes_imports.dart';

class AppRoutes {
  static List<GetPage<dynamic>> routes = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: Routes.home,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
  ];
}
