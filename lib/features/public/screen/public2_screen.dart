import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/features/public/comites/domain/domain.dart';
import '/features/public/cronogramas/presentation/widgets/cronograma_horizontal_listview.dart';
import '/features/shared/widgets/custom_radio_transmision.dart';

import '../../shared/shared.dart';
import '../comites/presentation/presentations.dart';
import '../podcasts/presentation/presentations.dart';
import '../series/presentation/presentations.dart';
import '../sliders/presentation/providers/providers.dart';

class Public2Screen extends StatelessWidget {
  const Public2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      drawer: SideMenuPublic(scaffoldKey: scaffoldKey),
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
      body: const _ComitesView(),
    );
  }
}

class _ComitesView extends ConsumerStatefulWidget {
  const _ComitesView();

  @override
  _ComitesViewState createState() => _ComitesViewState();
}

class _ComitesViewState extends ConsumerState {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final sliderState = ref.watch(slidersProvider);
    final comitesState = ref.watch(comitesProvider);
    final podcastsState = ref.watch(podcastsProvider);
    final seriesState = ref.watch(seriesProvider);
    final eventosState = ref.watch(eventosProvider);
    final cronogramasState = ref.watch(cronogramasProvider);

    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: [
          //MENSAJE CARGANDO
          if (comitesState.comites.isEmpty)
            const Center(
              child: Text('Cargando...'),
            ),
          const SizedBox(height: 10),

          //SLIDER PRINCIPAL
          CustomSliderPrincipal(sliders: sliderState.sliders),

          //RADIO-TRANSMISION
          const SizedBox(height: 15),

          const CustomRadioTransmision(),

          //COMITES

          if (comitesState.comites.isNotEmpty)
            ComiteHorizontalListview(
              title: 'Comités',
              comites: comitesState.comites,
              loadNextPage: () {
                ref.read(comitesProvider.notifier).loadNextPage();
              },
            ),
          //
          if (podcastsState.podcasts.isNotEmpty)
            PodcastHorizontalListview(
              title: 'Podcats',
              podcasts: podcastsState.podcasts,
              loadNextPage: () {
                ref.read(podcastsProvider.notifier).loadNextPage();
              },
            ),

          if (seriesState.series.isNotEmpty)
            SerieHorizontalListview(
              title: 'Series',
              series: seriesState.series,
              loadNextPage: () {
                ref.read(seriesProvider.notifier).loadNextPage();
              },
            ),

          if (eventosState.eventos.isNotEmpty)
            EventoHorizontalListView(
              eventos: eventosState.eventos,
              title: 'Eventos',
              loadNextPage: () {
                ref.read(eventosProvider.notifier).loadNextPage();
              },
            ),

          if (cronogramasState.cronogramas.isNotEmpty)
            CronogramaHorizontalListView(
              cronogramas: cronogramasState.cronogramas,
              title: 'Cronogramas',
              loadNextPage: () {
                ref.read(cronogramasProvider.notifier).loadNextPage();
              },
            ),
        ],
      ),
    );
  }
}
