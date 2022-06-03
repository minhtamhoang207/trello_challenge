import 'package:trello_challenge/data/model/response/board_column_response.dart';

class UpdateTaskRequest{
  String? taskName;
  String columnID;
  int seqNo;
  String? description;
  List<CheckList>? checkList;

  UpdateTaskRequest({
    this.taskName,
    required this.columnID,
    required this.seqNo,
    this.description,
    this.checkList
  });

  Map<String, dynamic> toJson() => {
    if(taskName != null)  "name": taskName,
    "column": columnID,
    "seq_no": seqNo,
    if(description != null) "description": description,
    if(checkList != null || checkList!.isNotEmpty) "checklist":
    List<dynamic>.from(checkList!.map((x) => x.toJson())),
  };
}