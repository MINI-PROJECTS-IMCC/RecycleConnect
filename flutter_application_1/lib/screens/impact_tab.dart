import "package:flutter/material.dart";

class ImpactTab extends StatelessWidget {
  const ImpactTab({
    super.key,
    required this.isMobile,
  });

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "See the positive impact you're making",
          style: TextStyle(
            fontSize: isMobile ? 14 : 16,
            color: Colors.grey[700],
          ),
        ),
        SizedBox(height: 24),
        _buildImpactCard(
          "Carbon Emissions Saved",
          "142kg CO2",
          Icons.cloud_off,
          Colors.blue,
        ),
        SizedBox(height: 16),
        _buildImpactCard(
          "Plastic Diverted from Landfill",
          "56kg",
          Icons.delete_outline,
          Colors.red,
        ),
        SizedBox(height: 16),
        _buildImpactCard(
          "Trees Equivalent Saved",
          "2.3 trees",
          Icons.nature,
          Colors.green,
        ),
        SizedBox(height: 16),
        _buildImpactCard(
          "Water Saved",
          "1,200 liters",
          Icons.water,
          Colors.cyan,
        ),
      ],
    );
  }

  Widget _buildImpactCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 32),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}