import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../comites/presentation/presentations.dart';
import '../../../videos/domain/domains.dart';
import '../../../videos/presentation/presentations.dart';
import '../../domain/domains.dart';
import '../presentations.dart';

class SerieScreen extends ConsumerStatefulWidget {
  static const name = 'serie-screen';
  final String serieId;
  const SerieScreen({super.key, required this.serieId});

  @override
  SerieScreenState createState() => SerieScreenState();
}

class SerieScreenState extends ConsumerState<SerieScreen> {
  @override
  void initState() {
    super.initState();
    //Aqui inicializar otras cosas si es necesario
    //Por ejemplo, cargar los siguientes videos
    //podcastProvider.loadNextEpisodes(widget.podcastId);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(videosByComiteProvider(widget.serieId).notifier).loadNextPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    final serieState = ref.watch(serieProvider(widget.serieId));
    final videosState = ref.watch(videosByComiteProvider(widget.serieId));

    return Scaffold(
      body: serieState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : serieState.serie != null
              ? CustomScrollView(
                  physics: const ClampingScrollPhysics(),
                  slivers: [
                    CustomSliverAppBar(
                      nombre: serieState.serie!.nombre,
                      imagenportada: serieState.serie!.imagenportada,
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => _SerieDetails(
                          serie: serieState.serie!,
                          videos: videosState.videos,
                        ),
                        childCount: 1,
                      ),
                    ),
                  ],
                )
              : const Center(
                  child: Text(
                    'No se encontró información del comité',
                  ),
                ),
    );
  }
}

class _SerieDetails extends StatelessWidget {
  final Serie serie;
  final List<Video> videos;

  const _SerieDetails({required this.serie, required this.videos});

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
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  serie.imagenportada,
                  width: size.width * 0.3,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              // Descripción
              SizedBox(
                width: (size.width - 40) * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(serie.nombre, style: textStyles.titleLarge),
                    Text(serie.contenido),
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Videos
        if (videos.isNotEmpty)
          VideoInfoHorizontalListviewWidget(
            videos: videos,
            title: 'Videos',
            //subTitle: 'Ver más',
            loadNextPage: () {},
          ),

        const SizedBox(height: 10),
        //
      ],
    );
  }
}
