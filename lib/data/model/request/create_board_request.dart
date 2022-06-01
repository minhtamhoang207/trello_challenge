class CreateBoardRequest {
  String boardName;
  String projectID;
  String background;

  CreateBoardRequest({required this.boardName, required this.projectID, required this.background});

  Map<String, dynamic> toJson() => {
    "name": boardName,
    "background": background,
    "project": projectID
  };
}
