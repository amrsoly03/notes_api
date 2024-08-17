class NoteModel {
  int? noteId;
  String? noteTitle;
  String? noteContent;
  String? noteImage;
  int? noteUser;

  NoteModel({
    this.noteId,
    this.noteTitle,
    this.noteContent,
    this.noteImage,
    this.noteUser,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(
        noteId: json['note_id'] as int?,
        noteTitle: json['note_title'] as String?,
        noteContent: json['note_content'] as String?,
        noteImage: json['note_image'] as String?,
        noteUser: json['note_user'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'note_id': noteId,
        'note_title': noteTitle,
        'note_content': noteContent,
        'note_image': noteImage,
        'note_user': noteUser,
      };
}
