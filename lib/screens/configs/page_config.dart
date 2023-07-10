import 'package:authentications/middlewares/middleware.dart';
import 'package:authentications/screens/auth/login_screen.dart';
import 'package:authentications/screens/home/user_screen.dart';
import 'package:authentications/services/home/home_service.dart';
import 'package:authentications/services/login/login_service.dart';
import 'package:authentications/screens/home/admin_screen.dart';
import 'package:get/get.dart';

class PageConfig {
  static final List<GetPage> pages = [
    GetPage(
      name: '/home',
      page: () => UserScreen(),
      binding: BindingsBuilder(() {
        Get.put(HomeService());
      }),
      middlewares: [GlobalMiddleware()],
    ),
    GetPage(
      name: '/adminHome',
      page: () => AdminScreen(),
      binding: BindingsBuilder(() {
        Get.put(HomeService());
      }),
      middlewares: [GlobalMiddleware()],
    ),
    GetPage(
      name: '/login',
      page: () => LoginScreen(),
      binding: BindingsBuilder(() {
        Get.put(LoginService());
      }),
      middlewares: [GlobalMiddleware()],
    ),
  ];
}
