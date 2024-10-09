//Lista de menus, para mostrar al admin desde el drawable
import 'package:flutter/material.dart';

class AppMenuAdminItems {
  final String title;
  final String subTitle;
  final String link;
  final IconData icon;

  const AppMenuAdminItems(
      {required this.title,
      required this.subTitle,
      required this.link,
      required this.icon});
}

const appMenuItemsAdmin = <AppMenuAdminItems>[
  AppMenuAdminItems(
      title: 'Congregaciones',
      subTitle: 'Listado de congregaciones',
      link: '/congregaciones',
      icon: Icons.place),
  AppMenuAdminItems(
      title: 'Eventos',
      subTitle: 'Listado de eventos',
      link: '/eventos',
      icon: Icons.event),
  AppMenuAdminItems(
      title: 'Cronograma Distrital',
      subTitle: 'Listado de cronogramas',
      link: '/cronogramas',
      icon: Icons.event_available_outlined),
  AppMenuAdminItems(
      title: 'Descargables',
      subTitle: 'Listado de descargables',
      link: '/descargables',
      icon: Icons.download),
  AppMenuAdminItems(
      title: 'Solicitudes',
      subTitle: 'Solicitudes y certificados',
      link: '/solicitudes',
      icon: Icons.photo_album_rounded),
  AppMenuAdminItems(
      title: 'IPUC en Línea',
      subTitle: 'Tutorial IPUC en Línea',
      link: '/ipuc-en-linea',
      icon: Icons.movie),
  AppMenuAdminItems(
      title: 'Pastores',
      subTitle: 'Listado de pastores',
      link: '/pastores',
      icon: Icons.book),
  AppMenuAdminItems(
      title: 'Líderes',
      subTitle: 'Listado de líderes',
      link: '/lideres',
      icon: Icons.book),
  AppMenuAdminItems(
      title: 'Perfil',
      subTitle: 'Ver el perfil',
      link: '/perfil',
      icon: Icons.person),
  AppMenuAdminItems(
      title: 'Cambiar tema',
      subTitle: 'Cambiar tema de la aplicación',
      link: '/tema',
      icon: Icons.list_alt_rounded),
];
