import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets.dart';

class SideMenuPublic extends ConsumerStatefulWidget {
  //3. RECIBIMOS LA INFORMACION DEL scaffoldKey
  final GlobalKey<ScaffoldState> scaffoldKey;

  const SideMenuPublic({super.key, required this.scaffoldKey});

  @override
  SideMenuPublicState createState() => SideMenuPublicState();
}

Future<void> launchURL(String urlString) async {
  final Uri url = Uri.parse(urlString);
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}

class SideMenuPublicState extends ConsumerState<SideMenuPublic> {
  //CUAL DE LAS OPCIONES ES SELECCIONADA
  int navDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {
    /*
    final hasNotchAux = MediaQuery.of(context).viewPadding.top;
    if (Platform.isAndroid) {
      // Es un dispositivo Android
      print('Android $hasNotchAux');
    } else if (Platform.isIOS) {
      // Es un dispositivo iOS
      print('IOS $hasNotchAux');
    }
    */

    //hasNotch NOS INDICA LA DISTANCIA EN EL top
    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;

    return NavigationDrawer(
        elevation: 1,
        selectedIndex: navDrawerIndex,
        onDestinationSelected: (value) {
          setState(() {
            navDrawerIndex = value;
          });

          final menuItem = appMenuItemsPublic[value];
          context.push(menuItem.link);

          //4. LLAMAMOS EL scaffoldKey,
          //closeDrawer() siempre vamos a querer cerrar
          widget.scaffoldKey.currentState?.closeDrawer();
        },

        //OPCIONES DE MENU
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, hasNotch ? 0 : 20, 16, 0),
            child: const Text(
              'IPUC DISTRITO 13',
              style: TextStyle(
                  fontFamily: 'MyriamPro',
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),

          //MOSTRAMOS MENUS ITEMS PUBLICOS
          ...appMenuItemsPublic.map(
            (item) => NavigationDrawerDestination(
              icon: Icon(item.icon),
              label: Text(item.title),
            ),
          ),

          const Padding(
            padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
            child: Divider(),
          ),

          const Padding(
            padding: EdgeInsets.fromLTRB(28, 10, 16, 10),
            child: Text('Siguenos en: '),
          ),

          //ABRRIR ENLACES O APLICACIONES MEDIANTE URL
          ListTile(
            leading: const Icon(
              Icons.facebook,
              color: Colors.indigo,
            ),
            title: const Text('Facebook'),
            onTap: () => launchURL(
                'https://www.facebook.com/IPUCDistrito13Oficial?locale=es_LA'),
          ),

          ListTile(
            leading: const FaIcon(
              FontAwesomeIcons.instagram,
              size: 24,
              color: Colors.purple,
            ),
            title: const Text('Instagram'),
            onTap: () => launchURL(
                'https://www.instagram.com/ipucdistrito13oficial?igsh=MTV1aWNuMXF0dDltMw=='),
          ),

          ListTile(
            leading: const FaIcon(
              FontAwesomeIcons.youtube,
              size: 24,
              color: Colors.red,
            ),
            title: const Text('Youtube'),
            onTap: () =>
                launchURL('https://www.youtube.com/@IPUCDistrito13Oficial'),
          ),

          ListTile(
            leading: const Icon(Icons.public),
            title: const Text('Página web'),
            onTap: () => launchURL('https://ipucdistrito13.org/'),
          ),
        ]);
  }

  Future<void> launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
