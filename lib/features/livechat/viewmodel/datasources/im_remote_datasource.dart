class ImRemoteDatasource {
//   Future<List<LockerNote>> getLockerNotes({required GetLockerNotesParams params}) async {
//     var url = InnoConfig.mainNetworkConfig.getLockerNotes(params.page, params.pageSize);
//     var res = await NetworkManager.postRequestSync(url);
//     var notes = <LockerNote>[];
//     for (var item in res['data']['notes']) {
//       notes.add(LockerNote.fromJson(item));
//     }
//     return notes;
//   }
//
//   Future<void> saveLockerNote({required SaveLockerNoteParams params}) async {
//     var url = InnoConfig.mainNetworkConfig.saveLockerNote(params.model.id);
//     var res = await NetworkManager.postRequestSync(url);
//   }
//
//   Future<void> deleteLockerNote({required DeleteLockerNoteParams params}) async {
//     var url = InnoConfig.mainNetworkConfig.deleteLockerNote(params.model.id);
//     var res = await NetworkManager.postRequestSync(url);
//   }
}
