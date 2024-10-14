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
        //VERIFICA QUE EL REPRODUCTOR YA ESTA REPRODUCIENDO
        if (_audioPlayer.state != PlayerState.playing) {
          //AJUSTAR EL VOLUMEN ANTES DE REPRODUCIR
          await _audioPlayer
              .setVolume(_volume);
          //REPRODUCIR LA URL DEL STREAM
          await _audioPlayer
              .play(UrlSource(streamUrl));
        }
      }

      setState(() {
        _isPlaying = !_isPlaying;
      });
    } catch (e) {
      //MANEJA ERRORES DE FORMA VISIBLE PARA EL USUARIO
      _showErrorSnackBar("Error de reproducción. $e");
      print('Radio_screen: error de reproduccion: $e');
    }
  }

  //FUNCION AUXILIAR PARA MOSTRAR ERRORES
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
          //IMAGEN DE FONDO
          Positioned.fill(
            child: Image.asset(
              'assets/images/radio_ipuc_background.png',
              //PARA QUE LA IMAGEN CUBRA TODA LA PANTALLA
              fit: BoxFit.cover,
            ),
          ),

          //CONTENIDO PRINCIPAL
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 210),

                // BOTON CIRCULAR DE REPRODUCIR/PAUSAR
                GestureDetector(
                  onTap: _playPause,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor,
                      border: Border.all(
                        color: Colors.white,
                        width: 1,
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
                    //CAMBIAR EL COLOR DE TEXTO
                    color: Colors.white,
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
