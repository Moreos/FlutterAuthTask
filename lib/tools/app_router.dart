import 'package:auto_route/auto_route.dart';
import 'package:test_task_auth/tools/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => <AutoRoute>[
        AutoRoute(
          page: LoadRoute.page,
          path: '/',
        ),
        AutoRoute(
          page: MainRoute.page,
          path: '/main',
        ),
        AutoRoute(
          page: HomeRoute.page,
          path: '/home',
        ),
        AutoRoute(
          page: ProfileRoute.page,
          path: '/profile',
        ),
        AutoRoute(
          page: AuthRoute.page,
          path: '/auth',
        ),
      ];
}
