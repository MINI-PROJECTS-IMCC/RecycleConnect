import "package:flutter/material.dart"; //this imports the material design library of google"
import "package:flutter_application_1/screens/homepage.dart";
import "sign-up.dart";
import "screens/forgot_password.dart";
import "services/api_service.dart";
import "dart:math";
import "package:flutter_application_1/screens/loginpage.dart";
//it conatins Scaffold, AppBar, Text,widget without this nothing works
void main(){
  runApp(MyApp());//Start this as root of App
}
class MyApp extends StatelessWidget{//stateless ui does not change dynamically
  @override
  Widget build(BuildContext context) {//we are overriding Widget class method build to build ui buildcontext conatins widget tree
   return MaterialApp(//Wraps whole App,provides theme,provides routing,provides material(UI) behaviour
    debugShowCheckedModeBanner: false,//removes debug banner
    home:LandingPage(),//home is the first screen shown
   );
  }
}
class LandingPage extends StatefulWidget{
  const LandingPage({super.key});
  @override
  State<LandingPage> createState()=>_LandingPageState();

}
class _LandingPageState extends State<LandingPage>{
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title:Row(children: [
          Text("♻️ RecycleConnect",style:TextStyle(color:Colors.white,fontSize:20))

        ],),
        actions: [
          TextButton.icon(onPressed: (){
            Navigator.push(context
              , MaterialPageRoute(builder:(context)=>LoginPage()));
          }, 
          style:TextButton.styleFrom(backgroundColor: Colors.white,padding: EdgeInsets.all(20)),
          icon: Icon(Icons.login_outlined),label: Text("Login",style:TextStyle(fontSize:15)),)

        ],
      ),
      body:SingleChildScrollView(
        child:LayoutBuilder(builder: (context,constraints)
              {
                  int crossAxisCount=1;
                  if(constraints.maxWidth>=900){
                      crossAxisCount=3;//for laptop
                  }
                  else if(constraints.maxWidth>=600){
                    crossAxisCount=2;//tablet
                  }
                  else {
                     crossAxisCount=1;//mobile
                  }
                  return Column(
                    mainAxisSize: MainAxisSize.min,
      
                    children: [
                      Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Image.asset(
                            "assets/images/sunrise.webp",
                            width: double.infinity,
                            height: 700,
                            fit:BoxFit.cover,
                            color: Colors.white.withOpacity(0.5), // The Tint
                            colorBlendMode: BlendMode.lighten,      // Blending mode
                          ),
                          
                          Text.rich(TextSpan(text:"\tPulse of",style:TextStyle(color:Colors.black,fontSize:60,),children:<TextSpan>[
                            TextSpan(text:"\tNew Earth\n",style:TextStyle(color:const Color.fromARGB(255, 48, 140, 51))),
                            TextSpan(text:"\t\t\tMoving beyond disposal.We orchestrate a high-vibrancy \n\t\tecosystem where material never die -they just begin their \n\t\t\tnext evolution",style:TextStyle(color:Colors.black,fontSize: 20))
                          ]),
                          )
                        ],
                      ),
                      Card(
                        child:Column(
                          children: [
                            Text("The EcoSystem",style:TextStyle(fontSize: 30))
                          ],
                        )


                      )
                    
                    ],
                  );
              }
      )
      )
    );
  }
}

