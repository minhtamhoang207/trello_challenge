class UpdateTaskRequest{
  String? taskName;
  String columnID;
  int seqNo;
  String? description;

  UpdateTaskRequest({
    this.taskName,
    required this.columnID,
    required this.seqNo,
    this.description});

  Map<String, dynamic> toJson() => {
    if(taskName != null)  "name": taskName,
    "column": columnID,
    "seq_no": seqNo,
    if(description != null) "description": description
  };
}