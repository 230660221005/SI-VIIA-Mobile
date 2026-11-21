
class DataUser {
  final int id;
  final String name;
  final String username;
  final String email;

  DataUser({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
  });

  factory DataUser.fromJson(Map<String, dynamic> json) {
    return DataUser(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Tidak diketahui',
      username: json['username'] ?? '-',
      email: json['email'] ?? '-',
    );
  }
}
