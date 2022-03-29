class UpdateProfileRequest {
  String nickname;
  String bio;

  UpdateProfileRequest({required this.nickname, required this.bio});

  Map<String, dynamic> toJson() => {
        if (nickname.isNotEmpty) 'nickname': nickname,
        if (bio.isNotEmpty) 'bio': bio,
      };
}
