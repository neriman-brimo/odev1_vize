import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'my_widgets/Drawer_item.dart';

class RenklerScreen extends StatefulWidget {
  static String route = "/colors";
  const RenklerScreen({super.key});

  @override
  State<RenklerScreen> createState() => _RenklerScreenState();
}

Color? c = Colors.indigo[100];
String hexColor = c!.value.toRadixString(16);

class _RenklerScreenState extends State<RenklerScreen> {
  double _currentSliderValueRed = 0;
  double _currentSliderValueGreen = 0;
  double _currentSliderValueBlue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Renk Seçimi"),
        centerTitle: true,
      ),
      drawer: DrawerItem(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              color: c,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    const Text(
                      "Renk Seçici",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Kırmızı Tonu:",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Slider(
                      thumbColor: Colors.red,
                      activeColor: Colors.red,
                      inactiveColor: Colors.white,
                      value: _currentSliderValueRed,
                      max: 900,
                      divisions: 9,
                      label: _currentSliderValueRed.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          if (value != 0) {
                            hexColor = c!.value.toRadixString(16);
                            c = Colors.red[value.toInt()];
                          }
                          _currentSliderValueRed = value;
                        });
                      },
                    ),

                    /// 2. renk
                    const SizedBox(height: 20),
                    const Text(
                      "Yeşil Tonu:",
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Slider(
                      thumbColor: Colors.green,
                      activeColor: Colors.green,
                      inactiveColor: Colors.white,
                      value: _currentSliderValueGreen,
                      max: 900,
                      divisions: 9,
                      label: _currentSliderValueGreen.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          if (value != 0) {
                            hexColor = c!.value.toRadixString(16);
                            c = Colors.green[value.toInt()];
                          }
                          _currentSliderValueGreen = value;
                        });
                      },
                    ),
                    //// 3. renk
                    const SizedBox(height: 20),
                    const Text(
                      "Yeşil Tonu:",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Slider(
                      thumbColor: Colors.blue,
                      activeColor: Colors.blue,
                      inactiveColor: Colors.white,
                      value: _currentSliderValueBlue,
                      max: 900,
                      divisions: 9,
                      label: _currentSliderValueBlue.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          if (value != 0) {
                            hexColor = c!.value.toRadixString(16);
                            c = Colors.blue[value.toInt()];
                          }
                          _currentSliderValueBlue = value;
                        });
                      },
                    ),
                    TextButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.amberAccent)),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: hexColor));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Renk kodu kopyalandı")),
                        );
                      },
                      child: Text(
                        hexColor,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _changeColor();
                        });
                      },
                      child: const Text(
                        "Random renk oluştur",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _changeColor() {
    setState(() {
      final random = Random();
      c = Color.fromRGBO(
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
        1,
      );
    });
  }
}
