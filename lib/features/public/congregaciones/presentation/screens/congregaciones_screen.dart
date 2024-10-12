import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/features/public/congregaciones/presentation/delegates/search_congregacion_delegate.dart';
import '../../domain/domains.dart';
import '../presentations.dart';

class CongregacionesScreen extends ConsumerStatefulWidget {
  static const name = 'congregaciones-screen';

  const CongregacionesScreen({super.key});

  @override
  CongregacionesScreenState createState() => CongregacionesScreenState();
}

class CongregacionesScreenState extends ConsumerState<CongregacionesScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(congregacionesProvider.notifier).loadNextPage();
      _scrollController.addListener(_onScroll);
    });
  }

  void _onScroll() {
    if ((_scrollController.position.pixels + 200) >=
        _scrollController.position.maxScrollExtent) {
      ref.read(congregacionesProvider.notifier).loadNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final congregacionState = ref.watch(congregacionesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Congregaciones'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              //
              final searchedCongregaciones =
                  ref.read(searchedCongregacionesProvider);
              //searchQuery para mantener el estado
              final searchQuery = ref.read(searchQueryCongregacionProvider);
              showSearch<Congregacion?>(
                query: searchQuery,
                context: context,
                delegate: SearchCongregacionDelegate(
                  initialCongregaciones: searchedCongregaciones,
                  searchCongregaciones: (term) {
                    return ref
                        .read(searchedCongregacionesProvider.notifier)
                        .searchCongregacionesByQuery(term);
                  },
                ),
              ).then((congregacion) {});
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          CongregacionesListView(
            congregaciones: congregacionState.congregaciones,
            scrollController: _scrollController,
          ),
          if (congregacionState.isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}

class CongregacionesListView extends StatelessWidget {
  final List<Congregacion> congregaciones;
  final ScrollController scrollController;

  const CongregacionesListView({
    super.key,
    required this.congregaciones,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: congregaciones.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final congregacion = congregaciones[index];
        return Column(
          children: [
            CustomSliderCongregaciones(congregacion: congregacion),
            if (index < congregaciones.length - 1) const Divider(),
          ],
        );
      },
    );
  }
}
