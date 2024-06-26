class profileModel
{
  String?name,email,profile,number,uid,token,date;

  profileModel({this.name, this.email, this.profile, this.number,this.uid,this.token,this.date});

  factory profileModel.mapToModel(Map m1,String uid)
  {
    return profileModel(profile:m1['profile'] ,number:m1['number'] ,email:m1['email'] ,name:m1['name'] ,uid:uid,token: m1['token'],date: m1['date'] );
  }
}