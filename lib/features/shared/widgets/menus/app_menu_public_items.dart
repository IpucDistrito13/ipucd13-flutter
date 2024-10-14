import 'package:flutter/material.dart';

//LISTA DE MENUS, PARA MOSTRAR AL PUBLICO DESDE EL DRAWABLE
class AppMenuPublicItems {
  final String title;
  final String subTitle;
  final String link;
  final IconData icon;

  const AppMenuPublicItems(
      {required this.title,
      required this.subTitle,
      required this.link,
      required this.icon});
}

const appMenuItemsPublic = <AppMenuPublicItems>[
  AppMenuPublicItems(
      title: 'Inicio', subTitle: '', link: '/public-screen', icon: Icons.home),
  AppMenuPublicItems(
      title: 'Tema',
      subTitle: 'Cambiar tema del dispositivo',
      link: '/tema',
      icon: Icons.dark_mode),
  AppMenuPublicItems(
      title: 'Iniciar sesión',
      subTitle: 'Ingresar en la aplicación',
      link: '/login',
      icon: Icons.login),
];
