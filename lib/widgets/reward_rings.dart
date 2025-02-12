import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class RewardRings extends StatefulWidget {
  const RewardRings({super.key});

  @override
  State<RewardRings> createState() => _RewardRingsState();
}

class _RewardRingsState extends State<RewardRings>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    // Define the swinging animation (tilting 30 degrees left and right)
    _animation = Tween<double>(begin: -0.05, end: 0.05)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Start the swinging animation
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    // Dispose the animation controller when the widget is removed
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Reward Rings',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 10),

            // Swinging Icon
            RotationTransition(
              turns: _animation,
              child: Image.asset('assets/badge.png'),
            ),
          ],
        ),
        const SizedBox(height: 32),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: SizedBox(
                height: 240,
                child: PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        value: 33.33,
                        color: const Color.fromARGB(255, 225, 137, 4),
                        title: '',
                        radius: 80,
                      ),
                      PieChartSectionData(
                        value: 33.33,
                        color: Colors.grey,
                        title: '',
                        radius: 80,
                      ),
                      PieChartSectionData(
                        value: 33.33,
                        color: const Color.fromARGB(255, 227, 172, 7),
                        title: '',
                        radius: 80,
                      ),
                    ],
                    sectionsSpace: 0,
                    centerSpaceRadius: 0,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildLegendItem('Gold', Colors.amber, '22 medals'),
                    const SizedBox(height: 16),
                    _buildLegendItem('Silver', Colors.grey, '1 medal'),
                    const SizedBox(height: 16),
                    _buildLegendItem('Bronze', Colors.orange, '1 medal'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLegendItem(String title, Color color, String count) {
    return Row(
      children: [
        // Color Circle
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),

        // Title
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),

        // Count
        Text(
          count,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),

        const SizedBox(width: 8),

        // Info Icon
        IconButton(
          icon: const Icon(Icons.info),
          onPressed: () {
            // Add your onPressed logic here
            print('Info icon pressed for $title');
          },
          padding: EdgeInsets.zero, // Remove default padding
          constraints: const BoxConstraints(), // Remove default constraints
        ),
      ],
    );
  }
}
