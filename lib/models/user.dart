// Represents a user in our app with their basic information
class User {
  // User's unique identifier
  final int id;
  // User's full name
  final String name;
  // User's email address
  final String email;
  // User's phone number
  final String phone;
  // User's website URL
  final String website;

  // Creates a new User instance with required fields
  User({required this.id, required this.name, required this.email, required this.phone, required this.website});

  // Creates a User from JSON data, with fallbacks if data is missing
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String? ?? 'N/A', // Use 'N/A' if name is missing
      email: json['email'] as String? ?? 'N/A', // Use 'N/A' if email is missing
      phone: json['phone'] as String? ?? 'N/A', // Use 'N/A' if phone is missing
      website: json['website'] as String? ?? 'N/A', // Use 'N/A' if website is missing
    );
  }

  // Compare users for equality - useful for testing and state management
  @override
  bool operator ==(Object other) => identical(this, other) || other is User && runtimeType == other.runtimeType && id == other.id && name == other.name && email == other.email && phone == other.phone && website == other.website;

  // Consistent hash code for collections
  @override
  int get hashCode => Object.hash(id, name, email, phone, website);

  // String representation for debugging
  @override
  String toString() => 'User(id: $id, name: $name, email: $email, phone: $phone, website: $website)';
}
