

class User{

  String id;
  String name;
  String token;

  User.fromJson(Map<String,dynamic> json){
    this.id = json['id'];
    this.token = json['token'];
  }

  Map<String,dynamic> toJson(){
    return {
      'id':this.id,
      'token':this.token
    };
  }

}