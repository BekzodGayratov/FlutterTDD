import 'package:encrypt/encrypt.dart';

class CryptoService {
  static final _key = Key.fromUtf8("gfgfgfgfgfgfgfgfgfgfgfgfgfgfgfgf");
  static final _iv = IV.fromUtf8("yttytytytytytyty");

  static String encrypt(String data) {
    final encrypter = Encrypter(AES(_key, mode: AESMode.cbc));
    return encrypter.encrypt(data, iv: _iv).base64;
  }

  static String decrypt(String data) {
    final decrypter = Encrypter(AES(_key, mode: AESMode.cbc));
    return decrypter.decrypt64(data, iv: _iv);
  }
}
