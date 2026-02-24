import "package:flutter/material.dart"; //this imports the material design library of google"
import "sign-up.dart";
import "forgot_password.dart";
import "services/api_service.dart";
//it conatins Scaffold, AppBar, Text,widget without this nothing works
void main(){
  runApp(MyApp());//Start this as root of App
}
class MyApp extends StatelessWidget{//stateless ui does not change dynamically
  @override
  Widget build(BuildContext context) {//we are overriding Widget class method build to build ui buildcontext conatins widget tree
   return MaterialApp(//Wraps whole App,provides theme,provides routing,provides material(UI) behaviour
    debugShowCheckedModeBanner: false,//removes debug banner
    home:LoginPage(),//home is the first screen shown
   );
  }
}
class LoginPage extends StatefulWidget{
  const LoginPage({super.key});
  //this is class for login page each page separate class
  @override
  State<LoginPage> createState() => _LoginPageState();
  }

  class _LoginPageState extends State<LoginPage>{
    bool isPasswordVisible=false;
    TextEditingController email=new TextEditingController();
    TextEditingController password=new TextEditingController();
     Widget build(BuildContext context) {
    return Scaffold(//In Scaffold we create Page Structure
            body:Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/bg-login.png"),
                  fit:BoxFit.cover,),
                  ),
              
            child:Center(
            child:Container(//Container is a box that can contain other widgets and apply styling and layout control
            width:400,
            padding:EdgeInsets.all(20),//padding inside container
            decoration:BoxDecoration(//decoration is used for styling
              color:Colors.white,//background color of container
              borderRadius:BorderRadius.circular(10),//rounded corners
            ),
            child:Column(//Column arranges children vertically
              mainAxisSize:MainAxisSize.min,//size of column is as big as its children
              crossAxisAlignment: CrossAxisAlignment.start,//by default set to left
              children:[//it will conatin all widgets
                Center(//centers content horizontally and vertically
                child:Text("Welcome to RecycleConnect",style:TextStyle(fontSize:25,fontWeight:FontWeight.bold,color:Colors.lightGreen))),//this is text widget to show text
                SizedBox(height:20),
                Text("Enter Your Email:",style:TextStyle(fontSize:15,fontWeight:FontWeight.bold)),//this is used to add space between widgets
                SizedBox(height:15),
                TextField(decoration:InputDecoration(labelText:"Email",border:OutlineInputBorder())),//this is text field for user input
                SizedBox(height:15),
                Text("Enter Your Password:",style:TextStyle(fontSize:15,fontWeight:FontWeight.bold)),
                SizedBox(height:15),
                TextField(
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: !isPasswordVisible,
                  
                  //hides password with dots
                  
                  decoration: InputDecoration(labelText:"Password",
                  border:OutlineInputBorder(),
                  //to create an icon in passwoprd
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isPasswordVisible=!isPasswordVisible;
                      });
                    }, 
                    icon: Icon(
                      isPasswordVisible?Icons.visibility:Icons.visibility_off
                    ))),
                  
                ),
                SizedBox(height:15),
                Center(child:SizedBox(
                  width:200,
                  child:ElevatedButton(onPressed:() async{
                    bool success=await ApiService.login(email: email.text, password: password.text);
                    if(success){
                      print("login success full");

                    }
                    else{
                      print("login unsuccessfull");
                    }
                  },
                  child: Text("Login"))
                )),
                SizedBox(height:15),
                Center(child:
                  TextButton(onPressed:(){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>const Forgot_password()),);
                  },
                  child:Text("forgot password")),

                ),
                Center(child:Row(
                  children: [
                    SizedBox(width: 80),
                    Text("Don't have account ?"),
                    TextButton(onPressed:(){
                      //to redirect to second page
                      Navigator.push(context,
                      MaterialPageRoute(builder: (context)=>const Signup()),
                      );
                    },
                    child:Text("create account"),)
                  ],
                )
                )
                
                
              ]
            )
          )
        )
        ),
    );
     }
  }