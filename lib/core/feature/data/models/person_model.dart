class PersonModel {
  final String? status;
  final String? email;

  PersonModel({required this.status, required this.email});

  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(
      status: json['status'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'email': email,
    };
  }

  @override
  String toString() => 'PersonModel(status: $status, email: $email)';
}
