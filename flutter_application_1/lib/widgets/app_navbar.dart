import "package:flutter/material.dart";
import "package:flutter_application_1/screens/loginpage.dart";

class AppNavbar extends StatelessWidget implements PreferredSizeWidget {
  const AppNavbar({
    super.key,
    required this.isMobile,
    required this.selectedIndex,
    required this.onTabSelected,
    this.title = "♻️ Recycle Connect.in",
    this.tabs = const ["Dashboard", "Request", "Organizations", "Impact"],
    this.showAboutButton = true,
    this.onAboutPressed,
  });

  final bool isMobile;
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;
  final String title;
  final List<String> tabs;
  final bool showAboutButton;
  final VoidCallback? onAboutPressed;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      elevation: 0,
      title: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: isMobile ? 16 : 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (!isMobile) ...[
            SizedBox(width: 40),
            Expanded(
              child: Row(
                children: List.generate(
                  tabs.length,
                  (index) => TextButton(
                    onPressed: () => onTabSelected(index),
                    child: Text(
                      tabs[index],
                      style: TextStyle(
                        color: selectedIndex == index ? Colors.white : Colors.white70,
                        fontSize: 16,
                        fontWeight: selectedIndex == index ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
      actions: [
        if (!isMobile && showAboutButton)
          TextButton(
            onPressed: onAboutPressed ?? () {},
            child: Text(
              "About❔",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        SizedBox(width: 10),
        if (!isMobile && showAboutButton)
          TextButton(
            onPressed: onAboutPressed ?? (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginPage()));
            },
            child: Text(
              "Logout ",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
             
            ),
            
          ),
         
        SizedBox(width: 10),
      ],
    );
  }
}