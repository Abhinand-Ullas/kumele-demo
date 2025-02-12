import 'package:flutter/material.dart';
import '../widgets/sidebar.dart';
import '../widgets/reward_rings.dart';
import '../widgets/earnings_graph.dart';

class HistoryStatisticsScreen extends StatelessWidget {
  const HistoryStatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final screenH = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Color.fromARGB(255, 240, 236, 236)),
            child: Icon(
              Icons.person_outline_rounded,
              size: 32,
            ),
          ),
          SizedBox(width: 15),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 200,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Image.asset(
            'assets/logo.png',
            height: 32,
          ),
        ),
      ),
      body: Stack(
        children: [
          // Main Content
          Row(
            children: [
              // Sidebar
              const SideBar(),

              // Main Content Area
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'History & Statistics',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Divider(
                        color: Colors.grey[300],
                        height: 1,
                      ),
                      const SizedBox(height: 32),

                      // Content Row
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Reward Rings Section
                            const Expanded(
                              flex: 1,
                              child: RewardRings(),
                            ),

                            const SizedBox(width: 48),

                            // Earnings Graph Section
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Money Earned \$905',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      _buildYearDropdown(),
                                    ],
                                  ),
                                  const SizedBox(height: 32),
                                  const Expanded(
                                    child: EarningsGraph(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Bottom Bar (aligned with SideBar width)
          Positioned(
            top: screenH *
                0.001, // Adjust this value to match the height of your AppBar
            left: 0,
            child: Container(
              width: screenW * 0.078, // Match the width of the SideBar
              height: 1, // Height of the bottom bar
              color: Colors.grey[300],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildYearDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<String>(
        dropdownColor: const Color.fromARGB(255, 240, 236, 236),
        icon: Image.asset('assets/arrow.png'),
        hint: const Text('2022'),
        underline: const SizedBox(),
        items: [
          'Jan',
          'Feb',
          'Mar',
          'Apr',
          'May',
          'Jun',
          'Jul',
          'Aug',
          'Sep',
          'Oct',
          'Nov',
          'Dec'
        ].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (_) {},
      ),
    );
  }
}
