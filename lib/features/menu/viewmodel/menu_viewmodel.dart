import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/menu_item.dart';

class MenuViewModel {
  /// Full list of hotel menus — update the [url] values with the real links.
  final List<MenuItem> menus = const [
    MenuItem(
      name: 'Loopy Menu',
      icon: Icons.coffee,
      color: Color(0xFF006A71),
      url: 'https://drive.google.com/drive/folders/1Rjaqep0lGi2GrppdFhBu9VMYCxDaeiLp',
    ),
    MenuItem(
      name: 'Plaza Menu',
      icon: Icons.restaurant,
      color: Color(0xFF48A6A7),
      url: 'https://drive.google.com/drive/folders/1h6hZTNVIsi0eemKvbiXASu6N9FTfQKmI',
    ),
    MenuItem(
      name: 'Pool Menu',
      icon: Icons.pool,
      color: Color(0xFF006A71),
      url: 'https://drive.google.com/drive/folders/1kusHFcQWysyaHJLIKv6plgzV6do5Mfn0',
    ),
    MenuItem(
      name: 'Room Service Menu',
      icon: Icons.room_service,
      color: Color(0xFF48A6A7),
      url: 'https://drive.google.com/drive/folders/14jLS4Qt1M2rkMbjjhvacCtqDSM87YH-g',
    ),
    MenuItem(
      name: 'Italian Restaurant Menu',
      icon: Icons.local_pizza,
      color: Color(0xFF004349),
      url: 'https://drive.google.com/drive/folders/1otwqYPgk2Dat0_vMX-kafl20t6s-ockU',
    ),
    MenuItem(
      name: 'Garden Menu',
      icon: Icons.park,
      color: Color(0xFF48A6A7),
      url: 'https://drive.google.com/drive/folders/1Z6Osk2Vb3DEm3k2Q4Qr9_rizBtrY-n1D',
    ),
    MenuItem(
      name: 'Lavndola Restaurant Menu',
      icon: Icons.dining,
      color: Color(0xFF006A71),
      url: 'https://drive.google.com/drive/folders/1wb5WIJsnVwi3sUHn24FMLw2A1EuPA_vo',
    ),
    MenuItem(
      name: 'Ramadan Menu',
      icon: Icons.nightlight_round,
      color: Color(0xFF004349),
      url: 'https://drive.google.com/drive/folders/151LyMudpOoDQ5a5n8by7z6xvPGeD7L5B',
    ),
  ];

  /// Opens the menu URL in the device's default browser.
  Future<void> openMenu(MenuItem item) async {
    final uri = Uri.parse(item.url);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint('Could not open menu URL "${item.url}": $e');
    }
  }
}
