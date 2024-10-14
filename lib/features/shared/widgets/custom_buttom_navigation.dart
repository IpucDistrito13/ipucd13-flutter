import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../public/screen/screens.dart';

class CustomButtomNavigation extends StatelessWidget {
  final int currentIndex;

  const CustomButtomNavigation({
    super.key,
    required this.currentIndex,
  });

  void onItemTapped(BuildContext context, int index) {
    //CUANDO pulsamos ENVIVO NAVEGAR A TransmisionScreen 
    if (index == 1) {
      //TODO:: ...
      context.go('/home/1');
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => const TransmisionScreen()),
      );
    } else {
      switch (index) {
        case 0:
          context.go('/home/0');
          break;
        case 2:
          context.go('/home/2');
          break;
        case 3:
          context.go('/home/3');
          break;
        default:
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (value) => onItemTapped(context, value),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: theme.colorScheme.primary,
      unselectedItemColor: theme.colorScheme.onSurface.withOpacity(0.6),
      selectedFontSize: 12,
      unselectedFontSize: 12,
      iconSize: 24,
      items: [
        _buildAnimatedNavItem(Icons.home, 'Inicio', 0),
        _buildAnimatedNavItem(FontAwesomeIcons.broadcastTower, 'En Vivo', 1),
        _buildAnimatedNavItem(Icons.place, 'Congregaciones', 2),
        _buildAnimatedNavItem(Icons.person, 'Iniciar sesión', 3),
      ],
    );
  }

  BottomNavigationBarItem _buildAnimatedNavItem(
      IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.only(bottom: currentIndex == index ? 5 : 0),
        child: Icon(icon),
      ),
      label: label,
    );
  }
}
