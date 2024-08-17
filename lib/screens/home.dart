import 'package:flutter/material.dart';
import 'package:notes_api/constants.dart';
import 'package:notes_api/func/crud.dart';
import 'package:notes_api/main.dart';
import 'package:notes_api/models/note_model.dart';
import 'package:notes_api/screens/edit_note.dart';

import '../widgets/card_note.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final Crud requests = Crud();

  getNotes() async {
    var response = await requests.postRequest(
        linkViewNote, ({'id': sharedPref.getString('id')}));
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () {
              sharedPref.clear();
              Navigator.of(context).pushReplacementNamed('login');
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            FutureBuilder(
              future: getNotes(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data['status'] == 'failed') {
                    return const Center(
                      child: Text('no data found, please add note'),
                    );
                  }
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data['data'].length,
                    itemBuilder: (context, i) {
                      return CardNote(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => EditNote(
                                    note: snapshot.data['data'][i],
                                  )),
                        ),
                        onDelete: () async {
                          var response = await requests.postRequest(
                              linkDeleteNote,
                              ({
                                'id': snapshot.data['data'][i]['note_id']
                                    .toString(),
                                'file': snapshot.data['data'][i]['note_image']
                                    .toString(),
                              }));
                          Navigator.of(context).pushReplacementNamed('home');
                        },
                        noteModel: NoteModel.fromJson(snapshot.data['data'][i]),
                        
                      );
                    },
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Text('Loading...'),
                  );
                }
                return const Center(
                  child: Text('Loading...'),
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('addNote');
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
