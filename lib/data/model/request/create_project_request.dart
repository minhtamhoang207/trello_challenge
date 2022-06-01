class CreateProjectRequest{
  String name;
  String description;
  String type;

  CreateProjectRequest({required this.name, this.description = '', required this.type});

  Map<String, dynamic> toJson() => {
    "name": name,
    "description": description,
    "type": type
  };
}