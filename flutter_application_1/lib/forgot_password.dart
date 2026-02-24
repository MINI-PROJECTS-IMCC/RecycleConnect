import "package:flutter/material.dart";
class Forgot_password extends StatelessWidget{
 
    const Forgot_password({super.key});
    @override
    Widget build(BuildContext context){
      return Scaffold(
        body:Container(
          decoration: BoxDecoration(
            image:DecorationImage(
              image: AssetImage("assets/images/bg-login.png"),
              fit:BoxFit.cover)
          ),
          child:Center(
            child: Container(
              width: 400,
              padding:EdgeInsets.all(20),
              decoration: BoxDecoration(
                color:Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child:Column(

                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Center(child: Text("Enter your email address ",style:TextStyle(fontSize: 15,fontWeight:FontWeight.bold))),
                  SizedBox(height:20),
                  TextField(decoration:InputDecoration(labelText:"email",border:OutlineInputBorder())),
                  SizedBox(height:20),
                  Center(
                    child:SizedBox(
                      width:200,
                      child:ElevatedButton(onPressed: (){
                        print("forogoot password pressed");
                      },
                      child:Text("Send"))
                    ) ,)
               
              ],)
            ))
        )


      );
    }
  }
