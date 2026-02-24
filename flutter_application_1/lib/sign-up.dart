import "package:flutter/material.dart";
import "services/api_service.dart";
class Signup extends StatefulWidget{
  const Signup({super.key});//
  
  @override
  State<Signup> createState()=>_SignPageState();
}
//this class represents screen or page 
class _SignPageState extends State<Signup>{
  //variable declaration inside this screen
  bool isPasswordVisible=false;
  TextEditingController emailcontoller=TextEditingController();//controller is used to take user input in runtime 
  TextEditingController usernamecontroller=TextEditingController();
  TextEditingController phnocontroller=TextEditingController();
  TextEditingController passwordcontoller1=TextEditingController();
  TextEditingController passwordcontroller2=TextEditingController();
  
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
              child:Column(
                mainAxisSize:MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Center(
                    child:Text("Create Account",style:TextStyle(fontSize: 20)),

                  ),
                  SizedBox(height:15),
                  Text("Enter your Email:",style:TextStyle(fontSize: 15,fontWeight:FontWeight.bold)),
                  SizedBox(height:15),
                  TextField(
                    //to take input
                    controller: emailcontoller,
                    decoration: InputDecoration(labelText: "email",border:OutlineInputBorder()),),
                  SizedBox(height:15),
                  Text("Enter username:",style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                  SizedBox(height:15),
                  TextField(
                    controller:usernamecontroller,
                    decoration: InputDecoration(labelText:"username",border:OutlineInputBorder()),
                  ),
                  SizedBox(height:15),
                  Text("Enter Phone number:",style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                  SizedBox(height:15),
                  TextField(
                    controller:phnocontroller,
                    decoration: InputDecoration(labelText:"phno.",border:OutlineInputBorder())),
                  SizedBox(height:15),
                  Text("Enter Password",style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                  SizedBox(height:15),
                  TextField(
                    keyboardType:TextInputType.visiblePassword,
                    obscureText:!isPasswordVisible,
                    controller:passwordcontoller1,


                    decoration:InputDecoration(
                      labelText: "password",border:OutlineInputBorder(),
                      suffixIcon: IconButton(onPressed: (){
                        setState(() {
                          isPasswordVisible=!isPasswordVisible;
                        });
                        
                      }, icon: Icon(
                        isPasswordVisible?Icons.visibility:Icons.visibility_off
                      )))),
                  SizedBox(height:15),
                  Text("Confirm Password",style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                  SizedBox(height:15),
                  TextField(
                    keyboardType: TextInputType.visiblePassword,
                    obscureText:!isPasswordVisible,
                    controller:passwordcontroller2,
                    decoration:InputDecoration(
                      labelText:"confirm password",
                      border:OutlineInputBorder(),
                      suffixIcon: IconButton(onPressed: (){
                        setState(() {
                          isPasswordVisible=!isPasswordVisible;
                        });
                      },
                      icon: Icon(
                        !isPasswordVisible?Icons.visibility:Icons.visibility_off
                      ),))),
                  SizedBox(height:15),
                  Center(child:SizedBox(
                    width:200,
                    child:ElevatedButton(onPressed: () async{
                      bool success= await ApiService.signup
                      (email: emailcontoller.text, 
                      username: usernamecontroller.text, 
                      phonenumber: phnocontroller.text, 
                      password: passwordcontroller2.text);

                      if(success){
                        print("Account created sucessfully");
                      }
                      else{
                        print("Some error occured");
                      }
                      
                    },
                    child:Text("Create Account"))
                  ))
                  
                ]
              )
            )
          )
      )

    );
  }
}