// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:notes_api/constants.dart';
import 'package:notes_api/models/note_model.dart';

class CardNote extends StatelessWidget {
  const CardNote({
    super.key,
    required this.noteModel,
    this.onTap,
    required this.onDelete,
  });

  final NoteModel noteModel;
  final void Function()? onTap;
  final void Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Image.network(
                '$linkUploadImage/${noteModel.noteImage}',
                height: 100,
                width: 100,
              ),
            ),
            Expanded(
              child: ListTile(
                title: Text(noteModel.noteTitle!),
                subtitle: Text(noteModel.noteContent!),
                trailing: IconButton(
                  onPressed: onDelete,
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
