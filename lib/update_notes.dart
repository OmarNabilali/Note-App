import 'package:flutter/material.dart';
import 'package:sqflite_project/data_base.dart';
import 'package:sqflite_project/sqflite_db.dart';

class UpdateNotes extends StatefulWidget {
  final id;
  final name;
  final note;
  UpdateNotes({
    super.key,
    required this.id,
    required this.name,
    required this.note,
  });

  @override
  State<UpdateNotes> createState() => _UpdateNotesState();
}

class _UpdateNotesState extends State<UpdateNotes> {
  @override
  void initState() {
    idController.text = widget.id;
    nameController.text = widget.name;
    noteController.text = widget.note;
    super.initState();
  }

  final TextEditingController idController = TextEditingController();

  final TextEditingController noteController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  SqfLiteDb sqfLiteDb = SqfLiteDb();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              SizedBox(height: 50),

              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  hint: Text('add name'),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 4, color: Colors.blue),
                  ),
                ),
              ),
              SizedBox(height: 30),
              TextFormField(
                controller: noteController,
                decoration: InputDecoration(
                  hint: Text('update note'),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 4, color: Colors.blue),
                  ),
                ),
              ),
              SizedBox(height: 30),

              Center(
                child: MaterialButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () async {
                    int response = await sqfLiteDb.updateData('''
                     UPDATE notes SET 
                                       
                     name="${nameController.text}",
                     note="${noteController.text}"
                     ''');
                    if (response > 0) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        'database',
                        (route) => false,
                      );
                    }
                    print(response);
                    print('omar');
                  },
                  child: Text('Save Note'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
