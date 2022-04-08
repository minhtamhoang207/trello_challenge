class CreateBoardRequest {
  String boardName;
  String projectID;
  DateTime expireDate;

  CreateBoardRequest({required this.boardName, required this.expireDate, required this.projectID});

  Map<String, dynamic> toJson() => {
    "name": boardName,
    "closed_at": expireDate.toIso8601String(),
    "background": '',
    "project": projectID
  };
}
