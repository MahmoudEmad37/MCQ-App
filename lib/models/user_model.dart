
class UserModel{
    final String? email;
    final String? id;
    final String? name;
    final PictureModel? pictureModel;

    const UserModel({this.name,this.pictureModel,this.email,this.id});

    Map<String, dynamic> toMap() {
    return {
      'email': this.email,
      'id': this.id,
      'name': this.name,
      'picture': this.pictureModel,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'],
      id: map['id'] as String,
      name: map['name'],
      pictureModel: PictureModel.fromMap(map['picture']['data']),
    );
  }
}


class PictureModel{
  final String? url;
  final int? width;
  final int? height;

  const PictureModel({this.width,this.height,this.url});

  Map<String, dynamic> toMap() {
    return {
      'url': this.url,
      'width': this.width,
      'height': this.height,
    };
  }

  factory PictureModel.fromMap(Map<String, dynamic> map) {
    return PictureModel(
      url: map['url'],
      width: map['width'],
      height: map['height'],
    );
  }
}