import 'package:flutter/material.dart';
import 'package:sqflite_project/add_note.dart';
import 'package:sqflite_project/sqflite_db.dart';
import 'package:sqflite_project/update_notes.dart';

class DataBase extends StatefulWidget {
  DataBase({super.key});

  @override
  State<DataBase> createState() => _DataBaseState();
}

class _DataBaseState extends State<DataBase> {
  bool isLoading = true;
  SqfLiteDb sqfLiteDb = SqfLiteDb();
  List notes = [];
  Future readData() async {
    List<Map> response = await sqfLiteDb.selectData("SELECT * FROM 'notes'");
    notes.addAll(response);

    isLoading = false;
    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: Colors.blue))
          : ListView(
              children: [
                SizedBox(height: 100),

                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text('name : ${notes[index]['name']}'),
                        subtitle: Text('note :  ${notes[index]['note']}'),
                        trailing: Padding(
                          padding: const EdgeInsets.only(left: 2.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () async {
                                  int response = await sqfLiteDb.deleteData(
                                    'DELETE FROM "notes" WHERE id= ${notes[index]["id"]}',
                                  );
                                  if (response > 0) {
                                    notes.removeWhere(
                                      (element) =>
                                          element['id'] == notes[index]['id'],
                                    );
                                    setState(() {});
                                  }
                                },

                                icon: Icon(Icons.delete),
                              ),

                              IconButton(
                                onPressed: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UpdateNotes(
                                        id: '${notes[index]['id']}',
                                        name: '${notes[index]['name']}',
                                        note: '${notes[index]['note']}',
                                      ),
                                    ),
                                  );
                                },
                                icon: Icon(Icons.edit),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNote()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
