class SocialUserModel
{
  String? email ;
  String? name;
  String? phone;
  String? uId;
  String? image;
  String? cover;
  String? bio;
  bool? isEmailVerified;


  SocialUserModel({this.email, this.name,this.bio, this.phone, this.cover, this.uId,this.isEmailVerified,this.image});

  SocialUserModel.fromJson(Map <String,dynamic>json )
  {
    email =json['email'];
    name =json['name'];
    phone =json['phone'];
    uId =json['uId'];
    bio =json['bio'];
    image =json['image'];
    cover=json['cover'];
    isEmailVerified =json['isEmailVerified'];

  }

  Map <String,dynamic>? toMap(){
    return {
      'name':name,
      'email':email,
      'phone':phone,
      'uId':uId,
      'bio':bio,
      'image':image,
      'cover': cover,
      'isEmailVerified':isEmailVerified,

    };
  }

}