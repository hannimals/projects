class UnlockableThing {
  final String id;
  final String title;
  final String description;
  final String imagePath;
  final bool isItAfriend; // true = friend, false = souvenir

  UnlockableThing({
    required this.description,
    required this.id,
    required this.imagePath,
    required this.isItAfriend,
    required this.title,
  });
  Map<String, dynamic> toJson() => {
    // we create a json type list to store each element so its easier to acsses an is more scallable
    'id': id,
    'title': title,
    'description': description,
    'imagePath': imagePath,
    'isFriend': isItAfriend,
  };
  factory UnlockableThing.fromJson(Map<String, dynamic> json) =>
      UnlockableThing(
        description: json['description'],
        id: json['id'],
        imagePath: json['imagePath'],
        isItAfriend: json['isFriend'],
        title: json['title'],
      );
}
