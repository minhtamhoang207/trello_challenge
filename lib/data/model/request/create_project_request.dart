class CreateProjectRequest{
  String name;
  String description;
  String type;
  String? inviteCode;

  CreateProjectRequest({required this.name, this.description = '', required this.type, this.inviteCode});

  Map<String, dynamic> toJson() => {
    "name": name,
    "description": description,
    "type": type,
    if(inviteCode != null ) "inviteCode": inviteCode
  };
}