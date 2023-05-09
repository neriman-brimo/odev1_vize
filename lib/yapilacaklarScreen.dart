import 'package:flutter/material.dart';
import 'DB_data.dart';
import 'my_widgets/Drawer_item.dart';

class YapilacaklarScreen extends StatefulWidget {
  static String route = "/tasks";
  const YapilacaklarScreen({super.key});

  @override
  State<YapilacaklarScreen> createState() => _YapilacaklarScreenState();
}

String gorev = "";

TextEditingController _controller = TextEditingController();
// SQLite database
void createDatabase() async {
  // creat db
  final _database = await DatabaseHelper().db;
}

List<bool> checkState = [];

class _YapilacaklarScreenState extends State<YapilacaklarScreen> {
  bool durum = false;

  /// read data
  Future<List<Map>> readMyData() async {
    List<Map> readResponse =
        await DatabaseHelper().readData("SELECT * FROM 'notes'");
    return readResponse;
  }

  deleteData(myId) async {
    /// güncelle data
    int deleteResponse = await DatabaseHelper()
        .deleteData("DELETE FROM 'notes' WHERE id = $myId ");
    print("silindi $deleteResponse");
  }

  updateData(myId) async {
    /// güncelle data
    int updateResponse = await DatabaseHelper().updateData(
        "UPDATE 'notes' SET ('görev','durum') = ('$gorev','$durum') WHERE id = $myId ");
    setState(() {
      _controller = TextEditingController(text: "");
      gorev = "";
    });
    print("Güncellendi $updateResponse");
  }

  updateCheckboxInDatabase(myId, chDurum) async {
    /// güncelle data
    int updateResponse = await DatabaseHelper().updateData(
        "UPDATE 'notes' SET ('durum') = ('$chDurum') WHERE id = $myId ");
    print("Güncellendi $updateResponse");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        backgroundColor: Colors.green,
        onPressed: () {
          // insertData();
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Not Ekleyin", style: TextStyle(fontSize: 20)),
                  content: TextField(
                    maxLines: 4,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                    controller: _controller,
                    onChanged: (v) {
                      setState(() {
                        gorev = v;
                      });
                    },
                    decoration: InputDecoration(
                      label: const Text(
                        "Görevi yazın",
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
                  ),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        Navigator.pop(context, 'OK');
                        if (gorev != "") {
                          /// insert data
                          var insertResponse = await DatabaseHelper().insertData(
                              "INSERT INTO 'notes' ('görev','durum') VALUES ('$gorev','false')");
                          print(insertResponse);
                          setState(() {
                            _controller = TextEditingController(text: "");
                            gorev = "";
                          });
                        }
                      },
                      child: const Text(
                        'Kaydet',
                        style: TextStyle(fontSize: 20, color: Colors.green),
                      ),
                    ),
                  ],
                );
              });
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 35,
        ),
      ),
      appBar: AppBar(
        title: const Text("Yapılacaklar listesi"),
        centerTitle: true,
      ),
      drawer: DrawerItem(),
      body: ListView(
        children: [
          FutureBuilder(
            future: readMyData(),
            builder: (BuildContext context, AsyncSnapshot<List<Map>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(
                            snapshot.data![i]["görev"],
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: BorderSide(
                                  color: Colors.grey.shade300, width: 1.0)),
                          leading: Checkbox(
                            activeColor: Colors.green,
                            value: snapshot.data![i]["durum"] == 'false'
                                ? false
                                : true,
                            onChanged: (bool? value) {
                              updateCheckboxInDatabase(
                                  snapshot.data![i]["id"], value!);
                              print(snapshot.data![i]["durum"]);

                              setState(() {});
                            },
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text("Notu düzeltin",
                                                style: TextStyle(fontSize: 20)),
                                            content: TextField(
                                              maxLines: 4,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                              controller: _controller,
                                              onChanged: (v) {
                                                setState(() {
                                                  gorev = v;
                                                });
                                              },
                                              decoration: InputDecoration(
                                                label: const Text(
                                                  "Görev:",
                                                ),
                                                fillColor: Colors.white,
                                                filled: true,
                                                // hintText: "Boyunuzu Girin",
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 20),
                                                border:
                                                    const OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(10),
                                                  ),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color:
                                                          Colors.indigo[700]!,
                                                      width: 2),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(10),
                                                  ),
                                                ),
                                                focusedBorder:
                                                    const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.blue,
                                                      width: 3),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(10),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () async {
                                                  Navigator.pop(context, 'OK');
                                                  updateData(
                                                      snapshot.data![i]["id"]);
                                                },
                                                child: const Text(
                                                  'Kaydet',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.green),
                                                ),
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _controller =
                                          TextEditingController(text: "");
                                      deleteData(snapshot.data![i]["id"]);
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  )),
                            ],
                          ),
                        ),
                      );
                    });
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}
