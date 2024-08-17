import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notes_api/constants.dart';
import 'package:notes_api/func/crud.dart';
import 'package:notes_api/widgets/custom_text_form.dart';

class EditNote extends StatefulWidget {
  const EditNote({super.key, this.note});
  final note;

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  File? myfile;

  final Crud requests = Crud();

  TextEditingController titleController = TextEditingController();

  TextEditingController contentController = TextEditingController();

  editNote(BuildContext context) async {
    var response;
    if (myfile == null) {
      response = await requests.postRequest(
          linkEditNote,
          ({
            'title': titleController.text,
            'content': contentController.text,
            'id': widget.note['note_id'].toString(),
            'imagename' : widget.note['note_image'].toString(),
          }));
    } else {
      response = await requests.postRequestWithFile(
        linkEditNote,
        ({
          'title': titleController.text,
          'content': contentController.text,
          'id': widget.note['note_id'].toString(),
          'imagename' : widget.note['note_image'].toString(),
        }),
        myfile!,
      );
    }

    if (response['status'] == 'success') {
      Navigator.of(context).pushReplacementNamed('home');
    }
  }

  @override
  void initState() {
    super.initState();

    titleController.text = widget.note['note_title'];
    contentController.text = widget.note['note_content'];
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
                child: const Text('change image'),
              ),
              const SizedBox(height: 10),
              MaterialButton(
                onPressed: () {
                  editNote(context);
                },
                color: Colors.blue,
                child: const Text('Save'),
              )
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
