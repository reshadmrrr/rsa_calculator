class Rsa {
  BigInt p;
  BigInt q;
  BigInt e;
  String message;
  String encodedMessage;
  List<BigInt> eList = [];

  Rsa({this.p, this.q, this.e, this.message});

  get getN => p * q;
  get getPhiN => (p - BigInt.one) * (q - BigInt.one);
  get getD => e.modInverse(getPhiN);
  get getE => e;

  List<BigInt> generateEList() {
    eList.clear();
    var n = getN;
    var phiN = getPhiN;
    for (BigInt i = BigInt.two; i < phiN; i += BigInt.one) {
      if (phiN.gcd(i) == BigInt.one && n.gcd(i) == BigInt.one) eList.add(i);
    }
    return eList;
  }

  String getOriginalMessage() {
    List<int> decode = [];
    int len = encodedMessage.length;
    BigInt m, c, d = getD, n = getN;
    for (int i = 0; i < len; ++i) {
      m = BigInt.from(encodedMessage.codeUnitAt(i));
      c = m.modPow(d, n);
      decode.add(c.toInt());
    }
    return String.fromCharCodes(decode);
  }

  String getEncodedMessage() {
    List<int> encode = [];
    int len = message.length;
    BigInt m, c, e = getE, n = getN;
    for (int i = 0; i < len; ++i) {
      m = BigInt.from(message.codeUnitAt(i));
      c = m.modPow(e, n);
      encode.add(c.toInt());
    }
    return String.fromCharCodes(encode);
  }
}
