import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:audioplayers/audioplayers.dart';
import '/features/public/podcasts/presentation/providers/podcast_provider.dart';

import '../../../episodios/presentation/presentations.dart';
import '../../domain/domains.dart';

/**
 _playOrPause():

Ahora verifica si el audio está reproduciéndose o pausado.
Si está reproduciéndose, lo pausa.
Si está pausado, lo reanuda desde la posición actual.
Si no hay un episodio reproduciéndose, inicia la reproducción del primer episodio.


_buildAudioControls():

Agregué un nuevo IconButton entre los botones de anterior y siguiente.
Este nuevo botón alterna entre los iconos de reproducción y pausa según el estado del reproductor.
El botón llama a _playOrPause() cuando se presiona.

Pausar y reanudar la reproducción desde la posición actual.
Mantener el estado de reproducción actual al pausar, sin reiniciar al primer episodio.
Proporcionar una interfaz de usuario más intuitiva con los tres controles principales (anterior, reproducir/pausar, siguiente) en una sola fila.

 */

class PodcastScreen extends ConsumerStatefulWidget {
  static const name = 'podcast-screen';
  final String podcastId;

  const PodcastScreen({Key? key, required this.podcastId}) : super(key: key);

  @override
  PodcastScreenState createState() => PodcastScreenState();
}

