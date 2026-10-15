



abstract class Helper {
  static String? passwordvalidator(String pass) {
    if (pass.isEmpty) return 'Password cannot be empty';
    if (pass.length < 8) return 'Password must be at least 8 characters long';
    if (!RegExp(r'[A-Z]').hasMatch(pass)) return 'Must contain at least one uppercase letter';
    if (!RegExp(r'[a-z]').hasMatch(pass)) return 'Must contain at least one lowercase letter';
    if (!RegExp(r'[0-9]').hasMatch(pass)) return 'Must contain at least one number';
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(pass)) return 'Must contain at least one special character';
    
    return null;
  }

  static String? validatorError(String matcher, {String? v}) {
    switch (matcher) {
      case 'pass':
        return passwordvalidator(v ?? '');

      case 'sitename':
        return v!.isEmpty? 'please fill sitename':null;
      case 'email':
        return  v!.isEmpty? 'please fill email or username':null;
    }
    return null;
  }
}
