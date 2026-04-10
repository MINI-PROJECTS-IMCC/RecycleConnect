import "package:flutter/material.dart";
import "package:flutter_application_1/services/api_service.dart";
import "package:flutter_application_1/screens/homepage.dart";
import "package:flutter_application_1/sign-up.dart";
import "dart:math";
import "forgot_password.dart";
class LoginPage extends StatefulWidget{
  const LoginPage({super.key});
  //this is class for login page each page separate class
  @override
  State<LoginPage> createState() => _LoginPageState();
  }

  class _LoginPageState extends State<LoginPage>{
    //form object creation
    final GlobalKey<FormState> _formkey=new GlobalKey<FormState>();
    RegExp email_pattern=RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$"); 
    bool isPasswordVisible=true;
    TextEditingController _email=new TextEditingController();
    TextEditingController _password=new TextEditingController();
    String _role="user";
   

    //functions:-
    void login() async{
      String response=await ApiService.login(email:_email.text, password:_password.text,role:_role);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(response)));//it will display dynamically on screen
      if(response=="Login Successfull" && _role=="user"){
        Navigator.push(
          context,
          MaterialPageRoute(builder: 
          (context)=>HomePage())

        );
      }

    }

    Future<void> _submitLogin() async {
      if(_formkey.currentState!.validate()){
        bool success=true;
        if(success){
          Navigator.push(
            context,
            MaterialPageRoute(builder:
            (context)=>HomePage())

          );
          //login();
        }

      }
    }
    Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(//In Scaffold we create Page Structure it is the skeleton
            body:Container(
              
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/bg-login.png"),
                  fit:BoxFit.cover,),
                  ),
              
            child:Center(
            child:Container(//conatiner for form
              width: min(410,screenWidth*0.92),//width calculation
               
             padding:EdgeInsets.all(20),
            decoration: BoxDecoration(
              color:Colors.white,
              borderRadius:BorderRadius.circular(20)

            ),
            child:Form(//Start of form
              
              key:_formkey,
              child:Column(//start of columns
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,//convert row to column and everything starts from begining(left)

                children: <Widget>[
                  Center(child:Text("Welcome to ReycleConnect♻️",style:TextStyle(color:Colors.green,fontWeight:FontWeight.bold,fontSize:25))),
                  
                  SizedBox(height:10),
                  Text("I am a..",style:TextStyle(fontWeight:FontWeight.bold,fontSize: 15)),
                  Row(children:<Widget> [
                    Expanded(child: RadioListTile<String>(value: 'user',
                    title:Text("👤Individual",style:TextStyle(
                      fontSize:13
                    )),
                    groupValue: _role,
                    onChanged: (String? val){
                      if(val!=null){
                        setState(() {
                          _role=val;
                        });
                      }
                    },
                    
                  ),),
                  Expanded(child: RadioListTile<String>(value: 'org',
                    title:Text("🏢 Organization",style:TextStyle(fontSize:13)),
                    groupValue: _role,
                    onChanged: (String? val){
                      if(val!=null){
                        setState(() {
                          _role=val;
                        });
                      }
                    }
                    ))
                   
                  
                  ],),
                  Text("Enter Your registerd Email:-",style:TextStyle(fontWeight: FontWeight.bold,fontSize:15)),
                  SizedBox(height:20),
                  TextFormField(//textField for email
                  controller:_email,
                  decoration: InputDecoration(hintText: "email",border:OutlineInputBorder()),
                  textInputAction: TextInputAction.next,
                  validator: //used for validation
                  (String? value){
                    if(value==null||value.isEmpty){
                      return "Email required";
                    }
                    if(!email_pattern.hasMatch(value)){
                      return "Invalid email";

                    }
                    return null;
                  }
                  ),
                  SizedBox(height:20),
                  Text("Enter Your Password:-",style:TextStyle(fontSize:15,fontWeight: FontWeight.bold)),
                  SizedBox(height:20),
                  TextFormField(
                    controller:_password,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (value){
                      _submitLogin();
                    },

                    keyboardType: TextInputType.visiblePassword,
                    obscureText: isPasswordVisible,
                    decoration: InputDecoration(hintText: "password",border:OutlineInputBorder(),
                    suffixIcon: IconButton(onPressed: (){
                      setState(() {
                        isPasswordVisible=!isPasswordVisible;
                      });
                    }, icon: Icon(isPasswordVisible?Icons.visibility_off:Icons.visibility))
                    
                    ),
                    validator:(String? value){
                      if(value==null||value.isEmpty){
                        return "Enter password";
                      }
                      
                      return null;
                    }
                  ),
                  SizedBox(height:20),
                  Center(child: SizedBox(//button
                    width:200,
                    child:ElevatedButton(onPressed: _submitLogin,child:Text("Login"))

                  )),
                  SizedBox(height:30),
                  Center(child: TextButton(onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder:(context)=>Forgot_password())

                    );
                  }, child: Text("Forgot Password"))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Text("Don't have Account?"),
                    TextButton(onPressed:(){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>Signup()));
                    }, child: Text("create account"))
                  ],),

              ],)
            ),
            )
            
        )
        ),
    );


            
            
     }
  }