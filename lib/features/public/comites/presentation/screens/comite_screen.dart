import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '/features/public/podcasts/presentation/providers/podcasts_by_comite_provider.dart';
import '/features/public/series/presentation/providers/series_by_comite_provider.dart';

import '../../../lideres/domain/domains.dart';
import '../../../lideres/presentation/presentations.dart';
import '../../../podcasts/domain/domains.dart';
import '../../../podcasts/presentation/presentations.dart';
import '../../../series/domain/domains.dart';
import '../../../series/presentation/presentations.dart';
import '../../domain/domain.dart';
import '../presentations.dart';

class ComiteScreen extends ConsumerStatefulWidget {
  static const name = 'comite-screen';
  final String comiteId;
  const ComiteScreen({super.key, required this.comiteId});

  @override
  ComiteScreenState createState() => ComiteScreenState();
}

class ComiteScreenState extends ConsumerState<ComiteScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(lideresByComiteProvider(widget.comiteId).notifier)
          .loadNextPage();
      ref
          .read(podcastsByComiteProvider(widget.comiteId).notifier)
          .loadNextPage();

      ref.read(seriesByComiteProvider(widget.comiteId).notifier).loadNextPage();

      /*
      
      ref
          .read(informesByComiteProvider(widget.comiteId).notifier)
          .loadNextPage();
          */
    });
  }

  @override
  Widget build(BuildContext context) {
    final comiteState = ref.watch(comiteProvider(widget.comiteId));
    final podcastsState = ref.watch(podcastsByComiteProvider(widget.comiteId));
    final seriesState = ref.watch(seriesByComiteProvider(widget.comiteId));
    final lideresState = ref.watch(lideresByComiteProvider(widget.comiteId));

    return Scaffold(
      body: comiteState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : comiteState.comite != null
              ? CustomScrollView(
                  physics: const ClampingScrollPhysics(),
                  slivers: [
                    CustomSliverAppBar(
                      nombre: comiteState.comite!.nombre,
                      imagenportada: comiteState.comite!.imagenportada,
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => _ComiteDetails(
                          comite: comiteState.comite!,
                          podcasts: podcastsState.podcasts,
                          series: seriesState.series,
                          lideres: lideresState.lideres,
                          //informes: informesState.informes,
                        ),
                        childCount: 1,
                      ),
                    ),
                  ],
                )
              : const Center(
                  child: Text('No se encontró información del comité')),
    );
  }
}

class _ComiteDetails extends StatelessWidget {
  final Comite comite;
  final List<Podcast> podcasts;
  final List<Serie> series;
  final List<Lider> lideres;
  //final List<Informe> informes;

  const _ComiteDetails({
    required this.comite,
    required this.podcasts,
    required this.series,
    required this.lideres,
    //required this.informes,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagen

              const SizedBox(width: 10),
              // Descripción
              SizedBox(
                //width: (size.width - 40) * 0.7,
                width: (size.width - 40) * 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(comite.nombre, style: textStyles.titleLarge),
                    Text(comite.descripcion),
                  ],
                ),
              )
            ],
          ),
        ),

        //Lideres
        const SizedBox(height: 5),
        if (lideres.isNotEmpty)
          LideresInfoVerticalListview(
            lideres: lideres,
            title: 'Lideres',
            //subTitle: 'Ver más',
            loadNextPage: () {
              // Pass the appropriate function to load the next page
              // This should match the logic you use in your app
            },
          ),

        const SizedBox(height: 10),
        if (podcasts.isNotEmpty)
          PodcastInfoHorizontalListview(
            podcasts: podcasts,
            title: 'Podcasts',
            //subTitle: 'Ver más',
            loadNextPage: () {
              // Pass the appropriate function to load the next page
              // This should match the logic you use in your app
            },
          ),

        const SizedBox(height: 5),
        if (series.isNotEmpty)
          SerieInfoHorizontalListview(
            series: series,
            title: 'Series',
            //subTitle: 'Ver más',
            loadNextPage: () {
              // Pass the appropriate function to load the next page
              // This should match the logic you use in your app
            },
          ),

        //INFORMES

        //DESCARGABLES
        SizedBox(
          height: 215,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () => context.push(
                    '/descargable-publico-carpetas/${comite.nombre}/${comite.slug}',
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Descargables',
                        style: TextStyle(
                          fontFamily: 'MyriamPro',
                          fontSize: 23,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 5),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          'assets/images/descargable.webp',
                          fit: BoxFit.cover,
                          height: 170,
                          width: 130,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
