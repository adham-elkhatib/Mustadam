import 'package:google_sign_in/google_sign_in.dart';

import '../../../../interfaces/auth_method.dart';

class GoogleAuthMethod implements AuthMethod {
  final GoogleSignIn googleSignIn;

  GoogleAuthMethod({required this.googleSignIn});
}
