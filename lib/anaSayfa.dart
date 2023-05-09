import 'package:flutter/material.dart';
import 'package:vize_odev_1/kitleHesaplamaScreen.dart';
import 'package:vize_odev_1/krediHesaplamaScreen.dart';
import 'package:vize_odev_1/renklerScreen.dart';
import 'package:vize_odev_1/yapilacaklarScreen.dart';
import 'my_widgets/Drawer_item.dart';

class AnaSayfaScreen extends StatefulWidget {
  static String route = "/home";
  const AnaSayfaScreen({super.key});

  @override
  State<AnaSayfaScreen> createState() => _AnaSayfaScreenState();
}

class _AnaSayfaScreenState extends State<AnaSayfaScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/home": (context) => const AnaSayfaScreen(),
        RenklerScreen.route: (context) => const RenklerScreen(),
        KitleHesaplamaScreen.route: (context) => const KitleHesaplamaScreen(),
        KrediHesaplamaScreen.route: (context) => const KrediHesaplamaScreen(),
        YapilacaklarScreen.route: (context) => const YapilacaklarScreen(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.indigo[700],
          secondary: Colors.indigo[100],
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Ana Sayfa"),
          centerTitle: true,
        ),
        drawer: DrawerItem(),
        backgroundColor: Colors.indigo[100],
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 50),
                const CircleAvatar(
                  radius: 60.0,
                  backgroundImage: AssetImage('images/1.jpeg'),
                ),
                const Text(
                  'Neriman BRİMO',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 25.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  '     Bartın Üniversitesi\nBilgisayar Mühendisliği',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 200.0,
                  height: 20.0,
                  child: Divider(
                    color: Colors.white,
                    thickness: 2.0,
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(10.0),
                  child: ListTile(
                    title: const Text(
                      '05-- --- ----',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    leading: Icon(
                      Icons.phone,
                      size: 30.0,
                      color: Colors.green[700],
                    ),
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(10.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.mail,
                      color: Colors.red[700],
                      size: 30.0,
                    ),
                    title: const Text(
                      'nerimanbrimo@gmail.com',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 300,
                  child: Divider(color: Colors.black, thickness: 2),
                ),
                const Text(
                  'Ödev 1',
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
