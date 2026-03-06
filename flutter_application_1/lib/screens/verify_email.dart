import "../services/api_service.dart";
import "package:flutter/material.dart";
class VerifyEmail extends StatefulWidget{
  const VerifyEmail({super.key});//constructor
  @override
  State<VerifyEmail> createState()=>_VerifyEmailPage();

}
class _VerifyEmailPage extends State<VerifyEmail>{
  final GlobalKey<FormState> _formkey=new GlobalKey<FormState>();
  TextEditingController verify_code=new TextEditingController();
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
      width:double.infinity,
      padding:EdgeInsets.all(20),
      decoration:BoxDecoration(
        color:Colors.white,
        borderRadius:BorderRadius.circular(20)
      ),
      child:Form(
        key:_formkey,
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children:[
            Text("Enter the verification code send to your email:-",style:TextStyle(fontSize:20,fontWeight:FontWeight.bold)),
            SizedBox(height:20),
            TextFormField(
              decoration:InputDecoration(
                hintText: "verification code",
                border:OutlineInputBorder()
              ),
              controller:verify_code,
              validator:(String? value){
                if(value==null||value.isEmpty)
                {
                  return "Please enter verification code";
                }
                return null;
              }


            ),
            SizedBox(height:20),
            Center(child:  SizedBox(
              width:200,
              child:ElevatedButton(onPressed: (){
                if(_formkey.currentState!.validate()){
                  print("verification code done");
                }

              },
              child:Text("Submit"))
            ))
           

          ]
        )
      
      )


      ),
      )
      )
    );
  }
}