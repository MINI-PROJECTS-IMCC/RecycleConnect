import "package:flutter/material.dart";
import "package:flutter_application_1/models/bin_entry.dart";
import "package:flutter_application_1/screens/homepage.dart";
import "package:flutter_application_1/screens/recycling_bin_page.dart";
import "package:flutter_application_1/services/bin_cookie_service.dart";
import "package:flutter_application_1/widgets/app_drawer.dart";
import "package:flutter_application_1/widgets/app_navbar.dart";

class NewRequestPage extends StatefulWidget {
  const NewRequestPage({super.key});

  @override
  State<NewRequestPage> createState() => _NewRequestPageState();
}

class _NewRequestPageState extends State<NewRequestPage> {
  final List<_AddedRequestItem> _addedItems = [];

  final List<_MaterialOption> _materials = [
    _MaterialOption(
      name: "Plastic Polymers",
      description: "PET, HDPE and LDPE containers.",
      icon: Icons.eco,
      selected: true,
    ),
    _MaterialOption(
      name: "Paper & Pulp",
      description: "Cardboard, office paper, magazines.",
      icon: Icons.description_outlined,
      selected: false,
    ),
    _MaterialOption(
      name: "Metals",
      description: "Aluminum cans and steel scrap.",
      icon: Icons.sync_alt,
      selected: true,
    ),
    _MaterialOption(
      name: "E-Waste",
      description: "Cables, batteries, and circuits.",
      icon: Icons.flash_on,
      selected: false,
    ),
  ];

  final TextEditingController _instructionsController = TextEditingController();

  @override
  void dispose() {
    _instructionsController.dispose();
    super.dispose();
  }

  int _materialItemCount(String materialName) {
    return _addedItems.where((item) => item.materialName == materialName).length;
  }

  Future<void> _showAddItemDialog(_MaterialOption material) async {
    final TextEditingController itemNameController = TextEditingController();
    final TextEditingController quantityController = TextEditingController();

    final bool? didAdd = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Item"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: itemNameController,
                decoration: const InputDecoration(
                  labelText: "Item name",
                  hintText: "Ex: Water bottle",
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: quantityController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Quantity",
                  hintText: "Ex: 12",
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Cancel"),
            ),
            FilledButton(
              onPressed: () {
                final String itemName = itemNameController.text.trim();
                final int quantity = int.tryParse(quantityController.text.trim()) ?? 0;

                if (itemName.isEmpty || quantity <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please enter a valid item name and quantity."),
                    ),
                  );
                  return;
                }

                setState(() {
                  _addedItems.add(
                    _AddedRequestItem(
                      materialName: material.name,
                      itemName: itemName,
                      quantity: quantity,
                    ),
                  );
                });
                Navigator.pop(context, true);
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );

    itemNameController.dispose();
    quantityController.dispose();

