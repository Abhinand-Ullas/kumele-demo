import 'package:flutter/material.dart';
import '../widgets/sidebar.dart';
import '../widgets/reward_rings.dart';
import '../widgets/earnings_graph.dart';

class HistoryStatisticsScreen extends StatelessWidget {
  const HistoryStatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
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
      body: Row(
        children: [
          // Sidebar
          const SideBar(),
          
          // Padding Area between Sidebar and Main Body
          Container(
            width: 16, // Adjust width as needed
            color: Colors.grey[300],
          ),
          
          // Main Content
          Expanded(
            child: Column(
              children: [
                // Padding Area between AppBar and Main Body (excluding Sidebar)
                Container(
                  height: 16, // Adjust height as needed
                  color: Colors.grey[300],
                ),
                
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(32.0),
                    color: Colors.white,
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
                              const Flexible(
                                flex: 1,
                                child: RewardRings(),
                              ),
                              const SizedBox(width: 48),
                              // Earnings Graph Section
                              Flexible(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const Text(
                                              'Money Earned ',
                                              style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const Text('\$905',style: TextStyle(
                                              fontSize: 24,
                                                fontWeight: FontWeight.bold
                                            ),)
                                          ],
                                        ),
                                        _buildYearDropdown(),
                                      ],
                                    ),
                                    const SizedBox(height: 32),
                                    SizedBox(
                                      height: 300,
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
          ),

          // Right Padding Area (Move this outside the Expanded column)
          Container(
            width: 16, // Adjust width as needed
            color: Colors.grey[300],
          ),
        ],
      ),
    );
  }

  Widget _buildYearDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: const Color.fromARGB(251, 236, 235, 235),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<String>(
        dropdownColor: const Color.fromARGB(255, 255, 255, 255),
        icon: Image.asset('assets/arrow.png'),
        hint: Padding(
          padding: const EdgeInsets.only(right:3.0),
          child: const Text('2022',style: TextStyle(fontWeight: FontWeight.bold),),
        ),
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
