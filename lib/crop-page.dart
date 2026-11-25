import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CropPage extends StatefulWidget {
  const CropPage({super.key});

  @override
  State<CropPage> createState() => CropPageState();
}

class CropPageState extends State<CropPage> {
  final String formattedDate = DateFormat(
    'EEEE, MMMM d',
  ).format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Fixed Top Header ---
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
              child: Text(
                "My Crop",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // --- Fixed Search Bar ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SearchAnchor(
                builder: (BuildContext context, SearchController controller) {
                  return SearchBar(
                    controller: controller,
                    padding: const WidgetStatePropertyAll<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                    leading: const Icon(Icons.search),
                    onTap: () => controller.openView(),
                    onChanged: (_) => controller.openView(),
                    hintText: "Search crops, transactions...",
                    hintStyle: const WidgetStatePropertyAll<TextStyle>(
                      TextStyle(color: Color(0xFF807E7E)),
                    ),
                    elevation: const WidgetStatePropertyAll<double>(1.0),
                    backgroundColor: const WidgetStatePropertyAll<Color>(
                      Colors.white,
                    ),
                  );
                },
                suggestionsBuilder:
                    (BuildContext context, SearchController controller) {
                      return List<Widget>.empty();
                    },
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              height: 48,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildCategoryButton(
                    label: "Crop",
                    icon: Icons.rice_bowl,
                    color: Colors.green,
                    textColor: Colors.white,
                  ),
                  const SizedBox(width: 12),
                  _buildCategoryButton(
                    label: "Cattle",
                    icon: Icons.pets,
                    color: Colors.greenAccent.shade700,
                    textColor: Colors.white,
                  ),
                  const SizedBox(width: 12),
                  _buildCategoryButton(
                    label: "Expense",
                    icon: Icons.account_balance_wallet,
                    color: Colors.grey.shade200,
                    textColor: Colors.black87,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    physics: const BouncingScrollPhysics(),
                    itemCount: 8, // Adjust as needed or wire to a dynamic list
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      return const CropStatusCard(
                        title: "Field A: Maize",
                        progress: 0.5,
                        status: "Growing",
                        amount: "1,000",
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryButton({
    required String label,
    required IconData icon,
    required Color color,
    required Color textColor,
  }) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 18, color: textColor),
      label: Text(label, style: TextStyle(color: textColor)),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}

// --- Reusable Crop Status Card Widget ---
class CropStatusCard extends StatelessWidget {
  final String title;
  final double progress;
  final String status;
  final String amount;

  const CropStatusCard({
    super.key,
    required this.title,
    required this.progress,
    required this.status,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      color: const Color(0xFFF9FAFB),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.black.withOpacity(0.05)),
    ),
    child: Row(
      children: [
        // Title on top, Amount directly underneath
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '\Spent Till Now: ${amount}',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
          ],
        ),

        const SizedBox(width: 14),

        // Middle progress bar stretching across remaining space
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: const Color(0xFFE5E7EB),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
            ),
          ),
        ),

        const SizedBox(width: 14),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFF20D44D).withOpacity(0.12),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: const Color(0xFF20D44D).withOpacity(0.35),
              width: 1,
            ),
          ),
          child: Text(
            status,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1CB040),
              letterSpacing: 0.2,
            ),
          ),
        ),
      ],
    ),
  );
}
}
