import 'dart:math';
import 'dart:typed_data';
import 'package:cryptography/cryptography.dart';
import 'package:crypton/crypton.dart';

class Crypto {
  Uint8List getRandUint8List(int len) {
    var random = Random.secure();
    var values = List<int>.generate(len, (i) => random.nextInt(255));
    return Uint8List.fromList(values);
  }

  Future<Uint8List> aesEncrypt(List<int> data, SecretKey secretKey) async {
    final algorithm = AesGcm.with256bits();
    final secretBox = await algorithm.encrypt(
      data,
      secretKey: secretKey,
      nonce: getRandUint8List(12),
    );
    return secretBox.concatenation();
  }

  Future<List<int>> aesDecrypt(Uint8List cipherText, SecretKey secretKey) async {
    final algorithm = AesGcm.with256bits();
    SecretBox secretBox =
        SecretBox.fromConcatenation(cipherText, nonceLength: 12, macLength: 16);
    final plainText = await algorithm.decrypt(secretBox, secretKey: secretKey);
    return plainText;
  }

  String rsaEncrypt(RSAKeypair keyPair, String data) {
    String cipherText = keyPair.publicKey.encrypt(data);
    return cipherText;
  }

  Uint8List rsaDecrypt(RSAKeypair keyPair, Uint8List cipherText) {
    Uint8List plainText = keyPair.privateKey.decryptData(cipherText);
    return plainText;
  }

  RSAPublicKey loadpemtopub(String key) {
    RSAPublicKey pubKey = RSAPublicKey.fromPEM(key);
    return pubKey;
  }
}

