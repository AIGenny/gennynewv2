import 'dart:convert';

class UserModel {
  final String name;
  final String profilePic;
  final String uid;
  final bool isAuthenticated;
  final bool notifyLikes, notifyComments, receiveEmails, newsLetter;
  final String username;
  final String bio;
  final List followers;
  final List following;
  final String email;

  UserModel({
    required this.name,
    required this.profilePic,
    required this.uid,
    required this.isAuthenticated,
    this.notifyLikes = true,
    this.notifyComments = true,
    this.receiveEmails = true,
    this.newsLetter = false,
    required this.email,
    required this.bio,
    required this.followers,
    required this.following,
    required this.username,
  });

  UserModel copyWith({
    String? name,
    String? profilePic,
    String? uid,
    bool? isAuthenticated,
    String? username,
    String? bio,
    List? followers,
    List? following,
    String? email,
  }) {
    return UserModel(
      name: name ?? this.name,
      profilePic: profilePic ?? this.profilePic,
      uid: uid ?? this.uid,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      username: username ?? this.username,
      bio: bio ??this.bio,
      followers: followers ??this.followers,
      following: following ?? this.following,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'profilePic': profilePic,
      'uid': uid,
      'isAuthenticated': isAuthenticated,
      'notifyLikes': notifyLikes,
      'notifyComments': notifyComments,
      'receiveEmails': receiveEmails,
      'newsLetter': newsLetter,
      "bio": bio,
      "followers": followers,
      "following": following,
      "username": username,
      "email": email,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      profilePic: map['profilePic'] as String,
      uid: map['uid'] as String,
      isAuthenticated: map['isAuthenticated'] as bool,
      notifyLikes: (map['notifyLikes'] ?? false) as bool,
      notifyComments: (map['notifyComments'] ?? false) as bool,
      receiveEmails: (map['receiveEmails'] ?? false) as bool,
      newsLetter: (map['newsLetter'] ?? false) as bool,
      bio: map['bio'] as String,
      followers: map['followers'],
      following: map['following'],
      username: map['username'],
      email: map['email'],
    );
  }

  @override
  String toString() {
    return 'UserModel(name: $name, profilePic: $profilePic, uid: $uid, isAuthenticated: $isAuthenticated)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.profilePic == profilePic &&
        other.uid == uid &&
        other.isAuthenticated == isAuthenticated;
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  int get hashCode {
    return name.hashCode ^
        profilePic.hashCode ^
        uid.hashCode ^
        isAuthenticated.hashCode;
  }
}
