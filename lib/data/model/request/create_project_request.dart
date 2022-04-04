class CreateProjectRequest{
  String name;
  String description;
  bool private;

  CreateProjectRequest({required this.name, this.description = '', this.private = true});

  Map<String, dynamic> toJson() => {
    "name": name,
    "description": description,
    "is_private": private
  };
}