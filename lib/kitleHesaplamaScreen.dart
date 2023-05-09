import 'package:flutter/material.dart';
import 'my_widgets/Drawer_item.dart';

class KitleHesaplamaScreen extends StatefulWidget {
  static String route = "/kg";
  const KitleHesaplamaScreen({super.key});

  @override
  State<KitleHesaplamaScreen> createState() => _KitleHesaplamaScreenState();
}

class _KitleHesaplamaScreenState extends State<KitleHesaplamaScreen> {
  TextEditingController _controllerboy = TextEditingController();
  TextEditingController _controllerKg = TextEditingController();

  double _currentSliderValueKg = 0;
  double _currentSliderValueBoy = 0;
  double kg = 0;
  double boy = 0;
  double kitle = 0;
  @override
  Widget build(BuildContext context) {
    // String skitle = kitle.toStringAsFixed(4);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vücüt Kitle indeksi"),
        centerTitle: true,
      ),
      drawer: DrawerItem(),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.indigo[100],
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    "VKi = kg/(boy * boy)",
                    style: TextStyle(color: Colors.deepOrange, fontSize: 30),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 10, left: 8, right: 0, top: 10),
                            child: TextField(
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                              controller: _controllerKg,
                              keyboardType: TextInputType.number,
                              //  textAlign: TextAlign.center,
                              onChanged: (v) {
                                setState(() {
                                  if (v != "") {
                                    kg = double.parse(v);
                                    _currentSliderValueKg = kg;
                                  } else {
                                    kitle = 0;
                                  }
                                  if (kg != 0 && boy != 0 && v != "") {
                                    kitle = kg / (boy * boy);
                                  }
                                });
                              },
                              decoration: InputDecoration(
                                label: const Text(
                                  "Kilonuzu Girin",
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                // hintText: "Kilonuzu Girin",
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.indigo[700]!, width: 2),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blue, width: 3),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                            )),
                      ),
                      Expanded(
                        flex: 1,
                        child: Slider(
                          value: _currentSliderValueKg,
                          max: 200,
                          divisions: 200,
                          label: _currentSliderValueKg.round().toString(),
                          onChanged: (double value) {
                            int s = value.toInt();
                            setState(() {
                              _currentSliderValueKg = value;
                              if (kg != 0 && boy != 0) {
                                kitle = kg / (boy * boy);
                              }
                              if (value != 0) {
                                kg = value;
                              } else {
                                kitle = 0;
                              }
                              _controllerKg =
                                  TextEditingController(text: s.toString());
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 10, left: 8, right: 0, top: 10),
                            child: TextField(
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                              controller: _controllerboy,
                              keyboardType: TextInputType.number,
                              //  textAlign: TextAlign.center,
                              onChanged: (v) {
                                setState(() {
                                  if (v != "") {
                                    _currentSliderValueBoy = double.parse(v);
                                    boy = double.parse(v) / 100;
                                  } else {
                                    kitle = 0;
                                  }
                                  if (kg != 0 && boy != 0 && v != "") {
                                    kitle = kg / (boy * boy);
                                  }
                                });
                              },
                              decoration: InputDecoration(
                                label: const Text(
                                  "Boyunuzu Girin",
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                // hintText: "Boyunuzu Girin",
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.indigo[700]!, width: 2),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blue, width: 3),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                            )),
                      ),
                      Expanded(
                        flex: 1,
                        child: Slider(
                          value: _currentSliderValueBoy,
                          max: 250,
                          divisions: 250,
                          label: _currentSliderValueBoy.round().toString(),
                          onChanged: (double value) {
                            int s = value.toInt();
                            setState(() {
                              _currentSliderValueBoy = value;
                              if (kg != 0 && boy != 0) {
                                kitle = kg / (boy * boy);
                              }
                              if (value != 0) {
                                boy = value / 100;
                              } else {
                                kitle = 0;
                              }
                              _controllerboy =
                                  TextEditingController(text: s.toString());
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Vücüt Kitleniz :",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(width: 10),
                      Text("${kitle.toStringAsFixed(3)} ",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.green)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text("${kit()} ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.blue[900])),
                ],
              ))),
    );
  }

  String kit() {
    if (kitle == 0) {
      return "";
    }
    if (kitle < 16)
      return " Çok Ciddi Zayıflık";
    else if (kitle >= 16 && kitle < 16.9)
      return " Ciddi Zayıflık";
    else if (kitle >= 17 && kitle < 18.4)
      return " Hafif Zayıflık";
    else if (kitle >= 18.5 && kitle < 24.9)
      return " Normal";
    else if (kitle >= 25 && kitle < 29.9)
      return " Fazla Kilolu";
    else if (kitle >= 30 && kitle < 34.9)
      return " Obez (Obezite 1)";
    else if (kitle >= 35 && kitle < 39.9)
      return " Obez (Obezite 2)";
    else
      return " Çok Ciddi Obez (Obezite 3)";
  }
}
