import "package:flutter/material.dart";
import "package:flutter_application_1/screens/organization_prices_page.dart";

class OrganizationsTab extends StatelessWidget {
  const OrganizationsTab({
    super.key,
    required this.isMobile,
  });

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final List<_PartnerData> partners = [
      _PartnerData(
        name: "GreenCycle Solutions",
        rating: "4.9",
        reviews: "1.2k reviews",
        distance: "0.6 miles away",
        subtitle:
            "Specializing in high-grade plastics and organic waste conversion.",
        serviceLine: "Same-day pickup guaranteed for urban areas.",
        tags: const ["Plastics", "Compost", "Metals"],
        imagePath: "assets/images/sunrise.webp",
        isPrimary: true,
      ),
      _PartnerData(
        name: "IronStream Recovery",
        rating: "4.7",
        reviews: "840 reviews",
        distance: "2.4 miles away",
        subtitle:
            "The city leading metal processing plant. Premium rates for aluminum.",
        serviceLine: "and copper. Professional weighing service.",
        tags: const ["Metals", "E-Waste"],
        imagePath: "assets/images/pickup.png",
      ),
      _PartnerData(
        name: "Urban Pulp & Paper",
        rating: "4.5",
        reviews: "620 reviews",
        distance: "1.1 miles away",
        subtitle:
            "Dedicated to paper and cardboard circularity. High-capacity",
        serviceLine: "processing for large commercial requests.",
        tags: const ["Paper", "Cardboard"],
        imagePath: "assets/images/bg-login.png",
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Choose Your Partner",
          style: TextStyle(
            fontSize: isMobile ? 28 : 36,
            fontWeight: FontWeight.w800,
            color: Color(0xFF212D28),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "Select a verified recycling organization to handle your current request. Rates are",
          style: TextStyle(
            fontSize: isMobile ? 12 : 13,
            color: Color(0xFF697873),
            height: 1.4,
          ),
        ),
        Text(
          "calculated based on material weight and current market value.",
          style: TextStyle(
            fontSize: isMobile ? 12 : 13,
            color: Color(0xFF697873),
            height: 1.4,
          ),
        ),
        const SizedBox(height: 20),
        _buildPartnerList(context, partners),
      ],
    );
  }

  Widget _buildPartnerList(BuildContext context, List<_PartnerData> partners) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                height: 44,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: Color(0xFFF1F3F2),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0xFFE6ECE9)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Color(0xFF8A9893), size: 18),
                    const SizedBox(width: 8),
                    Text(
                      "Search by name or material type...",
                      style: TextStyle(
                        color: Color(0xFF97A39E),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            _buildFilterPill("Distance"),
            const SizedBox(width: 8),
            _buildFilterPill("Rating"),
            const SizedBox(width: 8),
            _buildFilterPill("Highest Rates"),
          ],
        ),
        const SizedBox(height: 14),
        ...partners
            .map((partner) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _buildPartnerCard(context, partner),
                ))
            .toList(),
      ],
    );
  }

  Widget _buildFilterPill(String label) {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Color(0xFFF1F3F2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(0xFFE6ECE9)),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Color(0xFF6C7B76),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _buildPartnerCard(BuildContext context, _PartnerData partner) {
    final Color accent = Color(0xFF2F7A5A);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFE3EAE7)),
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              partner.imagePath,
              height: 70,
              width: 70,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            partner.name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF24312C),
                              height: 1,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(Icons.star, color: Color(0xFF2D7E59), size: 14),
                              const SizedBox(width: 4),
                              Text(
                                partner.rating,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF4C5B55),
                                ),
                              ),
                              Text(
                                " (${partner.reviews})",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Color(0xFF8A9893),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "• ${partner.distance}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Color(0xFF8A9893),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      height: 36,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => OrganizationPricesPage(
                                highlightedPartner: partner.name,
                              ),
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: partner.isPrimary ? Colors.white : accent,
                          backgroundColor: partner.isPrimary ? accent : Colors.white,
                          side: BorderSide(color: accent),
                          shape: StadiumBorder(),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                        ),
                        child: Text(
                          "See Prices",
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  partner.subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF65736E),
                    height: 1.25,
                  ),
                ),
                Text(
                  partner.serviceLine,
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF65736E),
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: partner.tags
                      .map(
                        (tag) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Color(0xFFE8F3EE),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            tag,
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(0xFF4B6A5D),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PartnerData {
  const _PartnerData({
    required this.name,
    required this.rating,
    required this.reviews,
    required this.distance,
    
    required this.subtitle,
    required this.serviceLine,
    required this.tags,
    required this.imagePath,
    this.isPrimary = false,
  });

  final String name;
  final String rating;
  final String reviews;
  final String distance;
  final String subtitle;
  final String serviceLine;
  final List<String> tags;
  final String imagePath;
  final bool isPrimary;
}