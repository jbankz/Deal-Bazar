class MessageModel {
  String? fullName;
  String? lastName;
  String? emailAddress;
  String? phoneNumber;
  String? dbId;
  String? imageUrl;
  String? message;
  dynamic createdAt;

  MessageModel({
    this.emailAddress,
    this.imageUrl,
    this.fullName,
    this.lastName,
    this.phoneNumber,
    this.message,
    this.dbId,
    this.createdAt,
  });

  messageToFirebase() {
    return {
      'imageUrl': imageUrl,
      'dbId': dbId,
      'lastName': lastName,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'emailAddress': emailAddress,
      'message': message,
      'createdAt': createdAt,
    };
  }

  factory MessageModel.fromFirebase({firebase}) {
    return MessageModel(
      // TODO: Changes in this Model Required
      // fullName: firebase['fullName'] ?? '',
      // lastName: firebase['lastName'] ?? '',
      // emailAddress: firebase['emailAddress'] ?? '',
      // phoneNumber: firebase['phoneNumber'] ?? '',
      // imageUrl: firebase['imageUrl'] ?? '',
      dbId: firebase['dbId'],
      message: firebase['message'],
      createdAt: firebase['createdAt'],
    );
  }
}
