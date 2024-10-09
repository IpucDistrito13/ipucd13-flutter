import 'package:flutter/material.dart';
import '/features/public/screen/back_transmision_screen.dart';

import '../../admin/auth/presentation/screens/login_screen.dart';
import '../../shared/widgets/widgets.dart';
import 'screens.dart';

class PublicScreen extends StatelessWidget {
  final int pageIndex;

  const PublicScreen({super.key, required this.pageIndex});

  final List<Widget> viewRoutes = const [
    Public2Screen(),
    BackTransmisionScreen(),
    CongregacionesScreen(),
    LoginScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: pageIndex,
        children: viewRoutes,
      ),
      bottomNavigationBar: CustomButtomNavigation(
        currentIndex: pageIndex,
      ),
    );
  }
}
