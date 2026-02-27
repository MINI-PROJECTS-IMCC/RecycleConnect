import "dart:convert";

import "package:http/http.dart" as http;//to import http request response lib
class ApiService {
  static const base_url="";
  //login api
  static Future<bool> login({required String email,required String password})async{
    try{
      final url=Uri.parse("$base_url/auth.login");

      final response=await http.post(url,headers:{"Content-Type":"application/json"},body:jsonEncode({"email":email,"password":password}))
      .timeout(const Duration(seconds: 15));

      return response.statusCode==200;

    }
    catch(e){
      print("Request time out");
      return false;
    }
    
  }
  //sign-up api
  static Future<bool> signup({required String email,required String username,required String phonenumber,required String password})
  async{
    final url=Uri.parse("$base_url/auth/signup");

    final response=await http.post(url,headers:{"Content-Type":"application/json"},body:jsonEncode({"email":email,"username":username,"phno":phonenumber,"password":password}
    )
    
    ).timeout(const Duration(seconds:15));//request timeout
    return response.statusCode==200;
  }

  
}
