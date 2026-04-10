import "package:flutter/material.dart";
import "package:flutter_application_1/models/bin_entry.dart";
import "package:flutter_application_1/screens/homepage.dart";
import "package:flutter_application_1/services/bin_cookie_service.dart";
import "package:flutter_application_1/widgets/app_drawer.dart";
import "package:flutter_application_1/widgets/app_navbar.dart";

class RecyclingBinPage extends StatefulWidget {
  const RecyclingBinPage({super.key});

  @override
  State<RecyclingBinPage> createState() => _RecyclingBinPageState();
}

class _RecyclingBinPageState extends State<RecyclingBinPage> {
  late List<BinEntry> _entries;

  @override
  void initState() {
    super.initState();
    _entries = BinCookieService.loadEntries();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 700;
    final bool stackPanels = width < 980;
    final int totalQuantity = _entries.fold(0, (sum, item) => sum + item.quantity);
    final double estimatedValue = totalQuantity * 1.67;
    final int totalEntryCount = _entries.length;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F6F4),
      appBar: AppNavbar(
        isMobile: isMobile,
        selectedIndex: 1,
        onTabSelected: (index) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => HomePage(initialTabIndex: index)),
          );
        },
      ),
      drawer: AppDrawer(
        currentIndex: 3,
        onHome: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const HomePage(initialTabIndex: 0)),
          );
        },
        onOpenBin: () {
          Navigator.pop(context);
        },
        onNewRequest: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const HomePage(initialTabIndex: 1)),
          );
        },
        onTrackRequests: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const HomePage(initialTabIndex: 1)),
          );
        },
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isMobile ? 14 : 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Recycling Bin",
              style: TextStyle(
                fontSize: isMobile ? 34 : 44,
                fontWeight: FontWeight.w900,
                color: const Color(0xFF196842),
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "Curate your contribution to the circular economy.",
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF6F7E78),
              ),
            ),
            const SizedBox(height: 18),
            if (_entries.isEmpty)
              _buildEmptyState(context)
            else if (stackPanels)
              Column(
                children: [
                  _buildEntriesList(_entries),
                  const SizedBox(height: 14),
                  _buildSummaryCard(totalQuantity, totalEntryCount, estimatedValue),
                  const SizedBox(height: 14),
                  _buildBottomImageCard(),
                ],
              )
            else
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 10, child: _buildEntriesList(_entries)),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        _buildSummaryCard(totalQuantity, totalEntryCount, estimatedValue),
                        const SizedBox(height: 14),
                        _buildBottomImageCard(),
                      ],
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildEntriesList(List<BinEntry> entries) {
    return Column(
      children: [
        ...entries.map(_buildBinItemCard),
        const SizedBox(height: 12),
        InkWell(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomePage(initialTabIndex: 1)),
            );
          },
          child: Row(
            children: const [
              CircleAvatar(
                radius: 15,
                backgroundColor: Color(0xFFD6F0E2),
                child: Icon(Icons.add, size: 18, color: Color(0xFF1B6B45)),
              ),
              SizedBox(width: 8),
              Text(
                "Add More Items",
                style: TextStyle(
                  color: Color(0xFF2D6E4D),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBinItemCard(BinEntry entry) {
    final String quantityLabel = "Qty ${entry.quantity}";

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: const Color(0xFFC8EFE0),
            child: Icon(Icons.recycling, color: const Color(0xFF1B6B45), size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.itemName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF30413A),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  entry.materialType ?? "General recyclable",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF7B8A84),
                  ),
                ),
              ],
            ),
          ),
          Text(
            quantityLabel,
            style: const TextStyle(
              fontSize: 17,
              color: Color(0xFF1E6D46),
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(int totalQuantity, int totalEntryCount, double value) {

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF1F0),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Archive Summary",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w900,
              color: Color(0xFF2D3B35),
            ),
          ),
          const SizedBox(height: 12),
          _buildSummaryRow("Total Quantity", "$totalQuantity"),
          const SizedBox(height: 8),
          _buildSummaryRow("Unique Items", "$totalEntryCount"),
          const SizedBox(height: 8),
          _buildSummaryRow("Estimated Value", "Rs. ${value.toStringAsFixed(2)}", highlight: true),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "ESTIMATED IMPACT",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF7C8983),
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 13,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.circle_outlined, color: Color(0xFF25714C), size: 22),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      totalQuantity.toString(),
                      style: const TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF2B3A34),
                        height: 0.9,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Padding(
                      padding: EdgeInsets.only(top: 12),
                      child: Text(
                        "items archived",
                        style: TextStyle(fontSize: 12, color: Color(0xFF7C8983)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const HomePage(initialTabIndex: 2)),
                );
              },
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF20724C),
                foregroundColor: Colors.white,
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                "Proceed to Select Organization",
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Center(
            child: Text(
              "Value is estimated using your total quantity and current market trends.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10, color: Color(0xFF7C8983)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool highlight = false}) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Color(0xFF6D7B75)),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            color: highlight ? const Color(0xFF20724C) : const Color(0xFF2B3A34),
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomImageCard() {
    return Container(
      height: 190,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("assets/images/pickup.png", fit: BoxFit.cover),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Color(0xCC000000)],
              ),
            ),
          ),
          const Positioned(
            left: 12,
            right: 12,
            bottom: 10,
            child: Text(
              "Your contribution fuels 4 sustainable local projects.",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          const Icon(Icons.inventory_2_outlined, size: 56, color: Color(0xFF9AB7AA)),
          const SizedBox(height: 10),
          const Text(
            "No items in your bin",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Color(0xFF2E3E37),
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            "Add items to start your recycling request.",
            style: TextStyle(fontSize: 14, color: Color(0xFF71807A)),
          ),
          const SizedBox(height: 14),
          FilledButton.icon(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const HomePage(initialTabIndex: 1)),
              );
            },
            icon: const Icon(Icons.add),
            label: const Text("Add Items"),
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFF20724C),
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
