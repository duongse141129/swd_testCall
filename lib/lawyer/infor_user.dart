import 'package:advisories_lawyer/provider/google_sign_in.dart';

class InforUser{
  static Users? _userInfor;
  InforUser();

  Users? getUserInfo() {
    return _userInfor;
  }



  void setUserInfo(Users upUser) {_userInfor = upUser;}

  @override
  String toString() {
    return _userInfor!.id.toString() +" "+ _userInfor!.name;
  }
  
  static int getIdUser(){
      return _userInfor!.id;
  }
  static String getNameUser(){
      return _userInfor!.name;
  }
  static String getRoleUser(){
      return _userInfor!.role;
  }

}