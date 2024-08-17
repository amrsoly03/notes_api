import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notes_api/constants.dart';
import 'package:notes_api/func/crud.dart';
import 'package:notes_api/main.dart';
import 'package:notes_api/widgets/custom_text_form.dart';

import 'dart:io';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  File? myfile;

  final Crud requests = Crud();

  final TextEditingController titleController = TextEditingController();

  final TextEditingController contentController = TextEditingController();

  addNote(BuildContext context) async {
    if (myfile == null) {
      return AwesomeDialog(context: context,title: 'choose image').show();
    }
    var response = await requests.postRequestWithFile(
      linkAddNote,
      ({
        'title': titleController.text,
        'content': contentController.text,
        'id': sharedPref.getString('id'),
      }),
      myfile!
    );
    if (response['status'] == 'success') {
      Navigator.of(context).pushReplacementNamed('home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
      ),
      body: Form(
        key: globalKey,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              CustomTextForm(hint: 'title', controller: titleController),
              const SizedBox(height: 10),
              CustomTextForm(hint: 'content', controller: contentController),
              const SizedBox(height: 10),
              MaterialButton(
                color: Colors.blue,
                onPressed: () {
                  showModalBottomSheet(
                    constraints: const BoxConstraints.expand(height: 150),
                    context: context,
                    builder: (context) => Column(
                      children: [
                        TextButton(
                          onPressed: () async {
                            await chooseFile(ImageSource.gallery);
                          },
                          child: const Text('from gallery'),
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: () async {
                            await chooseFile(ImageSource.camera);
                          },
                          child: const Text('from camera'),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text('choose image'),
              ),
              const SizedBox(height: 10),
              MaterialButton(
                color: Colors.blue,
                onPressed: () {
                  addNote(context);
                },
                child: const Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  chooseFile(ImageSource source) async {
    XFile? xfile = await ImagePicker().pickImage(source: source);
    myfile = File(xfile!.path);
    Navigator.of(context).pop();
  }
}
