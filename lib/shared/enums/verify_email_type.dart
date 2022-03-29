enum VerifyEmailType{
  active,
  forgot
}

extension VerifyEmail on VerifyEmailType{
  String get value {
    switch (this) {
      case VerifyEmailType.active:
        return 'ACTIVE';
      case VerifyEmailType.forgot:
        return 'FORGOT';
      default:
        return '';
    }
  }
}