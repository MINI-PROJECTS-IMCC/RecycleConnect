import "package:flutter/material.dart";
import "package:flutter_application_1/screens/impact_tab.dart";
import "package:flutter_application_1/screens/new_request_page.dart";
import "package:flutter_application_1/screens/organizations_tab.dart";
import "package:flutter_application_1/screens/recycling_bin_page.dart";
import "package:flutter_application_1/screens/requests_tab.dart";
import "package:flutter_application_1/widgets/app_drawer.dart";
import "package:flutter_application_1/widgets/app_navbar.dart";

class HomePage extends StatefulWidget{
    const HomePage({super.key, this.initialTabIndex = 0});

    final int initialTabIndex;

    @override
    State<HomePage> createState()=>_Home();
}

class _Home extends State<HomePage>{
    late int _selectedTabIndex;

    @override
    void initState() {
        super.initState();
        _selectedTabIndex = widget.initialTabIndex;
    }
    
    @override
    Widget build(BuildContext context){
        double screenWidth = MediaQuery.of(context).size.width;
        bool isMobile = screenWidth < 600;
        bool isTablet = screenWidth >= 600 && screenWidth < 900;
        bool isDesktop = screenWidth >= 900;
        
        return Scaffold(
            backgroundColor: Color(0xFFF3F6F4),
            appBar: AppNavbar(
                isMobile: isMobile,
                selectedIndex: _selectedTabIndex,
                onTabSelected: (index) {
                    setState(() {
                        _selectedTabIndex = index;
                    });
                },
            ),
            drawer: AppDrawer(
                currentIndex: _selectedTabIndex == 1 ? 2 : 0,
                onHome: () {
                    setState(() {
                        _selectedTabIndex = 0;
                    });
                },
                onOpenBin: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const RecyclingBinPage()),
                    );
                },
                onNewRequest: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const NewRequestPage()),
                    );
                },
                onTrackRequests: () {
                    setState(() {
                        _selectedTabIndex = 1;
                    });
                },
            ),
            body: SingleChildScrollView(
                padding: EdgeInsets.all(isMobile ? 16 : isTablet ? 24 : 32),
                child: LayoutBuilder(
                    builder: (context, constraints) {
                        int crossAxisCount = 1;
                        if (constraints.maxWidth >= 900) {
                            crossAxisCount = 3;
                        } else if (constraints.maxWidth >= 600) {
                            crossAxisCount = 2;
                        } else {
                            crossAxisCount = 1;
                        }
                        
                        return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                if (_selectedTabIndex != 0) ...[
                                    _buildPageHeader(isMobile, isTablet),
                                    SizedBox(height: 16),
                                ],
                                
                                // Page Content based on selected tab
                                ..._buildTabContent(isMobile, isTablet, isDesktop, crossAxisCount),
                            ],
                        );
                    }
                ),
            )
        );
    }
    
    String _getPageTitle() {
        switch (_selectedTabIndex) {
            case 0:
                return "Hello, Vallabh 👋";
            case 1:
                return "My Requests 📋";
            case 2:
                return "Organizations 🏢";
            case 3:
                return "My Impact 🌍";
            default:
                return "Dashboard";
        }
    }

    Widget _buildPageHeader(bool isMobile, bool isTablet) {
        final Widget title = Text(
            _getPageTitle(),
            style: TextStyle(
                fontSize: isMobile ? 28 : isTablet ? 36 : 42,
                fontWeight: FontWeight.bold,
                color: Colors.green,
            ),
        );

        if (_selectedTabIndex != 1) {
            return title;
        }

        final Widget button = ElevatedButton.icon(
            onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const NewRequestPage()),
                );
            },
            icon: Icon(Icons.add, size: 18),
            label: Text("New Request"),
            style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1F7A45),
                foregroundColor: Colors.white,
                shape: StadiumBorder(),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
        );

        if (isMobile) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    title,
                    SizedBox(height: 12),
                    button,
                ],
            );
        }

        return Row(
            children: [
                Expanded(child: title),
                button,
            ],
        );
    }
    
    List<Widget> _buildTabContent(bool isMobile, bool isTablet, bool isDesktop, int crossAxisCount) {
        switch (_selectedTabIndex) {
            case 0:
                return _buildDashboard(isMobile, isTablet, isDesktop);
            case 1:
                return [
                    RequestsTab(isMobile: isMobile),
                ];
            case 2:
                return [
                    OrganizationsTab(isMobile: isMobile),
                ];
            case 3:
                return [
                    ImpactTab(isMobile: isMobile),
                ];
            default:
                return _buildDashboard(isMobile, isTablet, isDesktop);
        }
    }
    
    List<Widget> _buildDashboard(bool isMobile, bool isTablet, bool isDesktop) {
        final bool isCompact = isMobile || isTablet;

        return [
            _buildDashboardHeader(isCompact),
            SizedBox(height: isCompact ? 18 : 24),
            if (isCompact) ...[
                _buildMilestoneCard(),
                SizedBox(height: 14),
                _buildCommunityImpactCard(),
                SizedBox(height: 14),
                _buildRecentActivityPanel(),
                SizedBox(height: 14),
                _buildEducationPanel(),
            ] else ...[
                Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Expanded(
                            flex: 1,
                            child: _buildMilestoneCard(),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                            flex: 2,
                            child: _buildCommunityImpactCard(),
                        ),
                    ],
                ),
                SizedBox(height: 16),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Expanded(
                            flex: 5,
                            child: _buildRecentActivityPanel(),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                            flex: 6,
                            child: _buildEducationPanel(),
                        ),
                    ],
                ),
            ],
            
        ];
    }

    Widget _buildDashboardHeader(bool isCompact) {
        final Widget actionRow = Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
                OutlinedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.file_download_outlined, size: 16),
                    label: Text("Export Report"),
                    style: OutlinedButton.styleFrom(
                        foregroundColor: Color(0xFF4C5B55),
                        side: BorderSide(color: Color(0xFFD5DFD9)),
                        shape: StadiumBorder(),
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                ),
                ElevatedButton.icon(
                    onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const NewRequestPage()),
                        );
                    },
                    icon: Icon(Icons.add, size: 18),
                    label: Text("New Request"),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF1F7A45),
                        foregroundColor: Colors.white,
                        shape: StadiumBorder(),
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                ),
            ],
        );

        if (isCompact) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Text(
                        "SUSTAINABILITY PROFILE",
                        style: TextStyle(
                            fontSize: 11,
                            letterSpacing: 1.1,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF7D8A84),
                        ),
                    ),
                    SizedBox(height: 8),
                    Text(
                        "Hello, Vallabh.",
                        style: TextStyle(
                            fontSize: 32,
                            height: 1.1,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF24312C),
                        ),
                    ),
                    SizedBox(height: 10),
                    Text(
                        "Your contributions this month have saved approximately 14kg of carbon emissions. Keep going.",
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF5F6D67),
                            height: 1.35,
                        ),
                    ),
                    SizedBox(height: 14),
                    actionRow,
                ],
            );
        }

        return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Text(
                                "SUSTAINABILITY PROFILE",
                                style: TextStyle(
                                    fontSize: 11,
                                    letterSpacing: 1.1,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF7D8A84),
                                ),
                            ),
                            SizedBox(height: 8),
                            Text(
                                "Hello, Vallabh.",
                                style: TextStyle(
                                    fontSize: 54,
                                    height: 1,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF24312C),
                                ),
                            ),
                            SizedBox(height: 10),
                            Text(
                                "Your contributions this month have saved approximately 14kg of carbon emissions. Keep going.",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF5F6D67),
                                    height: 1.4,
                                ),
                            ),
                        ],
                    ),
                ),
                SizedBox(width: 20),
                actionRow,
            ],
        );
    }

    Widget _buildMilestoneCard() {
        return Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                            Text(
                                "Monthly Milestone",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF2B3934),
                                ),
                            ),
                            CircleAvatar(
                                radius: 13,
                                backgroundColor: Color(0xFFE8F3EC),
                                child: Icon(Icons.eco, size: 14, color: Color(0xFF2A8A4F)),
                            ),
                        ],
                    ),
                    SizedBox(height: 18),
                    Center(
                        child: Stack(
                            alignment: Alignment.center,
                            children: [
                                SizedBox(
                                    width: 124,
                                    height: 124,
                                    child: CircularProgressIndicator(
                                        value: 0.75,
                                        strokeWidth: 9,
                                        color: Color(0xFF14863F),
                                        backgroundColor: Color(0xFFDFE8E2),
                                    ),
                                ),
                                Column(
                                    children: [
                                        Text(
                                            "75%",
                                            style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.w800,
                                                color: Color(0xFF25332E),
                                            ),
                                        ),
                                        Text(
                                            "COMPLETE",
                                            style: TextStyle(
                                                fontSize: 11,
                                                letterSpacing: 1,
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xFF798680),
                                            ),
                                        ),
                                    ],
                                ),
                            ],
                        ),
                    ),
                    SizedBox(height: 16),
                    Text(
                        "You are 12kg away from reaching your Green Tier status.",
                        style: TextStyle(
                            fontSize: 12,
                            height: 1.35,
                            color: Color(0xFF5E6C66),
                        ),
                    ),
                ],
            ),
        );
    }

    Widget _buildCommunityImpactCard() {
        return Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Color(0xFFEFF4F1),
                borderRadius: BorderRadius.circular(24),
            ),
            child: LayoutBuilder(
                builder: (context, constraints) {
                    final double maxWidth = constraints.maxWidth;
                    final int columnCount = maxWidth > 760 ? 3 : maxWidth > 470 ? 2 : 1;
                    final double tileWidth = (maxWidth - ((columnCount - 1) * 12)) / columnCount;

                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Wrap(
                                spacing: 12,
                                runSpacing: 10,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                    Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                            Text(
                                                "Community Impact",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w700,
                                                    color: Color(0xFF2A3833),
                                                ),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                                "Environmental savings from your network this week.",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xFF6E7C76),
                                                ),
                                            ),
                                        ],
                                    ),
                                    Container(
                                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(14),
                                        ),
                                        child: Text(
                                            "Live Stats",
                                            style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF50605A),
                                            ),
                                        ),
                                    ),
                                ],
                            ),
                            SizedBox(height: 16),
                            Wrap(
                                spacing: 12,
                                runSpacing: 12,
                                children: [
                                    _buildMetricTile("1,240L", "WATER SAVED", Icons.water_drop, Color(0xFF1B7C46), tileWidth),
                                    _buildMetricTile("412kWh", "ENERGY OFFSET", Icons.electric_bolt, Color(0xFF2AA748), tileWidth),
                                    _buildMetricTile("82kg", "CO2 ABSORBED", Icons.forest, Color(0xFF3E9C65), tileWidth),
                                ],
                            ),
                        ],
                    );
                },
            ),
        );
    }

    Widget _buildMetricTile(String value, String label, IconData icon, Color accent, double width) {
        return Container(
            width: width,
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    CircleAvatar(
                        radius: 10,
                        backgroundColor: accent.withOpacity(0.12),
                        child: Icon(icon, size: 12, color: accent),
                    ),
                    SizedBox(height: 10),
                    Text(
                        value,
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF2C3934),
                            height: 0.95,
                        ),
                    ),
                    SizedBox(height: 6),
                    Text(
                        label,
                        style: TextStyle(
                            fontSize: 10,
                            letterSpacing: 0.8,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF7B8983),
                        ),
                    ),
                ],
            ),
        );
    }

    Widget _buildRecentActivityPanel() {
        return Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                            Text(
                                "Recent Activity",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF2A3833),
                                ),
                            ),
                            Text(
                                "View All",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF608073),
                                ),
                            ),
                        ],
                    ),
                    SizedBox(height: 14),
                    _buildActivityRow("Cardboard & Paper Pickup", "Dec 11, 2025 | 4.2kg", "COMPLETED", Color(0xFF1D8A4E)),
                    SizedBox(height: 12),
                    _buildActivityRow("Plastic Bottle Batch", "Dec 10, 2025 | 1.8kg", "IN TRANSIT", Color(0xFFD9962B)),
                    SizedBox(height: 12),
                    _buildActivityRow("E-Waste Collection", "Dec 09, 2025 | 5.9kg", "COMPLETED", Color(0xFF1D8A4E)),
                ],
            ),
        );
    }

    Widget _buildActivityRow(String title, String subtitle, String status, Color color) {
        return Row(
            children: [
                CircleAvatar(
                    radius: 14,
                    backgroundColor: Color(0xFFF1F5F2),
                    child: Icon(Icons.recycling_outlined, size: 15, color: Color(0xFF5C6D66)),
                ),
                SizedBox(width: 10),
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Text(
                                title,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF30403A),
                                ),
                            ),
                            SizedBox(height: 3),
                            Text(
                                subtitle,
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFF7A8882),
                                ),
                            ),
                        ],
                    ),
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: color.withOpacity(0.14),
                        borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                        status,
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: color,
                        ),
                    ),
                ),
            ],
        );
    }

    Widget _buildEducationPanel() {
        return Container(
            height: 250,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                        Color(0xFF2E6D3F),
                        Color(0xFF214D31),
                    ],
                ),
            ),
            child: Stack(
                children: [
                    Positioned(
                        top: -24,
                        right: -20,
                        child: CircleAvatar(
                            radius: 58,
                            backgroundColor: Color(0x3DD2F26A),
                        ),
                    ),
                    Positioned(
                        top: 20,
                        right: 34,
                        child: Icon(Icons.local_florist, color: Color(0xB9E8FFAE), size: 58),
                    ),

                    
                    //auto updated facts
                    Padding(
                        padding: EdgeInsets.all(22),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                                Text(
                                    "EDUCATION HUB",
                                    style: TextStyle(
                                        color: Color(0xFFCAE5D3),
                                        letterSpacing: 1,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                    ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                    "Mastering Local Circularity",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 28,
                                        fontWeight: FontWeight.w700,
                                        height: 1.1,
                                    ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                    "Learn how to maximize your impact by pre-sorting your household waste.",
                                    style: TextStyle(
                                        color: Color(0xFFCDE0D3),
                                        fontSize: 13,
                                        height: 1.3,
                                    ),
                                ),
                                SizedBox(height: 14),
                                FilledButton(
                                    onPressed: () {},
                                    style: FilledButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: Color(0xFF265138),
                                        shape: StadiumBorder(),
                                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                    ),
                                    child: Text(
                                        "Read More",
                                        style: TextStyle(fontWeight: FontWeight.w700),
                                    ),
                                ),
                            ],
                        ),
                    ),
                ],
            ),
        );
    }

   
    
    
    
    Widget _buildStatCard(String title, String value, IconData icon, Color color, bool isMobile) {
        return Card(
            elevation: 2,
            child: Container(
                width: isMobile ? double.infinity : 140,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8)
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Icon(icon, color: color, size: 28),
                        SizedBox(height: 12),
                        Text(
                            title,
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600]
                            ),
                        ),
                        SizedBox(height: 8),
                        Text(
                            value,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: color
                            ),
                        ),
                    ],
                ),
            ),
        );
    }
    
    Widget _buildActivityCard(String title, String time) {
        return Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8)
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Text(
                                    title,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14
                                    ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                    time,
                                    style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 12
                                    ),
                                ),
                            ],
                        ),
                    ),
                    Icon(Icons.check_circle, color: Colors.green),
                ],
            ),
        );
    }
    
    
       
    }