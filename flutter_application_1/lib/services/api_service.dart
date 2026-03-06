import "dart:convert";

import "package:http/http.dart" as http;//to import http request response lib
class ApiService {
  static const base_url="";
  //login api
  static Future<String> login({required String email,required String password})async{
    try{
      final url=Uri.parse("$base_url/login");

      final response=await http.post(url,headers:{"Content-Type":"application/json"},body:jsonEncode({"email":email,"password":password}))
      .timeout(const Duration(seconds: 15));
      var data=jsonDecode(response.body);


      return data["message"];

    }
    catch(e){
      print("Request time out");
      return "Some error occured";
    }
    
  }
  //create Account api
  static Future<String> signup({required String email,required String username,required String phonenumber,required String password})
  async{
    final url=Uri.parse("$base_url/createaccount");

    final response=await http.post(url,headers:{"Content-Type":"application/json"},body:jsonEncode({"email":email,"name":username,"phone":phonenumber,"password":password}
    )
    
    ).timeout(const Duration(seconds:15));//request timeout
    var data=jsonDecode(response.body);
    return data["message"];
  }

  
}
