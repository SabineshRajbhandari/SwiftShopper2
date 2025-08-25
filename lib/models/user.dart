class User {
  final String id;
  final String name;
  final String email;
  final String? phone;

  User({required this.id, required this.name, required this.email, this.phone});

  // Factory constructor to create a User instance from Firestore document data
  factory User.fromMap(Map<String, dynamic> data, String documentId) {
    return User(
      id: documentId,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'],
    );
  }

  // Method to convert User instance to map for saving to Firestore
  Map<String, dynamic> toMap() {
    return {'name': name, 'email': email, 'phone': phone};
  }
}
