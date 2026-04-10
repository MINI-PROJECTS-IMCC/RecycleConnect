import "package:flutter/material.dart";
import "package:flutter_application_1/models/bin_entry.dart";
import "package:flutter_application_1/screens/homepage.dart";
import "package:flutter_application_1/screens/recycling_bin_page.dart";
import "package:flutter_application_1/screens/request_confirmation_page.dart";
import "package:flutter_application_1/services/bin_cookie_service.dart";
import "package:flutter_application_1/widgets/app_drawer.dart";
import "package:flutter_application_1/widgets/app_navbar.dart";

class OrganizationPricesPage extends StatefulWidget {
  const OrganizationPricesPage({
    super.key,
    required this.highlightedPartner,
  });

  final String highlightedPartner;

  @override
  State<OrganizationPricesPage> createState() => _OrganizationPricesPageState();
}

class _OrganizationPricesPageState extends State<OrganizationPricesPage> {
  late List<BinEntry> _requestEntries;

  @override
  void initState() {
    super.initState();
    _requestEntries = BinCookieService.loadEntries();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 720;
    final bool stackPanels = width < 1040;
    final bool hasRequests = _requestEntries.isNotEmpty;

    final _OrganizationProfile profile = _OrganizationProfile(
      name: widget.highlightedPartner,
      location: "Portland, Oregon",
      certification: "Certified Eco-Hub",
      about:
          "${widget.highlightedPartner} is at the forefront of the circular economy. Our mission is to transform urban waste into premium raw materials through high-efficiency biological and mechanical processing. We do not just recycle; we pulse life back into discarded resources.",
      heroImage: "assets/images/pickup.png",
      materials: const [
        _MaterialRate(
          title: "Aluminum Cans",
          description: "L1/L2 grade, clean and crushed preferred.",
          price: "0.45",
          unit: "/lb",
          impact: "+150 Impact",
          highDemand: true,
          icon: Icons.recycling,
        ),
        _MaterialRate(
          title: "PET Plastics",
          description: "Clear and light-blue bottles. Caps removed.",
          price: "1.10",
          unit: "/kg",
          impact: "+85 Impact",
          icon: Icons.water_drop_outlined,
        ),
        _MaterialRate(
          title: "Cardboard",
          description: "Corrugated only, must be dry and flat.",
          price: "0.12",
          unit: "/lb",
          impact: "+40 Impact",
          icon: Icons.inventory_2_outlined,
        ),
        _MaterialRate(
          title: "Mixed Paper",
          description: "Office paper, magazines, minimal staples.",
          price: "0.08",
          unit: "/lb",
          impact: "+25 Impact",
          icon: Icons.description_outlined,
        ),
      ],
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF3F6F4),
      appBar: AppNavbar(
        isMobile: width < 700,
        selectedIndex: 2,
        onTabSelected: (index) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => HomePage(initialTabIndex: index),
            ),
          );
        },
      ),
      drawer: AppDrawer(
        currentIndex: 0,
        onHome: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const HomePage(initialTabIndex: 0),
            ),
          );
        },
        onOpenBin: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const RecyclingBinPage()),
          );
        },
        onNewRequest: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const HomePage(initialTabIndex: 1),
            ),
          );
        },
        onTrackRequests: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const HomePage(initialTabIndex: 1),
            ),
          );
        },
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isMobile ? 14 : 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(profile, stackPanels, hasRequests),
            const SizedBox(height: 18),
            if (stackPanels) ...[
              _buildMaterialsSection(profile, isMobile),
              const SizedBox(height: 14),
              _buildStatsPanel(),
              const SizedBox(height: 14),
              _buildPartnerCard(),
            ] else ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 10, child: _buildMaterialsSection(profile, isMobile)),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        _buildStatsPanel(),
                        const SizedBox(height: 14),
                        _buildPartnerCard(),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(_OrganizationProfile profile, bool stackPanels, bool hasRequests) {
    final Widget left = Expanded(
      flex: 9,
      child: Padding(
        padding: EdgeInsets.only(right: stackPanels ? 0 : 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: const Color(0xFF1E7A49),
                  child: Icon(Icons.eco, color: const Color(0xFFD8F9E7), size: 18),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    profile.name,
                    style: const TextStyle(
                      fontSize: 42,
                      height: 0.95,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF216C45),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on_outlined, size: 14, color: Color(0xFF7D8C86)),
                const SizedBox(width: 4),
                Text(
                  profile.location,
                  style: const TextStyle(fontSize: 12, color: Color(0xFF7D8C86)),
                ),
                const SizedBox(width: 8),
                Text(
                  "• ${profile.certification}",
                  style: const TextStyle(fontSize: 12, color: Color(0xFF7D8C86)),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              profile.about,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF5D6D66),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () {
                if (hasRequests) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => RequestConfirmationPage(
                        organizationName: profile.name,
                      ),
                    ),
                  );
                }
              },
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF2A7A55),
                foregroundColor: Colors.white,
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
              ),
              child: Text(
                hasRequests ? "Book Recycle" : "Start Request with ${profile.name}",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );

    final Widget right = Expanded(
      flex: 8,
      child: Container(
        height: 240,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 22,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Image.asset(
          profile.heroImage,
          fit: BoxFit.cover,
        ),
      ),
    );

    if (stackPanels) {
      return Column(
        children: [
          left,
          const SizedBox(height: 14),
          right,
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [left, right],
    );
  }

  Widget _buildMaterialsSection(_OrganizationProfile profile, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.settings, size: 16, color: Color(0xFF2D7A55)),
            const SizedBox(width: 7),
            Text(
              "Accepted Materials",
              style: TextStyle(
                fontSize: isMobile ? 28 : 34,
                fontWeight: FontWeight.w900,
                color: const Color(0xFF2D7A55),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        GridView.builder(
          itemCount: profile.materials.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isMobile ? 1 : 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: isMobile ? 2.1 : 1.7,
          ),
          itemBuilder: (context, index) => _buildMaterialCard(profile.materials[index]),
        ),
      ],
    );
  }

  Widget _buildMaterialCard(_MaterialRate material) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F3F2),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 15,
                backgroundColor: const Color(0xFFDBF3E2),
                child: Icon(material.icon, color: const Color(0xFF2B7A56), size: 16),
              ),
              const Spacer(),
              if (material.highDemand)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDAEFE2),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: const Text(
                    "HIGH DEMAND",
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF3E8D63),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            material.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Color(0xFF34413B),
              height: 0.95,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            material.description,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF7A8882),
            ),
          ),
          const Spacer(),
          const Text(
            "PRICE PER UNIT",
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: Color(0xFF8C9A95),
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              Text(
                "Rs. ${material.price}",
                style: const TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF26774F),
                  height: 0.92,
                ),
              ),
              const SizedBox(width: 4),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  material.unit,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF8C9A95),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                "• ${material.impact}",
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF2E8A52),
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsPanel() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFE9EFEC),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.insert_chart_outlined, size: 14, color: Color(0xFF3A7D5A)),
              SizedBox(width: 7),
              Text(
                "Impact Statistics",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF2E4A3D),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            "TOTAL RECYCLED VOLUME",
            style: TextStyle(
              fontSize: 10,
              color: Color(0xFF8B9692),
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 3),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              Text(
                "1,248",
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF176A45),
                  height: 0.9,
                ),
              ),
              SizedBox(width: 4),
              Padding(
                padding: EdgeInsets.only(bottom: 7),
                child: Text(
                  "Tons",
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF5D6C66),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: const LinearProgressIndicator(
              value: 0.70,
              minHeight: 6,
              color: Color(0xFF2A7B54),
              backgroundColor: Color(0xFFCDDBD4),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            "70% of annual goal achieved",
            style: TextStyle(fontSize: 10, color: Color(0xFF7B8882)),
          ),
          const SizedBox(height: 12),
          const Divider(color: Color(0xFFD2DDD8), height: 1),
          const SizedBox(height: 12),
          const Text(
            "CARBON OFFSET",
            style: TextStyle(
              fontSize: 10,
              color: Color(0xFF8B9692),
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 3),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              Text(
                "3,492",
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF176A45),
                  height: 0.9,
                ),
              ),
              SizedBox(width: 4),
              Padding(
                padding: EdgeInsets.only(bottom: 7),
                child: Text(
                  "MT CO2e",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF5D6C66),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            "Equivalent to planting 57,800 trees over a 10-year period.",
            style: TextStyle(fontSize: 10, color: Color(0xFF7B8882)),
          ),
          const SizedBox(height: 12),
          const Text(
            "OPERATIONS HUB",
            style: TextStyle(
              fontSize: 10,
              color: Color(0xFF8B9692),
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            height: 66,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              gradient: const LinearGradient(
                colors: [Color(0xFFB8C4C0), Color(0xFF8A9A95)],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPartnerCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF367D59),
            Color(0xFF1F5B41),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Partner with us",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Join 500+ local businesses creating a waste-free future. Business accounts get priority pickup.",
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFFCBE4D8),
              height: 1.35,
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF53E354),
                foregroundColor: const Color(0xFF145230),
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                "Business Inquiries",
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OrganizationProfile {
  const _OrganizationProfile({
    required this.name,
    required this.location,
    required this.certification,
    required this.about,
    required this.heroImage,
    required this.materials,
  });

  final String name;
  final String location;
  final String certification;
  final String about;
  final String heroImage;
  final List<_MaterialRate> materials;
}

class _MaterialRate {
  const _MaterialRate({
    required this.title,
    required this.description,
    required this.price,
    required this.unit,
    required this.impact,
    required this.icon,
    this.highDemand = false,
  });

  final String title;
  final String description;
  final String price;
  final String unit;
  final String impact;
  final bool highDemand;
  final IconData icon;
}
