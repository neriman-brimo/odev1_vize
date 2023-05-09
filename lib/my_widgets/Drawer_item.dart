import 'package:flutter/material.dart';
import 'package:vize_odev_1/anaSayfa.dart';
import 'package:vize_odev_1/kitleHesaplamaScreen.dart';
import 'package:vize_odev_1/krediHesaplamaScreen.dart';
import 'package:vize_odev_1/renklerScreen.dart';
import 'package:vize_odev_1/yapilacaklarScreen.dart';

class DrawerItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      child: Column(children: [
        Container(
          height: 50,
          width: double.infinity,
          alignment: Alignment.center,
          color: Theme.of(context).colorScheme.primary,
          child:
              const Text('Menü', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        const SizedBox(
          height: 10,
        ),
        buildListTile('AnaSayfa', Icons.home_outlined, () {
          Navigator.pushReplacementNamed(context, AnaSayfaScreen.route);
        }),
        const SizedBox(
          height: 10,
        ),
        buildListTile('kredi hesaplama', Icons.calculate_outlined, () {
          Navigator.pushReplacementNamed(context, KrediHesaplamaScreen.route);
        }),
        const SizedBox(
          height: 10,
        ),
        buildListTile(
            'Vücut Kitle Hesaplama', Icons.settings_accessibility_outlined, () {
          Navigator.pushReplacementNamed(context, KitleHesaplamaScreen.route);
        }),
        const SizedBox(
          height: 10,
        ),
        buildListTile('Renkler', Icons.color_lens_sharp, () {
          Navigator.pushReplacementNamed(context, RenklerScreen.route);
        }),
        const SizedBox(
          height: 10,
        ),
        buildListTile('Yapılacaklar', Icons.add_task, () {
          Navigator.pushReplacementNamed(context, YapilacaklarScreen.route);
        }),
      ]),
    );
  }

  Widget buildListTile(String title, IconData icon, Function() onTapLink) {
    return ListTile(
      leading: Icon(
        icon,
        size: 30,
        color: Colors.blue,
      ),
      title: Text(
        title,
        style: const TextStyle(
            fontFamily: 'TRComfortaa',
            fontSize: 26,
            fontWeight: FontWeight.bold),
      ),
      onTap: onTapLink,
    );
  }
}
