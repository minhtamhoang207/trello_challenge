class BoardDetailParams {
  final String backGround;
  final String boardID;
  final String boardName;
  final DateTime? expireDate;
  BoardDetailParams({required this.backGround, required this.boardID, required this.boardName, this.expireDate});
}