class PodcastScreenState extends ConsumerState<PodcastScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final AudioPlayer _audioPlayer = AudioPlayer();
  int? _currentlyPlayingIndex;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  bool _isAudioControlVisible = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(episodiosByComiteProvider(widget.podcastId).notifier)
          .loadNextPage();
    });

    _audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        _duration = newDuration;
      });
    });

    _audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        _position = newPosition;
      });
    });

    _audioPlayer.onPlayerComplete.listen((_) {
      setState(() {
        _position = _duration; // Mantener el slider en la posición final
        _currentlyPlayingIndex = null; // Reiniciar el índice
        _isAudioControlVisible = false; // Ocultar los controles de audio
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.pause(); //Pausar el audio al destruir
    _audioPlayer.dispose();
    _tabController.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    await _audioPlayer.pause(); //Pausar el audio al dar boton back en el appbar
    return true; //Permite la navegación hacia atrás
  }

  void _playEpisode(int index) {
    final episodiosState =
        ref.read(episodiosByComiteProvider(widget.podcastId));
    final episodio = episodiosState.episodios[index];
    _audioPlayer.play(UrlSource(episodio.url));
    setState(() {
      _currentlyPlayingIndex = index;
      _isAudioControlVisible = true;
    });
  }

  void _pause() {
    _audioPlayer.pause();
    setState(() {
      _currentlyPlayingIndex = null;
      _isAudioControlVisible =
          true; // Opcional: Ocultar los controles cuando se pausa
    });
  }

  void _playOrPause() {
    if (_audioPlayer.state == PlayerState.playing) {
      _audioPlayer.pause();
    } else {
      if (_currentlyPlayingIndex != null) {
        _audioPlayer.resume();
      } else if (ref
          .read(episodiosByComiteProvider(widget.podcastId))
          .episodios
          .isNotEmpty) {
        _playEpisode(0);
      }
    }
    setState(() {});
  }

  void _playNext() {
    final episodiosState =
        ref.read(episodiosByComiteProvider(widget.podcastId));
    if (_currentlyPlayingIndex != null &&
        _currentlyPlayingIndex! < episodiosState.episodios.length - 1) {
      _playEpisode(_currentlyPlayingIndex! + 1);
    }
  }

  void _playPrevious() {
    if (_currentlyPlayingIndex != null && _currentlyPlayingIndex! > 0) {
      _playEpisode(_currentlyPlayingIndex! - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final podcastState = ref.watch(podcastProvider(widget.podcastId));
    final episodiosState =
        ref.watch(episodiosByComiteProvider(widget.podcastId));

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Podcasts',
            maxLines: 2,
          ),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Episodios'),
              Tab(text: 'Contenido'),
            ],
          ),
        ),
        body: podcastState.isLoading
            ? const Center(child: CircularProgressIndicator())
            : podcastState.podcast == null
                ? const Center(child: Text('Podcast not found'))
                : TabBarView(
                    controller: _tabController,
                    children: [
                      _buildEpisodiosTab(),
                      _buildContenidoTab(podcastState.podcast!),
                    ],
                  ),
        bottomNavigationBar:
            _isAudioControlVisible ? _buildAudioControls() : null,
      ),
    );
  }

  Widget _buildEpisodiosTab() {
    final episodiosState =
        ref.watch(episodiosByComiteProvider(widget.podcastId));

    if (episodiosState.episodios.isEmpty) {
      return Center(
        child: Text(
          'No hay episodios disponibles.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );
    }

    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final episodio = episodiosState.episodios[index];
              bool isPlaying = _currentlyPlayingIndex == index;

              return Column(
                children: [
                  ListTile(
                    title: Text(episodio.titulo),
                    subtitle: Text(episodio.descripcion ?? 'No description'),
                    trailing: IconButton(
                      icon: Icon(
                        isPlaying
                            ? Icons.pause_circle_filled
                            : Icons.play_circle_filled,
                        color: isPlaying ? Colors.red : Colors.green,
                      ),
                      onPressed: () {
                        if (isPlaying) {
                          _pause();
                        } else {
                          _playEpisode(index);
                        }
                      },
                    ),
                    onTap: () {
                      //
                                        },
                  ),
                  Divider(
                    color: Colors.grey.shade300,
                    thickness: 1,
                    height: 1,
                  ),
                ],
              );
            },
            childCount: episodiosState.episodios.length,
          ),
        ),
      ],
    );
  }

  Widget _buildContenidoTab(Podcast podcast) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
            child: Container(
              width: size.width - 120,
              height: size.width - 100,
              decoration: BoxDecoration(
                  image: const DecorationImage(
                      image: NetworkImage(
                          'https://ipucd13.nyc3.digitaloceanspaces.com/public/comites/portadas/rCdCG5moFoG0eBAXsXOdnLEufdZztUkn14B4DMSd.webp'),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(20)),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              podcast.nombre,
              style: Theme.of(context).textTheme.titleLarge,
              maxLines: 3,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Chip(
              label: Text(
                '#Estudio biblico',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.white),
              ),
              backgroundColor: Theme.of(context).primaryColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              podcast.contenido ?? 'No hay contenido disponible',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAudioControls() {
    String _formatDuration(Duration duration) {
      String twoDigits(int n) => n.toString().padLeft(2, "0");
      String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
      String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
      return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Slider(
            activeColor: Theme.of(context).primaryColor,
            inactiveColor: Colors.grey.shade300,
            min: 0,
            max: _duration.inSeconds.toDouble(),
            value: _position.inSeconds
                .toDouble()
                .clamp(0, _duration.inSeconds.toDouble()),
            onChanged: (value) {
              final position = Duration(seconds: value.toInt());
              _audioPlayer.seek(position);
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_formatDuration(_position)),
                Text(_formatDuration(_duration)),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.skip_previous),
                onPressed: _playPrevious,
              ),
              IconButton(
                icon: Icon(
                  _audioPlayer.state == PlayerState.playing
                      ? Icons.pause
                      : Icons.play_arrow,
                ),
                onPressed: _playOrPause,
              ),
              IconButton(
                icon: const Icon(Icons.skip_next),
                onPressed: _playNext,
              ),
            ],
          ),
        ],
      ),
    );
  }
}



/**
 Inicialización de TabController:

    Declaré el TabController con late y lo inicialicé en initState.

dispose:

    Asegúrate de llamar a dispose en _tabController para liberar recursos.

Corrección de Acceso:

    El acceso a _tabController se realiza después de la inicialización en initState.



    ///
    ///Agregar WillPopScope: Se ha envuelto el Scaffold con WillPopScope y se ha agregado el método _onWillPop para manejar la pausa de audio al navegar hacia atrás.

Lógica de Pausa: En el método _onWillPop, se pausa el audio antes de permitir la navegación hacia atrás.

Pausar el Audio en dispose: Se asegura de pausar el audio también cuando el State se destruye.
 */

