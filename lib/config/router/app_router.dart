import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/admin/auth/presentation/providers/providers.dart';
import '../../features/admin/auth/presentation/screens/screens.dart';
import '../../features/admin/dashboard_screen.dart';
import '../../features/admin/descargables/carpetas/presentation/screens/carpetas_privado_screen.dart';
import '../../features/admin/descargables/descargables_screen.dart';
import '../../features/admin/ipuc_linea/ipuc_en_linea_screen.dart';
import '../../features/admin/lideres/lideres_screen.dart';
import '../../features/admin/pastores/pastor_screen.dart';
import '../../features/admin/pastores/pastores_screen.dart';
import '../../features/admin/perfil/perfil_screen.dart';
import '../../features/admin/solicitudes/solicitudes_screen.dart';
import '../../features/products/products.dart';
import '../../features/public/archivos/presentation/presentations.dart';
import '../../features/public/cronogramas/presentation/presentations.dart';
import '../../features/public/eventos/presentation/widgets/widgets.dart';
import '../../features/public/podcasts/presentation/presentations.dart';
import '../../features/public/screen/screens.dart';
import '../../features/public/series/presentation/presentations.dart';
import '../../features/public/videos/presentation/presentations.dart';
import 'app_router_notifier.dart';

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

      GoRoute(
        path: '/home/:page',
        builder: (context, state) {
          final pageIndex = state.pathParameters['page'] ?? '0';
          return PublicScreen(pageIndex: int.parse(pageIndex));
        },
      ),

      GoRoute(
        path: '/tema',
        builder: (context, state) => const TemaScreen(),
      ),

      GoRoute(
        path: '/radio',
        builder: (context, state) => const RadioScreen(),
      ),

      GoRoute(
        path: '/transmision',
        builder: (context, state) => const TransmisionScreen(),
      ),

      GoRoute(
        path: '/comite/:id',
        builder: (context, state) =>
            ComiteScreen(comiteId: state.pathParameters['id'] ?? 'no-id'),
      ),

      GoRoute(
        path: '/usuario-perfil/:id',
        builder: (context, state) =>
            PastorScreen(uuid: state.pathParameters['id'] ?? 'no-id'),
      ),

      //Carpetas publico
      GoRoute(
        path: '/descargable-publico-carpetas/:comite/:slug',
        builder: (context, state) {
          return CarpetasPublicoScreen(
            comite: state.pathParameters['comite'] ?? 'no-comite',
            slug: state.pathParameters['slug'] ?? 'no-id',
          );
        },
      ),

      //Carpetas privado
      GoRoute(
        path: '/descargable-privado-carpetas/:comite/:slug',
        builder: (context, state) {
          return CarpetasPrivadoScreen(
            comite: state.pathParameters['comite'] ?? 'no-comite',
            slug: state.pathParameters['slug'] ?? 'no-id',
          );
        },
      ),

      //Archivos publico
      GoRoute(
        path: '/descargable-publico-archivos/:carpeta/:uuid',
        builder: (context, state) {
          return ArchivosCarpetaScreen(
            carpeta: state.pathParameters['carpeta'] ?? 'no-carpeta',
            uuid: state.pathParameters['uuid'] ?? 'no-id',
          );
        },
      ),

      GoRoute(
        path: '/eventos',
        builder: (context, state) => const EventosScreen(),
      ),

      GoRoute(
        path: '/cronogramas',
        builder: (context, state) => const CronogramasScreen(),
      ),

      ///* Auth Routes
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),

      GoRoute(
        path: '/super',
        builder: (context, state) => const SuperScreen(),
      ),
      GoRoute(
        path: '/super_aux1',
        builder: (context, state) => const SuperAux1Screen(),
      ),

      GoRoute(
        path: '/admin',
        builder: (context, state) => const AdminScreen(),
      ),

      GoRoute(
        path: '/podcast/:id',
        builder: (context, state) =>
            PodcastScreen(podcastId: state.pathParameters['id'] ?? 'no-id'),
      ),

      GoRoute(
        path: '/congregaciones',
        builder: (context, state) => const CongregacionesScreen(),
      ),

      GoRoute(
        path: '/descargables',
        builder: (context, state) => const DescargablesScreen(),
      ),

      GoRoute(
        path: '/solicitudes',
        builder: (context, state) => const SolicitudesScreen(),
      ),

      GoRoute(
        path: '/ipuc-en-linea',
        builder: (context, state) => const IpucEnLineaScreen(),
      ),

      GoRoute(
        path: '/pastores',
        builder: (context, state) => const PastoresScreen(),
      ),

      GoRoute(
        path: '/lideres',
        builder: (context, state) => const LideresScreen(),
      ),

      GoRoute(
        path: '/perfil',
        builder: (context, state) =>
            PerfilScreen(uuid: state.pathParameters['uuid'] ?? 'no-uuid'),
      ),

      GoRoute(
        path: '/admin_aux1',
        builder: (context, state) => const AdminAux1Screen(),
      ),

      GoRoute(
        path: '/admin_aux2',
        builder: (context, state) => const AdminAux2Screen(),
      ),

      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),

      GoRoute(
        path: '/video/:url',
        builder: (context, state) {
          final url = state.pathParameters['url'] ?? 'no-url';
          return VideoScreen(url: url);
        },
      ),

      GoRoute(
        path: '/serie/:id',
        builder: (context, state) =>
            SerieScreen(serieId: state.pathParameters['id'] ?? 'no-id'),
      ),

      ///* Login Routes
      GoRoute(
        path: '/',
        builder: (context, state) => const ProductsScreen(),
      ),

      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),

      GoRoute(
        path: '/product/:id', // /product/new
        builder: (context, state) => ProductScreen(
          productId: state.pathParameters['id'] ?? 'no-id',
        ),
      ),
    ],
    redirect: (context, state) {
      final isGoingTo = state.matchedLocation;
      final authStatus = goRouterNotifier.authStatus;

      // Si aún está verificando la autenticación, permanece en la pantalla de splash
      if (isGoingTo == '/splash' && authStatus == AuthStatus.checking) {
        return null;
      }

      // Si no está autenticado, permite acceder a ciertas rutas públicas
      if (authStatus == AuthStatus.notAuthenticated) {
        final allowedRoutes = [
          '/comite',
          '/login',
          '/register',
          '/tema',
          '/radio',
          '/transmision',
          '/congregaciones',
          '/home/0',
          '/home/1',
          '/home/2',
          '/home/3',
          '/descargable-publico-carpetas',
          '/descargable-publico-archivos',
          '/podcast',
          '/video',
          '/serie',
          '/eventos',
          '/cronogramas',
        ];
        if (allowedRoutes.any((route) => isGoingTo.startsWith(route))) {
          return null; // Permite acceder a estas rutas
        }
        // Redirige al home público si intenta acceder a cualquier otra ruta
        return '/home/0';
      }

      // Si está autenticado
      if (authStatus == AuthStatus.authenticated) {
        final user = goRouterNotifier.user;
/*
        // Redirige al home si intenta acceder a las pantallas de login o registro estando autenticado
        if (isGoingTo == '/congregaciones' ||
            isGoingTo == '/eventos' ||
            isGoingTo == '/cronogramas' ||
            isGoingTo == '/descargables' ||
            isGoingTo == '/solicitudes' ||
            isGoingTo == '/ipuc-en-linea' ||
            isGoingTo == '/pastores' ||
            isGoingTo == '/lideres' ||
            isGoingTo == '/perfil' ||
            isGoingTo == '/tema' ||
            isGoingTo == '/splash') {
          return '/dashboard';
        }
        */

        // Verifica los roles del admin y redirige a las pantallas correspondientes
        if (user != null) {
          if (user.isAdmin) {
            // Si es admin, permite navegación para los siguientes
            final allowedRoutes = [
              '/dashboard',
              '/congregaciones',
              '/eventos',
              '/cronogramas',
              '/descargables',
              '/solicitudes',
              '/ipuc-en-linea',
              '/pastores',
              '/usuario-perfil',
              '/lideres',
              '/perfil',
              '/tema',
              '/descargables',
              '/descargable-publico-carpetas',
              '/descargable-publico-archivos',
              '/descargable-privado-carpetas',
            ];
            if (allowedRoutes.any((route) => isGoingTo.startsWith(route))) {
              return null; // Permite acceder a estas rutas
            }
            // Redirige al home público si intenta acceder a cualquier otra ruta
            return '/dashboard';
          }
        }
      }

      return null; // No redirige a ninguna otra parte
    },
  );
});
