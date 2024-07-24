import 'package:google_sign_in/google_sign_in.dart';
import 'package:translator/translator.dart';
class GoogleSignInApi{
  static final _googleSignIn = GoogleSignIn();

  static Future<GoogleSignInAccount?> login = _googleSignIn.signIn();

  static Future logout = _googleSignIn.disconnect();
}
class GoogleTrans{
  static GoogleTranslator translator = GoogleTranslator();
}