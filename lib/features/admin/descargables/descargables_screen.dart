import '../../public/comites/domain/domain.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DescargablesScreen extends ConsumerStatefulWidget {
  static const name = 'descargable-screen';
  const DescargablesScreen({super.key});

  @override
  DescargablesScreenState createState() => DescargablesScreenState();
}

class DescargablesScreenState extends ConsumerState<DescargablesScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController scrollController = ScrollController();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(comitesProvider.notifier).loadNextPage();
      //AQUI SE PUEDE CARGAR DESCARGABLES PRIVADOS
    });
    scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      ref.read(comitesProvider.notifier).loadNextPage();
      //AQUI CARGAR LOS DESCARGABLES PRIVADOS
    }
  }

  @override
  Widget build(BuildContext context) {
    final comitesState = ref.watch(comitesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Descargables',
          style: TextStyle(
            fontFamily: 'MyriamPro',
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Públicos'),
            Tab(text: 'Privados'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ComitePublicoGridView(
            comites: comitesState.comites,
            scrollController: scrollController,
          ),
          ComitePrivadoGridView(
            comites: comitesState.comites,
            scrollController: scrollController,
          ),
        ],
      ),
    );
  }
}

class ComitePublicoGridView extends StatelessWidget {
  final List<Comite> comites;
  final ScrollController scrollController;

  const ComitePublicoGridView({
    super.key,
    required this.comites,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: scrollController,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.7,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      padding: const EdgeInsets.all(10),
      itemCount: comites.length,
      itemBuilder: (context, index) {
        return FadeInUp(
          child: _ComiteGridItem(comite: comites[index]),
        );
      },
    );
  }
}

class ComitePrivadoGridView extends StatelessWidget {
  final List<Comite> comites;
  final ScrollController scrollController;

  const ComitePrivadoGridView({
    super.key,
    required this.comites,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: scrollController,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.7,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      padding: const EdgeInsets.all(10),
      itemCount: comites.length,
      itemBuilder: (context, index) {
        return FadeInUp(
          child: _ComitePrivadoGridItem(comite: comites[index]),
        );
      },
    );
  }
}

class _ComiteGridItem extends StatelessWidget {
  final Comite comite;
  const _ComiteGridItem({required this.comite});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(
        '/descargable-publico-carpetas/${comite.nombre}/${comite.slug}',
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                comite.imagenportada,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            comite.nombre,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _ComitePrivadoGridItem extends StatelessWidget {
  final Comite comite;
  const _ComitePrivadoGridItem({required this.comite});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(
          '/descargable-privado-carpetas/${comite.nombre}/${comite.slug}'),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                comite.imagenportada,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            comite.nombre,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
