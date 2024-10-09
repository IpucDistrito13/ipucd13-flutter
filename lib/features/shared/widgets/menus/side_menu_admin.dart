import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/config/router/app_router_notifier.dart';
import '../../../admin/auth/presentation/providers/providers.dart';
import '../../shared.dart';

class SideMenuAdmin extends ConsumerStatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const SideMenuAdmin({super.key, required this.scaffoldKey});

  @override
  SideMenuState createState() => SideMenuState();
}

class SideMenuState extends ConsumerState<SideMenuAdmin> {
  int navDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {
    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;
    final textStyles = Theme.of(context).textTheme;
    final goRouterNotifier = ref.read(goRouterNotifierProvider);
    final user = goRouterNotifier.user;

    return NavigationDrawer(
        elevation: 1,
        selectedIndex: navDrawerIndex,
        onDestinationSelected: (value) {
          setState(() {
            navDrawerIndex = value;
          });

          // final menuItem = appMenuItems[value];
          // context.push( menuItem.link );
          widget.scaffoldKey.currentState?.closeDrawer();
        },
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, hasNotch ? 0 : 20, 16, 0),
            child: const Center(
              child: Text(
                'IPUC DISTRITO 13',
                style: TextStyle(
                    fontFamily: 'MyriamPro',
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(20, hasNotch ? 0 : 20, 16, 0),
            child: Center(
              child: Text(
                '${user!.nombre} ${user.apellidos}',
                style: const TextStyle(
                  fontFamily: 'MyriamPro',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 16, 10),
            child: Text(
              user.roles.join(
                ', ',
              ), // Combina los roles en una sola cadena separados por comas
              style: textStyles.titleSmall,
            ),
          ),
          /*
          const NavigationDrawerDestination(
            icon: Icon(Icons.home_outlined),
            label: Text('Productos'),
          ),
          */

          //Mostrados menus items publicos
          ...appMenuItemsAdmin.map(
            (item) => NavigationDrawerDestination(
              icon: Icon(item.icon),
              label: Text(item.title),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
            child: Divider(),
          ),
          /*
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 10, 16, 10),
            child: Text('Otras opciones'),
          ),
          */
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomFilledButton(
                onPressed: () {
                  ref.read(authProvider.notifier).logout();
                },
                text: 'Cerrar sesión'),
          ),
        ]);
  }
}
