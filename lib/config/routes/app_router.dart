import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:music_player/config/routes/app_routes.dart';
import 'package:music_player/presentation/home/home_screen.dart';

class AppRouter {
  late final GoRouter _router;
  GoRouter get router => _router;

  AppRouter() {
    _router = GoRouter(routes: _routes);
  }

  List<RouteBase> get _routes {
    return [
      GoRoute(
        name: AppRoutes.home.name,
        path: AppRoutes.home.path,
        pageBuilder: (context, state) {
          return _buildFadeTransitionPage(
            context: context,
            child: HomeScreen(),
          );
        },
      ),
    ];
  }

  Page<void> _buildFadeTransitionPage({
    required BuildContext context,
    required Widget child,
  }) {
    return CustomTransitionPage(
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}
