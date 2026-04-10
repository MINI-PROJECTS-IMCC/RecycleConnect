import "package:flutter/material.dart";
import "package:flutter_application_1/models/bin_entry.dart";
import "package:flutter_application_1/services/bin_cookie_service.dart";
import "package:flutter_application_1/widgets/app_drawer.dart";
import "package:flutter_application_1/widgets/app_navbar.dart";

class RequestConfirmationPage extends StatefulWidget {
  const RequestConfirmationPage({
    super.key,
    required this.organizationName,
  });

  final String organizationName;

  @override
  State<RequestConfirmationPage> createState() => _RequestConfirmationPageState();
}

class _RequestConfirmationPageState extends State<RequestConfirmationPage> {
  late List<BinEntry> _requestEntries;
  DateTime? _selectedDate;
  String _selectedTimeSlot = "Morning";
  late DateTime _currentMonth;
  
  late TextEditingController _streetController;
  late TextEditingController _cityController;
  late TextEditingController _zipController;

  @override
  void initState() {
    super.initState();
    _requestEntries = BinCookieService.loadEntries();
    _currentMonth = DateTime(DateTime.now().year, DateTime.now().month, 1);
    _streetController = TextEditingController(text: "123 Eco Lane");
    _cityController = TextEditingController(text: "Greenwood");
    _zipController = TextEditingController(text: "97210");
  }

  @override
  void dispose() {
    _streetController.dispose();
    _cityController.dispose();
    _zipController.dispose();
    super.dispose();
  }

  double _calculateTotalWeight() {
    return _requestEntries.fold(0.0, (sum, item) => sum + item.quantity);
  }

  double _calculateEstimatedValue() {
    return _calculateTotalWeight() * 1.67;
  }