    if (didAdd == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Item added to current request.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 700;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F6F4),
      appBar: AppNavbar(
        isMobile: isMobile,
        selectedIndex: 1,
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
        currentIndex: 1,
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
        onNewRequest: () {},
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
        padding: EdgeInsets.all(isMobile ? 16 : 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Text(
                    "What are we archiving today?",
                    style: TextStyle(
                      fontSize: isMobile ? 30 : 46,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF202A27),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Add these items to your recycling bin to start building your environmental collection.",
                    style: TextStyle(
                      fontSize: 15,
                      color: const Color(0xFF64726D),
                      height: 1.35,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            LayoutBuilder(
              builder: (context, constraints) {
                final bool stackPanels = constraints.maxWidth < 1050;

                final Widget materialsPanel = _buildMaterialsPanel();
                final Widget currentBinPanel = _buildCurrentBinPanel();

                if (stackPanels) {
                  return Column(
                    children: [
                      materialsPanel,
                      const SizedBox(height: 16),
                      currentBinPanel,
                    ],
                  );
                }

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 8, child: materialsPanel),
                    const SizedBox(width: 16),
                    Expanded(flex: 4, child: currentBinPanel),
                  ],
                );
              },
            ),
            const SizedBox(height: 16),
            _buildInstructionsPanel(),
          ],
        ),
      ),
    );
  }

  Widget _buildMaterialsPanel() {
    final int draftCount = _materials.where((item) => item.selected).length;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEDEFEF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Material Categories",
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF225D46),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFDDE2E0),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  "$draftCount items in draft",
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF5E6663),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          LayoutBuilder(
            builder: (context, constraints) {
              final int columnCount = constraints.maxWidth > 760 ? 2 : 1;
              final double spacing = 10;
              final double tileWidth =
                  (constraints.maxWidth - ((columnCount - 1) * spacing)) / columnCount;

              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children: _materials.map((material) {
                  return SizedBox(
                    width: tileWidth,
                    child: _buildMaterialTile(material),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMaterialTile(_MaterialOption material) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: material.selected ? const Color(0xFF2A7E59) : const Color(0xFFD7DCDC),
          width: material.selected ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: const Color(0xFFD8EEE3),
                child: Icon(material.icon, size: 16, color: const Color(0xFF2A7E59)),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  setState(() {
                    material.selected = !material.selected;
                    if (!material.selected) {
                      _addedItems.removeWhere(
                        (item) => item.materialName == material.name,
                      );
                    }
                  });
                },
                child: Icon(
                  material.selected ? Icons.check_circle : Icons.radio_button_unchecked,
                  color: material.selected ? const Color(0xFF1B6D45) : const Color(0xFFA9B4B0),
                  size: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            material.name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2D3A36),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            material.description,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF6C7874),
            ),
          ),
          const SizedBox(height: 10),
          if (material.selected)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F7F5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "${_materialItemCount(material.name)} item(s) added",
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF61716B),
                      ),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () => _showAddItemDialog(material),
                    icon: const Icon(Icons.add, size: 14),
                    label: const Text("Add Items"),
                  ),
                ],
              ),
            )
          else
            InkWell(
              onTap: () {
                setState(() {
                  material.selected = true;
                });
              },
              child: const Text(
                "Enable category +",
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF1E6E47),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCurrentBinPanel() {
    final int totalQuantity = _addedItems.fold(0, (sum, item) => sum + item.quantity);
    final int points = totalQuantity * 2 + 10;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEDEFEF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Current Bin Item",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2D3A36),
            ),
          ),
          const SizedBox(height: 12),
          if (_addedItems.isEmpty)
            const Text(
              "No items selected yet.",
              style: TextStyle(fontSize: 13, color: Color(0xFF6C7874)),
            )
          else
            ..._addedItems.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${item.itemName} (${item.materialName})",
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF4F5B57),
                        ),
                      ),
                    ),
                    Text(
                      "Qty ${item.quantity}",
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2E3835),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          const Divider(height: 20),
          Row(
            children: [
              const Expanded(
                child: Text(
                  "Potential Impact",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2F3B37),
                  ),
                ),
              ),
              Text(
                "$points pts",
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF22804D),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFC5F2D2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              children: [
                Icon(Icons.eco, color: Color(0xFF236A46), size: 16),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "You can add multiple types of materials to a single collection before scheduling pickup.",
                    style: TextStyle(fontSize: 11, color: Color(0xFF2A5A44)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                if (_addedItems.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please add at least one item first.")),
                  );
                  return;
                }

                final List<BinEntry> entries = _addedItems
                    .map(
                      (item) => BinEntry(
                        itemName: item.itemName,
                        quantity: item.quantity,
                        materialType: item.materialName,
                      ),
                    )
                    .toList();

                BinCookieService.saveEntries(entries);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RecyclingBinPage()),
                );
              },
              icon: const Icon(Icons.shopping_basket_outlined),
              label: const Text("Add to Bin"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0F6B3D),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: const StadiumBorder(),
              ),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              "Save for later",
              style: TextStyle(color: Color(0xFF4A5853), fontWeight: FontWeight.w600),
            ),
          ),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 11,
                backgroundColor: Color(0xFFC6F0D4),
                child: Icon(Icons.location_on, size: 13, color: Color(0xFF1C6A44)),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Pro-tip: Building a larger bin reduces the carbon footprint of transport logistics.",
                  style: TextStyle(fontSize: 11, color: Color(0xFF74817C), height: 1.3),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionsPanel() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEDEFEF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Special Handling Instructions",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2D3A36),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _instructionsController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText:
                  "Tell us if items are fragile, bulky, or require specific access permissions...",
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFD5DDDA)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFD5DDDA)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFF2A7E59)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MaterialOption {
  _MaterialOption({
    required this.name,
    required this.description,
    required this.icon,
    required this.selected,
  });

  final String name;
  final String description;
  final IconData icon;
  bool selected;
}

class _AddedRequestItem {
  const _AddedRequestItem({
    required this.materialName,
    required this.itemName,
    required this.quantity,
  });

  final String materialName;
  final String itemName;
  final int quantity;
}
