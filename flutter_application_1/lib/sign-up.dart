import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_application_1/screens/verify_email.dart";
import "services/api_service.dart";
class Signup extends StatefulWidget{
  const Signup({super.key});//
  
  @override
  State<Signup> createState()=>_SignPageState();
}
//this class represents screen or page 
class _SignPageState extends State<Signup>{
  //variable declaration inside this screen
   final GlobalKey<FormState> _formkey=new GlobalKey<FormState>();
  bool isPasswordVisible1=true;
  bool isPasswordVisible2=true;
  TextEditingController emailcontoller=TextEditingController();//controller is used to take user input in runtime 
  TextEditingController usernamecontroller=TextEditingController();
  TextEditingController phnocontroller=TextEditingController();
  TextEditingController passwordcontoller1=TextEditingController();
  TextEditingController passwordcontroller2=TextEditingController();
  RegExp email_pattern=RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body:Container(
        decoration: BoxDecoration(
          image:DecorationImage(
            image: AssetImage("assets/images/bg-login.png"),
            fit:BoxFit.cover,
          ),
          ),
          child:Center(
            child:Container(
               width:400,
               padding:EdgeInsets.all(20),
              decoration: BoxDecoration(
                color:Colors.white,
                borderRadius: BorderRadius.circular(20),
               

              ),
              child:Form(
                key:_formkey,
               
                child:Column(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(child: Text("Welcome",style:TextStyle(fontSize:20,fontWeight:FontWeight.bold))),
                    SizedBox(height:15),
                    Center(child:Text("Create Your Account",style:TextStyle(fontSize:20,fontWeight:FontWeight.bold))),
                    SizedBox(height:15),
                    Text("Enter your Email:-"),
                    SizedBox(height:15),
                    TextFormField(
                      controller:emailcontoller,
                      decoration: InputDecoration(hintText: "email",border:OutlineInputBorder()),
                      validator:(String? value){
                        if(value==null||value.isEmpty){
                          return "email is required*";
                        }
                        if(!email_pattern.hasMatch(value)){
                          return "Invalid email";
                        }
                        return null;
                      }
                    ),
                    SizedBox(height:20),
                    Text("Enter your Name:-"),
                    SizedBox(height:15),
                    TextFormField(
                      decoration:InputDecoration(hintText:"username",border:OutlineInputBorder()),
                      validator:(String? value){
                        if(value==null||value.isEmpty){
                          return "username is mandatory*";
                        }
                        return null;

                      }

                    ),
                    SizedBox(height:20),
                    Text("Enter Your Phone Number:-"),
                    SizedBox(height:15),
                    TextFormField(
                      controller:phnocontroller,
                      decoration: InputDecoration(hintText: "phone number",border:OutlineInputBorder()),
                      validator:(String? value){
                        if(value==null||value.isEmpty){
                          return "Phone number is mandatory*";
                        }
                        if(value.length<10||value.length>11){
                          return "Invalid Phone Number";
                        }
                        return null;
                      }
                    ),
                    SizedBox(height:20),
                    Text("Create Password:-"),
                    SizedBox(height:15),
                    TextFormField(
                       controller:passwordcontoller1,
                       keyboardType: TextInputType.visiblePassword,
                       obscureText: isPasswordVisible1,
                      decoration: InputDecoration(hintText:"password",border:OutlineInputBorder(),
                      suffixIcon: IconButton(onPressed:(){
                        setState(() {
                          isPasswordVisible1=!isPasswordVisible1;
                        });
                      }, icon: Icon(isPasswordVisible1?Icons.visibility_off:Icons.visibility)),
                      
                      
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,//for auto validating
                      validator:(String? value){
                        if(value==null||value.isEmpty){
                          return "password is mandatory*";
                        }
                        if(value.length<8){
                          return "Password must contain at least 8 characters";
                        }
                        if(!RegExp(r'[A-Z]').hasMatch(value)){
                          return "Must conatin at least one upper case letter";
                        }
                        if(!RegExp(r'[0-9]').hasMatch(value)){
                          return "Must conatin at least one digit";
                        }
                        if(!RegExp(r'[a-z]').hasMatch(value)){
                          return "Must conatin at least one lower case letter";
                        }
                        if(!RegExp(r'[!@#$%^&*+-,.?<>;:{}|]').hasMatch(value)){
                          return "Must contain at least one special character";
                        }
                        return null;
                      }

                    ),
                    SizedBox(height:20),
                    Text("Confirm Password:-"),
                    SizedBox(height:15),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller:passwordcontroller2,
                      obscureText:isPasswordVisible2,
                      decoration: InputDecoration(hintText:"confirm password",border:OutlineInputBorder(),
                      suffixIcon: IconButton(onPressed: (){
                        setState(() {
                          isPasswordVisible2=!isPasswordVisible2;
                        });
                      }, icon: Icon(isPasswordVisible2?Icons.visibility_off:Icons.visibility))
                      
                      ),
                      validator:(String? value){
                        if(value==null||value.isEmpty){
                          return "confirm password is mandatory*";
                        }
                        if(passwordcontoller1.text!=passwordcontroller2.text){
                          return "password does not match!";
                        }
                        return null;

                      }
                    ),
                    SizedBox(height:20),
                    Center(child:  SizedBox(
                      width:200,
                      child:ElevatedButton(onPressed: () async{
                        
                        if(_formkey.currentState!.validate()){
                        //String response=await ApiService.signup(email: emailcontoller.text, username: usernamecontroller.text, phonenumber: phnocontroller.text, password: passwordcontoller1.text);
                        /*
                          if(response.isNotEmpty){
                           Navigator.push(context,
                          MaterialPageRoute(builder:
                          (context)=>VerifyEmail()));
                        }
                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(response)));
                        
                        */ 
                        bool success=true;
                        if(success){
                           Navigator.push(context,
                          MaterialPageRoute(builder:
                          (context)=>VerifyEmail()));
                        }
                        else{
                          print("Issue Occured");
                        }
                        }

                        
                      },child:Text("Create Account"))

                    ))
                ],)
              )
      )
      )
    )
    );
  }
}