  void _previousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1, 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 1);
    });
  }

  String _getMonthName(int month) {
    const months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 700;
    final bool stackPanels = screenWidth < 1200;
    final double totalWeight = _calculateTotalWeight();
    final double estimatedValue = _calculateEstimatedValue();

    return Scaffold(
      backgroundColor: const Color(0xFFF3F6F4),
      appBar: AppNavbar(
        isMobile: isMobile,
        selectedIndex: 2,
        onTabSelected: (index) {
          Navigator.pop(context);
        },
      ),
      drawer: AppDrawer(
        currentIndex: 0,
        onHome: () => Navigator.pop(context),
        onOpenBin: () => Navigator.pop(context),
        onNewRequest: () => Navigator.pop(context),
        onTrackRequests: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isMobile ? 16 : 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Confirm Your Request",
              style: TextStyle(
                fontSize: isMobile ? 28 : 36,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF212D28),
              ),
            ),
            const SizedBox(height: 24),
            if (stackPanels)
              Column(
                children: [
                  _buildPickupAddressSection(isMobile),
                  const SizedBox(height: 20),
                  _buildSchedulePickupSection(isMobile),
                  const SizedBox(height: 20),
                  _buildFinalSummaryPanel(totalWeight, estimatedValue),
                ],
              )
            else
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 7,
                    child: Column(
                      children: [
                        _buildPickupAddressSection(isMobile),
                        const SizedBox(height: 20),
                        _buildSchedulePickupSection(isMobile),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 5,
                    child: _buildFinalSummaryPanel(totalWeight, estimatedValue),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPickupAddressSection(bool isMobile) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.location_on, color: Color(0xFF1F7A45), size: 20),
              const SizedBox(width: 8),
              Text(
                "Pickup Address",
                style: TextStyle(
                  fontSize: isMobile ? 16 : 18,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF212D28),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "STREET ADDRESS",
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF7D8C86),
                ),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: _streetController,
                decoration: InputDecoration(
                  hintText: "Enter street address",
                  fillColor: const Color(0xFFF3F6F4),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFFD6DFD9)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFFD6DFD9)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFF1F7A45), width: 2),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "CITY",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF7D8C86),
                          ),
                        ),
                        const SizedBox(height: 6),
                        TextField(
                          controller: _cityController,
                          decoration: InputDecoration(
                            hintText: "Enter city",
                            fillColor: const Color(0xFFF3F6F4),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Color(0xFFD6DFD9)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Color(0xFFD6DFD9)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Color(0xFF1F7A45), width: 2),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "ZIP CODE",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF7D8C86),
                          ),
                        ),
                        const SizedBox(height: 6),
                        TextField(
                          controller: _zipController,
                          decoration: InputDecoration(
                            hintText: "Enter zip code",
                            fillColor: const Color(0xFFF3F6F4),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Color(0xFFD6DFD9)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Color(0xFFD6DFD9)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Color(0xFF1F7A45), width: 2),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSchedulePickupSection(bool isMobile) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.calendar_today, color: Color(0xFF1F7A45), size: 20),
              const SizedBox(width: 8),
              Text(
                "Schedule Pickup",
                style: TextStyle(
                  fontSize: isMobile ? 16 : 18,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF212D28),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            "SELECT TIME WINDOW",
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF7D8C86),
            ),
          ),
          const SizedBox(height: 10),
          Column(
            children: [
              _buildTimeSlotOption("Morning", "9:00 AM - 12:00 PM"),
              const SizedBox(height: 8),
              _buildTimeSlotOption("Afternoon", "12:00 PM - 4:00 PM"),
            ],
          ),
          const SizedBox(height: 16),
          _buildCalendar(),
        ],
      ),
    );
  }

  Widget _buildTimeSlotOption(String label, String time) {
    final bool isSelected = _selectedTimeSlot == label;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedTimeSlot = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE8F3EE) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? const Color(0xFF1F7A45) : const Color(0xFFD6DFD9),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? const Color(0xFF1F7A45) : const Color(0xFFD6DFD9),
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF1F7A45),
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF212D28),
                  ),
                ),
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF7D8C86),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendar() {
    final int daysInMonth =
        DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;
    final int firstWeekday = DateTime(_currentMonth.year, _currentMonth.month, 1)
        .weekday; // 1 = Monday, 7 = Sunday

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FBFA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 36,
                height: 36,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: _previousMonth,
                  icon: const Icon(Icons.chevron_left, color: Color(0xFF7D8C86), size: 18),
                ),
              ),
              Text(
                "${_getMonthName(_currentMonth.month)} ${_currentMonth.year}",
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF4C5B55),
                ),
              ),
              SizedBox(
                width: 36,
                height: 36,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: _nextMonth,
                  icon: const Icon(Icons.chevron_right, color: Color(0xFF7D8C86), size: 18),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1.0,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: daysInMonth + (firstWeekday - 1),
            itemBuilder: (context, index) {
              if (index < firstWeekday - 1) {
                return const SizedBox();
              }

              final int day = index - (firstWeekday - 1) + 1;
              final DateTime dateTime =
                  DateTime(_currentMonth.year, _currentMonth.month, day);
              final bool isSelected = _selectedDate != null &&
                  _selectedDate!.year == dateTime.year &&
                  _selectedDate!.month == dateTime.month &&
                  _selectedDate!.day == dateTime.day;

              return InkWell(
                onTap: () {
                  setState(() {
                    _selectedDate = dateTime;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF1F7A45) : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      "$day",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : const Color(0xFF4C5B55),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFinalSummaryPanel(double totalWeight, double estimatedValue) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFD6DFD9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Final Request Summary",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF212D28),
            ),
          ),
          const SizedBox(height: 12),
          _buildSummaryRow("Total Weight", "-$totalWeight kg"),
          const SizedBox(height: 8),
          _buildSummaryRow("Est. Value", "Rs. ${estimatedValue.toStringAsFixed(2)}"),
          const SizedBox(height: 8),
          _buildSummaryRow("Organization", widget.organizationName),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F6F4),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "IMPACT TRACKER",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF7D8C86),
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF1F7A45),
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Expanded(
                      child: Text(
                        "85% of recyclable materials will be properly processed",
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xFF5F7B74),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Request submitted successfully!")),
                );
              },
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF1F7A45),
                foregroundColor: Colors.white,
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                "Submit Request",
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF1F7A45),
                side: const BorderSide(color: Color(0xFF1F7A45)),
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                "Back to Details",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF7D8C86),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Color(0xFF212D28),
          ),
        ),
      ],
    );
  }
}
