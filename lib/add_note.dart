import 'package:flutter/material.dart';
import 'package:sqflite_project/sqflite_db.dart';

class AddNote extends StatelessWidget {
  AddNote({super.key});
  TextEditingController idController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController nameController = TextEditingController();

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
                  hint: Text('add note'),
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
                    await sqfLiteDb.insertData(
                      noteController.text,
                      nameController.text,
                    );
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      'database',
                      (route) => false,
                    );
                  },
                  child: Text('add Note'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
