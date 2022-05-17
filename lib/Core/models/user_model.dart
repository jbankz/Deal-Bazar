class UserModel {
  String? fullName;

  String? emailAddress;
  String? password;

  String? phoneNumber;
  String? addressLine;
  String? addressLine2;
  String? faceID;
  String? zipCode;
  String? dbId;
  // String? imageUrl;

  UserModel(
      {this.addressLine,
      this.addressLine2,
      this.faceID,
      this.emailAddress,
      // this.imageUrl,
      this.fullName,
      this.password,
      this.phoneNumber,
      this.dbId,
      this.zipCode});

  toFirebase() {
    return {
      'addressLine': addressLine,
      'addressLine2': addressLine2,
      'faceId': faceID,
      // 'imageUrl': imageUrl,
      'dbId': dbId,

      'zipCode': zipCode,

      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'emailAddress': emailAddress,
    };
  }

  messageToFirebase(String message) {
    return {
      'addressLine': addressLine,
      'addressLine2': addressLine2,
      'faceId': faceID,
      // 'imageUrl': imageUrl,
      'dbId': dbId,

      'zipCode': zipCode,

      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'emailAddress': emailAddress,

      'message': message,
    };
  }

  factory UserModel.fromFirebase({firebase}) {
    return UserModel(
      fullName: firebase['fullName'],

      emailAddress: firebase['emailAddress'],
      addressLine2: firebase['addressLine2'],
      faceID: firebase['faceId'],
      phoneNumber: firebase['phoneNumber'],
      zipCode: firebase['zipCode'],

      // imageUrl: firebase['imageUrl'],
      addressLine: firebase['addressLine'],

      dbId: firebase['dbId'],
    );
  }
}
