import "package:flutter/material.dart";

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
    required this.currentIndex,
    this.onHome,
    this.onOpenBin,
    this.onNewRequest,
    this.onTrackRequests,
  });

  final int currentIndex;
  final VoidCallback? onHome;
  final VoidCallback? onOpenBin;
  final VoidCallback? onNewRequest;
  final VoidCallback? onTrackRequests;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Quick Navigate",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home_outlined),
              title: Text("Home"),
              selected: currentIndex == 0,
              onTap: () => _handleTap(context, onHome),
            ),
            ListTile(
              leading: Icon(Icons.delete_outline),
              title: Text("Open Bin"),
              selected: currentIndex == 3,
              onTap: () => _handleTap(context, onOpenBin),
            ),
            ListTile(
              leading: Icon(Icons.add_box_outlined),
              title: Text("New Request"),
              selected: currentIndex == 1,
              onTap: () => _handleTap(context, onNewRequest),
            ),
            ListTile(
              leading: Icon(Icons.list_alt_outlined),
              title: Text("Track my Requests"),
              selected: currentIndex == 2,
              onTap: () => _handleTap(context, onTrackRequests),
            ),
          ],
        ),
      ),
    );
  }

  void _handleTap(BuildContext context, VoidCallback? callback) {
    Navigator.pop(context);
    callback?.call();
  }
}