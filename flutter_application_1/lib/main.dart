import "package:flutter/material.dart";
import "package:flutter_application_1/screens/homepage.dart";
import "sign-up.dart";
import "screens/forgot_password.dart";
import "services/api_service.dart";
import "dart:math";
import "package:flutter_application_1/screens/loginpage.dart";

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return MaterialApp(
    debugShowCheckedModeBanner: false,
    home:LandingPage(),
   );
  }
}

class LandingPage extends StatefulWidget{
  const LandingPage({super.key});
  @override
  State<LandingPage> createState()=>_LandingPageState();
}

class _LandingPageState extends State<LandingPage>{
  @override
  Widget build(BuildContext context){
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 900;
    final isDesktop = screenWidth >= 900;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title:Row(children: [
          Text("♻️ RecycleConnect",style:TextStyle(color:Colors.white,fontSize: isMobile ? 16 : 20))
        ],),
        actions: [
          TextButton.icon(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder:(context)=>LoginPage()));
          }, 
          style:TextButton.styleFrom(backgroundColor: Colors.white,padding: EdgeInsets.all(isMobile ? 10 : 20)),
          icon: Icon(Icons.login_outlined),label: Text("Login",style:TextStyle(fontSize: isMobile ? 12 : 15)),)
        ],
      ),
      body:SingleChildScrollView(
        child:Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Hero Section
            Stack(
              alignment: Alignment.centerLeft,
              children: [
                Image.asset(
                  "assets/images/sunrise.webp",
                  width: double.infinity,
                  height: isMobile ? 400 : (isTablet ? 500 : 700),
                  fit:BoxFit.cover,
                  color: Colors.white.withOpacity(0.5),
                  colorBlendMode: BlendMode.lighten,
                ),
                Padding(
                  padding: EdgeInsets.all(isMobile ? 20 : 40),
                  child: Text.rich(TextSpan(text:isMobile ? "Pulse of" : "\tPulse of",style:TextStyle(color:Colors.black,fontSize: isMobile ? 32 : (isTablet ? 48 : 60),),children:<TextSpan>[
                    TextSpan(text: isMobile ? "\nNew Earth\n" : "\tNew Earth\n",style:TextStyle(color:const Color.fromARGB(255, 48, 140, 51))),
                    TextSpan(text:"Moving beyond disposal.We orchestrate a high-vibrancy ecosystem where material never die -they just begin their next evolution",style:TextStyle(color:Colors.black,fontSize: isMobile ? 14 : (isTablet ? 16 : 20)))
                  ]),
                  )
                )
              ],
            ),
            SizedBox(height:20),
            // Ecosystem Section
            Padding(padding: EdgeInsets.all(isMobile ? 15 : 30),child:
             Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("The Ecosystem",style:TextStyle(fontSize: isMobile ? 32 : (isTablet ? 40 : 50))),
                SizedBox(height: 10),
                Text("A synchronized network designed to turn resource management into premium effortless experience",
                  textAlign: TextAlign.center,
                  style:TextStyle(fontSize: isMobile ? 16 : (isTablet ? 20 : 25))
                ),
                SizedBox(height:15),
                _buildCardsSection(isMobile, isTablet, isDesktop, screenWidth)
              ],
            ))
          ],
        )
      )
    );
  }

  Widget _buildCardsSection(bool isMobile, bool isTablet, bool isDesktop, double screenWidth) {
    double cardHeight = isMobile ? 300 : (isTablet ? 350 : 400);

    return Column(
      children: [
        // On-Demand Pickup & Strategic Partners Row
        if(isMobile)
          Column(
            children: [
              // Mobile: Stack vertically
              SizedBox(
                height: cardHeight,
                width: double.infinity,
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      Ink.image(
                        image: AssetImage("assets/images/pickup.png"),
                        fit: BoxFit.cover,
                        height: cardHeight,
                        width: double.infinity,
                      ),
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Text.rich(TextSpan(text:"🚛\nOn-Demand Pickup\n",style:TextStyle(fontSize: 18),children: [
                          TextSpan(text:"Schedule logistics within a tap. Our truck fleet arrives at your doorstep for surgical material extraction",style:TextStyle(fontSize: 11))
                        ]))
                      )
                    ]
                  )
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: cardHeight,
                width: double.infinity,
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Text.rich(TextSpan(text:"🏢\nStrategic Partners\n",style:TextStyle(fontSize: 18),children: [
                      TextSpan(text:"Connect with vetted global recyclers and Innovative upcycling labs to maximize value",style:TextStyle(fontSize: 11))
                    ]))
                  )
                )
              ),
            ],
          )
        else
          // Tablet & Desktop: Adjacent
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SizedBox(
                  height: cardHeight,
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      alignment: Alignment.topLeft,
                      children: [
                        Ink.image(
                          image: AssetImage("assets/images/pickup.png"),
                          fit: BoxFit.cover,
                          height: cardHeight,
                          width: double.infinity,
                        ),
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Text.rich(TextSpan(text:"🚛\nOn-Demand Pickup\n",style:TextStyle(fontSize: isTablet ? 24 : 32),children: [
                            TextSpan(text:"Schedule logistics within a tap. Our truck fleet arrives at your doorstep for surgical material extraction",style:TextStyle(fontSize: isTablet ? 13 : 16))
                          ]))
                        )
                      ]
                    )
                  ),
                )
              ),
              SizedBox(width: 20),
              Expanded(
                child: SizedBox(
                  height: cardHeight,
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Text.rich(TextSpan(text:"🏢\nStrategic Partners\n",style:TextStyle(fontSize: isTablet ? 24 : 32),children: [
                        TextSpan(text:"Connect with vetted global recyclers and Innovative upcycling labs to maximize value",style:TextStyle(fontSize: isTablet ? 13 : 16))
                      ]))
                    )
                  ),
                )
              ),
            ],
          ),
        
        SizedBox(height:20),
        // Precision Tracking Card
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(isMobile ? 15 : 25),
          decoration: BoxDecoration(
            borderRadius:BorderRadius.circular(20),
            color:Colors.black,
          ),
          child:Column(children: [
            Text("Precision Tracking",style:TextStyle(color:Colors.white,fontSize: isMobile ? 24 : (isTablet ? 32 : 40))),
            SizedBox(height:10),
            Text("Utilize computer vision to identify categorize and value for materials in real-time. Every Atom accounted for.",
              textAlign: TextAlign.center,
              style:TextStyle(fontSize: isMobile ? 14 : (isTablet ? 16 : 20),color:Colors.white),
            )
          ],)
        ),
        
        // Visualize Your Legacy Section
        SizedBox(height: 40),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(isMobile ? 15 : 30),
          color: Colors.grey[200],
          child: Column(
            children: [
              Text("Visualize Your Legacy.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: isMobile ? 24 : (isTablet ? 36 : 48), fontWeight: FontWeight.bold)
              ),
              SizedBox(height: 10),
              Text("Your impact isn't just a number—it's a living, breathing metric of planetary restoration.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: isMobile ? 12 : (isTablet ? 14 : 18), color: Colors.grey[700])
              ),
              SizedBox(height: 30),
              // Stats Cards
              if(isMobile)
                Column(
                  children: [
                    _buildStatCard("842", "KG", "CARBON OFFSET", "Equivalent to planting 14 mature oak trees in a temperate forest ecosystem.", isMobile, isTablet),
                    SizedBox(height: 15),
                    _buildStatCard("2.4", "MWh", "ENERGY RECOVERED", "Enough energy to power a sustainable home for approximately 90 days.", isMobile, isTablet),
                    SizedBox(height: 15),
                    _buildStatCard("15.2", "t", "DIVERTED WASTE", "Critical raw materials redirected from landfill into high-value manufacturing cycles.", isMobile, isTablet),
                  ],
                )
              else
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard("842", "KG", "CARBON OFFSET", "Equivalent to planting 14 mature oak trees in a temperate forest ecosystem.", isMobile, isTablet)
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: _buildStatCard("2.4", "MWh", "ENERGY RECOVERED", "Enough energy to power a sustainable home for approximately 90 days.", isMobile, isTablet)
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: _buildStatCard("15.2", "t", "DIVERTED WASTE", "Critical raw materials redirected from landfill into high-value manufacturing cycles.", isMobile, isTablet)
                    ),
                  ],
                ),
            ],
          )
        ),
        
        // Ready to Archive Section
        SizedBox(height: 40),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(isMobile ? 15 : 30),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 48, 140, 51),
            image: DecorationImage(
              image: AssetImage("assets/images/sunrise.webp"),
              fit: BoxFit.cover,
              opacity: 0.3
            )
          ),
          child: Column(
            children: [
              Text("Ready to Archive?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: isMobile ? 24 : (isTablet ? 36 : 48), fontWeight: FontWeight.bold, color: Colors.white)
              ),
              SizedBox(height: 12),
              Text("Join the thousands of forward-thinking organizations turning environmental responsibility into operational excellence.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: isMobile ? 12 : (isTablet ? 14 : 16), color: Colors.white)
              ),
              SizedBox(height: 20),
              // Buttons
              if(isMobile)
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightGreen,
                          padding: EdgeInsets.symmetric(vertical: 14)
                        ),
                        child: Text("INITIALIZE CYCLE", style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold))
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.white, width: 2),
                          padding: EdgeInsets.symmetric(vertical: 14)
                        ),
                        child: Text("VIEW DEMO", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold))
                      ),
                    )
                  ],
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                        MaterialPageRoute(builder: (context)=>Signup()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightGreen,
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 14)
                      ),
                      child: Text("Sign-Up", style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold))
                    ),
                    
                  ],
                )
            ],
          )
        ),
        SizedBox(height: 40),
      ],
    );
  }

  Widget _buildStatCard(String value, String unit, String label, String description, bool isMobile, bool isTablet) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 15 : 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5, spreadRadius: 2)]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(value, style: TextStyle(fontSize: isMobile ? 32 : 40, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 48, 140, 51))),
              SizedBox(width: 8),
              Text(unit, style: TextStyle(fontSize: isMobile ? 12 : 14, color: Colors.grey[600]))
            ],
          ),
          SizedBox(height: 8),
          Text(label, style: TextStyle(fontSize: isMobile ? 12 : 14, fontWeight: FontWeight.bold, color: Colors.grey[700])),
          SizedBox(height: 8),
          Text(description, style: TextStyle(fontSize: isMobile ? 11 : 13, color: Colors.grey[600]))
        ],
      )
    );
  }
}

