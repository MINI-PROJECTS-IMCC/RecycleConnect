import "dart:convert";

import "package:http/http.dart" as http;//to import http request response lib
class ApiService {
  static const base_url="http://localhost:8080/api";
  //login api
  static Future<String> login({required String email,required String password,required String role})async{
    try{
      final url=Uri.parse("$base_url/login");

      final response=await http.post(url,headers:{"Content-Type":"application/json"},body:jsonEncode({"email":email,"password":password,"role":role}))
      .timeout(const Duration(seconds: 15));
      if(response.statusCode==200){
        var data=jsonDecode(response.body);
        return data["message"];
      }
      else{
        return "Server error";
      }
    }
    catch(e){
     
      return "Some error occured";
    }
    
  }
  //create Account api
  static Future<String> signup({required String email,required String username,required String phonenumber,required String password})
  async{
    try{
      final url=Uri.parse("$base_url/createAccount");
      final response=await http.post(url,headers:{"Content-Type":"application/json"},body:jsonEncode({"email":email,"name":username,"phone":phonenumber,"password":password}
      )
    
      ).timeout(const Duration(seconds:15));//request timeout
      var data=jsonDecode(response.body);
      return data["message"];
    }
    catch(e)
    {
      return "Some error occured";
    }
  }

  
}
