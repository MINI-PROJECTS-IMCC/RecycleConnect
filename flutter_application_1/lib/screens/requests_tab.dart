import "package:flutter/material.dart";
import "package:flutter_application_1/models/bin_entry.dart";
import "package:flutter_application_1/screens/new_request_page.dart";
import "package:flutter_application_1/screens/request_confirmation_page.dart";
import "package:flutter_application_1/services/bin_cookie_service.dart";

class RequestsTab extends StatefulWidget {
  const RequestsTab({
    super.key,
    required this.isMobile,
  });

  final bool isMobile;

  @override
  State<RequestsTab> createState() => _RequestsTabState();
}

class _RequestsTabState extends State<RequestsTab> {
  int _selectedFilterIndex = 0;
  late List<BinEntry> _pendingRequests;
  final List<BinEntry> _completedRequests = const <BinEntry>[];

  @override
  void initState() {
    super.initState();
    _loadRequests();
  }

  void _loadRequests() {
    _pendingRequests = BinCookieService.loadEntries();
  }

  Future<void> _openNewRequestPage() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const NewRequestPage()),
    );

    if (!mounted) {
      return;
    }

    setState(() {
      _loadRequests();
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool showPending = _selectedFilterIndex == 0 || _selectedFilterIndex == 1;
    final bool showCompleted = _selectedFilterIndex == 0 || _selectedFilterIndex == 2;
    final List<BinEntry> filteredRequests = _selectedFilterIndex == 2 ? _completedRequests : _pendingRequests;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Track and manage all your pickup requests",
          style: TextStyle(
            fontSize: widget.isMobile ? 14 : 16,
            color: Colors.grey[700],
          ),
        ),
        SizedBox(height: 18),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildFilterPill(0, "All Requests"),
              SizedBox(width: 10),
              _buildFilterPill(1, "Track Requests"),
              SizedBox(width: 10),
              _buildFilterPill(2, "Completed"),
            ],
          ),
        ),
        SizedBox(height: 22),
        if (filteredRequests.isEmpty)
          _buildEmptyState()
        else ...[
        if (showPending) ...[
          Text(
            "Pending Requests (${_pendingRequests.length})",
            style: TextStyle(
              fontSize: widget.isMobile ? 16 : 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          ..._pendingRequests.map(
            (entry) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildRequestCard(
                entry,
                "Awaiting pickup",
                Colors.orange,
              ),
            ),
          ),
          SizedBox(height: 24),
        ],
        if (showCompleted) ...[
          Text(
            "Completed Requests (${_completedRequests.length})",
            style: TextStyle(
              fontSize: widget.isMobile ? 16 : 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          ..._completedRequests.map(
            (entry) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildRequestCard(
                entry,
                "Completed",
                Colors.green,
              ),
            ),
          ),
        ],
        ],
      ],
    );
  }

  Widget _buildFilterPill(int index, String label) {
    final bool isSelected = _selectedFilterIndex == index;
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: () {
        setState(() {
          _selectedFilterIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF1F7A45) : Colors.white,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: isSelected ? Color(0xFF1F7A45) : Color(0xFFD6E0DA),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : Color(0xFF455650),
          ),
        ),
      ),
    );
  }

  Widget _buildRequestCard(
    BinEntry entry,
    String status,
    Color statusColor,
  ) {
    final String quantityLabel = "Qty ${entry.quantity}";

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  entry.itemName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Text(
                quantityLabel,
                style: TextStyle(
                  color: Color(0xFF1E6D46),
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (entry.materialType != null && entry.materialType!.isNotEmpty) ...[
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    entry.materialType!,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RequestConfirmationPage(
                      organizationName: "Your Organization",
                    ),
                  ),
                );
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF1F7A45),
                side: const BorderSide(color: Color(0xFF1F7A45)),
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(vertical: 10),
              ),
              child: const Text(
                "Open Request",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD6E0DA)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "No requests yet",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2E3E37),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Create your first request to start scheduling pickups.",
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 14),
          ElevatedButton.icon(
            onPressed: _openNewRequestPage,
            icon: const Icon(Icons.add, size: 18),
            label: const Text("New Request"),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1F7A45),
              foregroundColor: Colors.white,
              shape: const StadiumBorder(),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }
}