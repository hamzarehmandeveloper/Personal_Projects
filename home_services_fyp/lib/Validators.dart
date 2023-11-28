class Validators {
  bool validateEmail(String email) {
    return RegExp(
        r"[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
        .hasMatch(email);
  }

  bool validateName(String name) {
    if (name.length < 3 || name.isEmpty) {
      return false;
    }
    return !RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(name);
  }

  bool validateNumber(String num) {
    final RegExp regExp = RegExp(r'^[0-9]+$');
    return regExp.hasMatch(num);
  }

  bool validatePassword(String password) {
    if (password.length < 6 || password.isEmpty) {
      return false;
    }
    return true;
  }
}