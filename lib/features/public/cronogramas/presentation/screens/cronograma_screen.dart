import 'package:calendar_view/calendar_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Define el modelo para los eventos de la API
class ApiEvent {
  final int id;
  final String nombre;
  final DateTime start;
  final DateTime end;
  final String? lugar;
  final String? descripcion;
  final String? url;

  ApiEvent({
    required this.id,
    required this.nombre,
    required this.start,
    required this.end,
    this.lugar,
    this.descripcion,
    this.url,
  });

  factory ApiEvent.fromJson(Map<String, dynamic> json) {
    return ApiEvent(
      id: json['id'],
      nombre: json['nombre'],
      start: DateTime.parse(json['start']),
      end: DateTime.parse(json['end']),
      lugar: json['lugar'],
      descripcion: json['descripcion'],
      url: json['url'],
    );
  }
}

const colorList = <Color>[
  Color(0xFF00338D),
  Color(0xFFF009FDA),
  Color(0xFFF0AB00),
];

class AppTheme {
  final int selectedColor;

  AppTheme({
    this.selectedColor = 1,
  }) : assert(selectedColor >= 0 && selectedColor < colorList.length,
            'Selected color must be between 0 and ${colorList.length - 1}');

  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorSchemeSeed: colorList[selectedColor],
        appBarTheme: const AppBarTheme(centerTitle: false),
        fontFamily: 'MyriamPro',
      );

  AppTheme copyWith({int? selectedColor}) => AppTheme(
        selectedColor: selectedColor ?? this.selectedColor,
      );
}

class CronogramasScreen extends StatefulWidget {
  static const String name = 'cronograma-screen';
  const CronogramasScreen({super.key});

  @override
  State<CronogramasScreen> createState() => _CronogramaScreenState();
}

class _CronogramaScreenState extends State<CronogramasScreen>
    with SingleTickerProviderStateMixin {
  late EventController controller;
  late TabController _tabController;
  bool _isLoading = true; // Estado para el indicador de carga

  @override
  void initState() {
    super.initState();
    controller = EventController();
    _tabController = TabController(length: 3, vsync: this);
    _fetchAndAddEvents(); // Llama a la función para obtener eventos de la API
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _fetchAndAddEvents() async {
    try {
      final url =
          'https://ipucdistrito13.org/api/v2/cronogramas?limit=10&offset=0&api_key=EPcOwNCTHvpjtaJDEfO8beeGdavjWL3j';
      final response = await Dio().get(url);

      if (response.statusCode == 200) {
        final data = response.data['data'] as List<dynamic>;
        _addEventsFromApiData(data);
      } else {
        throw Exception('Error al cargar eventos');
      }
    } catch (e) {
      // Manejar errores de la solicitud
      print('Error: $e');
      // Opcional: Puedes mostrar un mensaje de error en la UI
    } finally {
      setState(() {
        _isLoading =
            false; // Oculta el indicador de carga después de la solicitud
      });
    }
  }

  void _addEventsFromApiData(List<dynamic> apiData) {
    final events = apiData.map((json) {
      final cronograma = ApiEvent.fromJson(json);
      return CalendarEventData(
        date: cronograma.start,
        title: cronograma.nombre,
        description: cronograma.descripcion,
        startTime: cronograma.start,
        endTime: cronograma.end,
        color: _getEventColor(cronograma.id),
        event: cronograma, // Almacena el objeto ApiEvent completo
      );
    }).toList();

    controller.addAll(events);
  }

  Color _getEventColor(int eventId) {
    return colorList[eventId % colorList.length];
  }

// Actualiza la función _showEventDialog para incluir el lugar
  void _showEventDialog(CalendarEventData event) {
    final ApiEvent apiEvent = event.event as ApiEvent;

    final DateFormat timeFormat = DateFormat('hh:mm a');
    final String startTimeFormatted = event.startTime != null
        ? timeFormat.format(event.startTime!)
        : 'No disponible';
    final String endTimeFormatted = event.endTime != null
        ? timeFormat.format(event.endTime!)
        : 'No disponible';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(event.title ?? 'Sin título'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Inicio: $startTimeFormatted'),
            Text('Fin: $endTimeFormatted'),
            if (apiEvent.lugar != null) Text('Lugar: ${apiEvent.lugar}'),
            if (event.description != null)
              Text('Descripción: ${event.description}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme();
    final lightTheme = appTheme.getTheme();

    return Theme(
      data: lightTheme,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Eventos'),
          centerTitle: false,
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Día'),
              Tab(text: 'Semana'),
              Tab(text: 'Mes'),
            ],
          ),
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : CalendarControllerProvider(
                controller: controller,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    DayView(
                      controller: controller,
                      eventTileBuilder:
                          (date, events, boundary, startDuration, endDuration) {
                        return _customEventTile(events.first);
                      },
                      onEventTap: (events, date) {
                        if (events.isNotEmpty) {
                          _showEventDialog(events.first);
                        }
                      },
                    ),
                    WeekView(
                      controller: controller,
                      eventTileBuilder:
                          (date, events, boundary, startDuration, endDuration) {
                        return _customEventTile(events.first);
                      },
                      onEventTap: (events, date) {
                        if (events.isNotEmpty) {
                          _showEventDialog(events.first);
                        }
                      },
                    ),
                    MonthView(
                      controller: controller,
                      onEventTap: (event, date) {
                        _showEventDialog(event);
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _customEventTile(CalendarEventData event) {
    final ApiEvent apiEvent = event.event as ApiEvent;

    final DateFormat timeFormat = DateFormat('hh:mm a');
    final String startTimeFormatted = event.startTime != null
        ? timeFormat.format(event.startTime!)
        : 'No disponible';
    final String endTimeFormatted = event.endTime != null
        ? timeFormat.format(event.endTime!)
        : 'No disponible';

    return Container(
      decoration: BoxDecoration(
        color: event.color.withOpacity(0.8),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              event.title ?? 'Sin título',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              'Inicio: $startTimeFormatted',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              'Fin: $endTimeFormatted',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (apiEvent.lugar != null)
              Text(
                apiEvent.lugar!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
      ),
    );
  }
}
