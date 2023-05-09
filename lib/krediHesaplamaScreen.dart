import 'package:flutter/material.dart';
import 'package:vize_odev_1/faizHesaplama.dart';
import 'package:vize_odev_1/my_widgets/Drawer_item.dart';
import 'package:vize_odev_1/my_widgets/my_textField.dart';

class KrediHesaplamaScreen extends StatefulWidget {
  static String route = "/credit";
  const KrediHesaplamaScreen({super.key});

  @override
  State<KrediHesaplamaScreen> createState() => _KrediHesaplamaScreenState();
}

String txtValue = "1";
List<String> krediTurleri = <String>['İhtiyaç', 'Konut', 'Taşıt', 'Ticari'];

class _KrediHesaplamaScreenState extends State<KrediHesaplamaScreen> {
  int ayliktoplam = 0;
  double toplamFaiz = 0;
  int toplamOdeme = 0;
  ////
  double yfo = 0; // yıllık fazi oranı
  int krs = 0; // kredi süresi
  int krt = 0; // kredi tutarı
  ////
  String dropdownValue = krediTurleri.first;
  //late String v;
  TextEditingController _controller = TextEditingController();

  double _currentSliderValue = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kredi Hesaplama"),
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: DropdownButtonFormField(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(20),
                  hint: const Text("Kredi Türü seçiniz"),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  style: const TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                  items: krediTurleri
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              ////////////////////////////////
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: MyTextFilde(
                    controller: TextEditingController(),
                    txt: "Kredi tutarı Giriniz (TL)",
                    onChanged: (value) {
                      if (value == "") {
                        krt = 0;
                      } else {
                        krt = int.parse(value);
                      }
                    },
                    isPassword: false),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: MyTextFilde(
                    controller: TextEditingController(),
                    txt: "Yıllık Faiz Oranını Giriniz (%)",
                    onChanged: (value) {
                      if (value == "") {
                        yfo = 0;
                        _currentSliderValue = 0;
                      } else {
                        yfo = double.parse(value);
                      }
                    },
                    isPassword: false),
              ),
              const SizedBox(height: 10),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    //  textAlign: TextAlign.center,
                    onChanged: (value) {
                      setState(() {
                        if (value == "") {
                          _currentSliderValue = 0;
                          krs = 0;
                        } else if (int.parse(value) < 100) {
                          _currentSliderValue = double.parse(value);
                          krs = int.parse(value);
                        } else if (int.parse(value) > 100) {
                          _currentSliderValue = 100;
                          krs = 100;
                          _controller = TextEditingController(text: "100");
                        }
                      });
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Kredi Süresini Giriniz (ay)",
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.indigo[700]!, width: 2),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 3),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Slider(
                  value: _currentSliderValue,
                  max: 100,
                  divisions: 100,
                  label: _currentSliderValue.round().toString(),
                  onChanged: (double value) {
                    int s = value.toInt();
                    setState(() {
                      _currentSliderValue = value;
                      _controller = TextEditingController(text: s.toString());
                      krs = s;
                    });
                  },
                ),
              ),
              ElevatedButton(
                // minWidth: double.infinity,
                // color: Colors.indigo[700],
                // textColor: Colors.white,
                // elevation: 10,
                onPressed: () {
                  toplamFaiz = FHesapla(dropdownValue, yfo, krs, krt);
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(dropdownValue,
                              style: TextStyle(fontSize: 20)),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Text(
                                    'Aylık Toplam :     ${(krt + toplamFaiz) / krs}',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.indigo[700])),
                                Text('Toplam ödeme:   ${krt + toplamFaiz}',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.indigo[700])),
                                Text('Toplam faiz:         ${toplamFaiz}',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.indigo[700])),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text(
                                'Tamam',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                            ),
                          ],
                        );
                      });
                },
                child: const Text(
                  "Hesapla",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
