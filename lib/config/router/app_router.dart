import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:teslo_shop/features/auth/auth.dart';
import 'package:teslo_shop/features/auth/presentation/providers/auth_provider.dart';
import 'package:teslo_shop/features/products/products.dart';
import 'package:teslo_shop/features/products/presentation/screens/orders_screen.dart';
import 'package:teslo_shop/features/shared/screens/main_layout.dart';
import 'app_router_notifier.dart';
import 'package:teslo_shop/features/shared/shared.dart';

final goRouterProvider = Provider((ref) {
  final goRouterNotifier = ref.read(goRouterNotifierProvider);

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: goRouterNotifier,
    routes: [
      ///* Primera pantalla
      GoRoute(
        path: '/splash',
        builder: (context, state) => const CheckAuthStatusScreen(),
      ),

      ///* Auth Routes
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),

      ///* Main Routes with Layout
      GoRoute(
        path: '/',
        builder: (context, state) =>
            MainLayout(child: const ProductsScreen(), selectedIndex: 0),
      ),
      GoRoute(
        path: '/orders',
        builder: (context, state) =>
            MainLayout(child: const OrdersScreen(), selectedIndex: 1),
      ),
      GoRoute(
        path: '/product/:id', // /product/new
        builder: (context, state) => MainLayout(
          child: ProductScreen(
            productId: state.params['id'] ?? 'no-id',
          ),
          selectedIndex: 0, // Asumiendo que "Productos" es la sección principal
        ),
      ),
    ],
    redirect: (context, state) {
      final isGoingTo = state.subloc;
      final authStatus = goRouterNotifier.authStatus;

      if (isGoingTo == '/splash' && authStatus == AuthStatus.checking) {
        return null;
      }

      if (authStatus == AuthStatus.notAuthenticated) {
        if (isGoingTo == '/login' || isGoingTo == '/register') return null;

        return '/login';
      }

      if (authStatus == AuthStatus.authenticated) {
        if (isGoingTo == '/login' ||
            isGoingTo == '/register' ||
            isGoingTo == '/splash') {
          return '/';
        }
      }

      return null;
    },
  );
});
