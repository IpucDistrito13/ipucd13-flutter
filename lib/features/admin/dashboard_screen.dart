import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../shared/shared.dart';
import '../shared/widgets/widgets.dart';

class DashboardScreen extends StatefulWidget {
  static const String name = 'home-screen';
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'IPUC DISTRITO 13',
          style: TextStyle(
              fontFamily: 'MyriamPro',
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: const _HomeView(),
      drawer: SideMenuAdmin(scaffoldKey: scaffoldKey),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return _ResponsiveGridView(maxWidth: constraints.maxWidth);
        },
      ),
    );
  }
}

class _ResponsiveGridView extends StatelessWidget {
  final double maxWidth;

  const _ResponsiveGridView({required this.maxWidth});

  @override
  Widget build(BuildContext context) {
    int crossAxisCount;
    double childAspectRatio;

    print('maxWidth: ${maxWidth}'); //376.7 cell grande - 304

    //600
    if (maxWidth < 376) {
      crossAxisCount = 2;
      childAspectRatio = 0.8;
    } else if (maxWidth < 900) {
      crossAxisCount = 3;
      childAspectRatio = 0.7;
    } else {
      crossAxisCount = 4;
      childAspectRatio = 0.8;
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: appMenuItemsAdmin.length,
      itemBuilder: (context, index) {
        final menuItem = appMenuItemsAdmin[index];
        return _CustomGridCard(menuItem: menuItem);
      },
    );
  }
}

class _CustomGridCard extends StatelessWidget {
  const _CustomGridCard({required this.menuItem});
  final AppMenuAdminItems menuItem;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () {
        context.push(menuItem.link);
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(menuItem.icon, size: 40, color: colors.primary),
              const SizedBox(height: 5),
              Text(
                menuItem.title,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10),
              // Uncomment if you want to add subtitle
              Text(
                menuItem.subTitle,
                textAlign: TextAlign.center,
                style: TextStyle(color: colors.onSurface.withOpacity(0.6)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
