import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_view/photo_view.dart';
import '/features/admin/galerias/presentation/provider/galeria_by_usuario_provider.dart';
import '/features/admin/usuarios/presentation/provides/usuario_perfil_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PastorScreen extends ConsumerStatefulWidget {
  static const name = 'usuario-perfil-screen';

  final String uuid;
  const PastorScreen({super.key, required this.uuid});

  @override
  PastorScreenState createState() => PastorScreenState();
}

class PastorScreenState extends ConsumerState<PastorScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  double _opacity = 0.0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(galeriaByUsuarioProvider(widget.uuid).notifier).loadNextPage();
    });

    _tabController = TabController(length: 1, vsync: this);
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showEnlargedImage(
      BuildContext context, String imageUrl, String heroTag) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) =>
          EnlargedImageView(imageUrl: imageUrl, heroTag: heroTag),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final usuarioState = ref.watch(usuarioPerfilProvider(widget.uuid));
    final galeriaState = ref.watch(galeriaByUsuarioProvider(widget.uuid));

    if (usuarioState.isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cargando...'),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (usuarioState.usuario == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Usuario no encontrado'),
        ),
        body: const Center(
            child:
                Text('No se encontró el usuario con el UUID proporcionado.')),
      );
    }

    final usuario = usuarioState.usuario!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${usuario.nombre} ${usuario.apellidos}',
          maxLines: 1,
        ),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => _showEnlargedImage(
                              context, usuario.imagen ?? '', 'profileImage'),
                          child: Hero(
                            tag: 'profileImage',
                            child: CircleAvatar(
                              radius: 40,
                              backgroundImage: usuario.imagen != null
                                  ? NetworkImage(usuario.imagen!)
                                  : null,
                              child: usuario.imagen == null
                                  ? const Icon(Icons.person, size: 40)
                                  : null,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${usuario.congregacion ?? 'No disponible'}',
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'Congregación: ${usuario.direccion ?? 'No disponible'}',
                                maxLines: 2,
                              ),
                              Text(
                                'Departamento: ${usuario.departamento ?? 'No disponible'}',
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'Municipio: ${usuario.municipio ?? 'No disponible'}',
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'Celular: ${usuario.celular ?? 'No disponible'}',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    AnimatedOpacity(
                      opacity: _opacity,
                      duration: const Duration(seconds: 2),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () =>
                                    _makePhoneCall(usuario.celular ?? ''),
                                icon: const Icon(Icons.call),
                                label: const Text('Llamar'),
                              ),
                              ElevatedButton.icon(
                                onPressed: () =>
                                    _openWhatsApp(usuario.celular ?? ''),
                                icon: const Icon(Icons.message),
                                label: const Text('WhatsApp'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    controller: _tabController,
                    tabs: const [
                      Tab(text: 'Galería'),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            Builder(
              builder: (BuildContext context) {
                if (galeriaState.galerias.isEmpty) {
                  return const Center(
                    child: Text(
                      'Sin galería',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  );
                }

                return CustomScrollView(
                  slivers: <Widget>[
                    SliverOverlapInjector(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.all(8.0),
                      sliver: SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            final galeria = galeriaState.galerias[index];
                            final imageUrl = galeria.imagen ?? '';
                            return GestureDetector(
                              onTap: () => _showEnlargedImage(
                                  context, imageUrl, 'galleryImage$index'),
                              child: Hero(
                                tag: 'galleryImage$index',
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    imageUrl,
                                    fit: BoxFit.cover,
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                        ),
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Center(
                                        child: Icon(Icons.error),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                          childCount: galeriaState.galerias.length,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _makePhoneCall(String phoneNumber) async {
    if (phoneNumber.isEmpty) return;
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await _launchUrl(launchUri);
  }

  void _openWhatsApp(String phoneNumber) async {
    if (phoneNumber.isEmpty) return;
    final Uri launchUri = Uri.parse("https://wa.me/+57$phoneNumber");
    await _launchUrl(launchUri);
  }

  void _openGoogleMaps(double? lat, double? lon) async {
    if (lat == null || lon == null) return;
    final Uri launchUri =
        Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lon');
    await _launchUrl(launchUri);
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

class EnlargedImageView extends StatelessWidget {
  final String imageUrl;
  final String heroTag;

  const EnlargedImageView(
      {Key? key, required this.imageUrl, required this.heroTag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: Hero(
              tag: heroTag,
              child: PhotoView(
                imageProvider: NetworkImage(imageUrl),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2,
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 30),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}
