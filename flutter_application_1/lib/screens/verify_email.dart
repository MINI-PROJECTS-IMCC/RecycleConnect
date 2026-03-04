import "../services/api_service.dart";
import "package:flutter/material.dart";
class VerifyEmail extends StatefulWidget{
  const VerifyEmail({super.key});//constructor
  @override
  State<VerifyEmail> createState()=>_VerifyEmailPage();

}
class _VerifyEmailPage extends State<VerifyEmail>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body:Container(//whole page
      decoration: BoxDecoration(//for backgorund image
        image:DecorationImage(
          image: AssetImage("assets/images/bg-login.png"),
          fit: BoxFit.cover
          )
      ),
      child:Center(child: Container(//for form of verify mail
      


      ),)
      )
    );
  }
}