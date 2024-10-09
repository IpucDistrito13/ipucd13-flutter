import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class RadioScreen extends StatefulWidget {
  const RadioScreen({super.key});

  @override
  State<RadioScreen> createState() => _RadioScreenState();
}

class _RadioScreenState extends State<RadioScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  bool _isPlaying = false;
  double _volume = 0.5;

  @override
  void initState() {
    super.initState();
    _audioPlayer.setReleaseMode(ReleaseMode.loop);
    _audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        _isPlaying = false;
      });
    });
  }

  void _playPause() async {
    const String streamUrl =
        'https://play14.tikast.com:22038/stream?type=http&nocache=2126';
    try {
      if (_isPlaying) {
        await _audioPlayer.pause();
      } else {
        // Verificar si el reproductor ya está reproduciendo
        if (_audioPlayer.state != PlayerState.playing) {
          await _audioPlayer
              .setVolume(_volume); // Ajustar el volumen antes de reproducir
          await _audioPlayer
              .play(UrlSource(streamUrl)); // Reproducir la URL del stream
        }
      }

      setState(() {
        _isPlaying = !_isPlaying;
      });
    } catch (e) {
      // Mejor manejar errores de forma visible para el usuario
      _showErrorSnackBar("Error de reproducción.");
    }
  }

// Función auxiliar para mostrar errores
  void _showErrorSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _changeVolume(double value) {
    setState(() {
      _volume = value;
    });
    _audioPlayer.setVolume(_volume);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Radio IPUC'),
      ),
      body: Stack(
        children: [
          // Imagen de fondo
          Positioned.fill(
            child: Image.asset(
              'assets/images/radio_ipuc_background.png', // Imagen de fondo
              fit: BoxFit.cover, // Para que la imagen cubra toda la pantalla
            ),
          ),
          // Contenido principal
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 210),

                // Botón circular de reproducir/pausar
                GestureDetector(
                  onTap: _playPause,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor,
                      border: Border.all(
                        color: Colors.white, // Color del borde
                        width: 1, // Grosor del borde
                      ),
                    ),
                    child: Icon(
                      _isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Slider de volumen
                const SizedBox(height: 20),
                Slider(
                  value: _volume,
                  min: 0.0,
                  max: 1.0,
                  onChanged: _changeVolume,
                  divisions: 10,
                  label: '${(_volume * 100).round()}%',
                ),

                Text(
                  'Volumen: ${(_volume * 100).round()}%',
                  style: const TextStyle(
                    color: Colors.white, // Cambiar el color del texto a blanco
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
