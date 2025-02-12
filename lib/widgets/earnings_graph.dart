import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class EarningsGraph extends StatefulWidget {
  const EarningsGraph({super.key});

  @override
  State<EarningsGraph> createState() => _EarningsGraphState();
}

class _EarningsGraphState extends State<EarningsGraph> {
  int? touchedIndex;

  @override
  Widget build(BuildContext context) {
    // Get the screen width
    final screenWidth = MediaQuery.of(context).size.width;

    // Define responsive values
    const numberOfBars = 12; // Total number of bars
    const minBarWidth = 20.0; // Minimum width of each bar
    const maxBarWidth = 30.0; // Maximum width of each bar
    const minBarSpacing = 8.0; // Minimum spacing between bars
    const maxBarSpacing = 16.0; // Maximum spacing between bars
    const minPadding = 16.0; // Minimum padding at the start and end
    const maxPadding = 32.0; // Maximum padding at the start and end

    // Calculate responsive bar width, spacing, and padding
    final barWidth = _responsiveValue(screenWidth, minBarWidth, maxBarWidth);
    final barSpacing = _responsiveValue(screenWidth, minBarSpacing, maxBarSpacing);
    final startPadding = _responsiveValue(screenWidth, minPadding, maxPadding);
    final endPadding = _responsiveValue(screenWidth, minPadding, maxPadding);

    // Total width required for the chart
    final totalWidth =
        (barWidth + barSpacing) * (numberOfBars - 1) + barWidth + startPadding + endPadding;

    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal, // Enable horizontal scrolling
        child: SizedBox(
          width: totalWidth > screenWidth ? totalWidth : screenWidth, // Use the larger of the two widths
          child: Padding(
            padding: EdgeInsets.only(left: startPadding, right: endPadding), // Apply start and end padding
            child: BarChart(
              BarChartData(
                maxY: 100,
                minY: 0,
                alignment: BarChartAlignment.start, // Use start alignment for manual spacing
                groupsSpace: barSpacing, // Set the spacing between bars
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    tooltipBgColor: Colors.white,
                    tooltipRoundedRadius: 8,
                    tooltipBorder: BorderSide(color: Colors.grey[300]!),
                    tooltipPadding: EdgeInsets.zero,
                    tooltipMargin: 8,
                    direction: TooltipDirection.top, // Show tooltip above the bar
                    fitInsideHorizontally: true,
                    fitInsideVertically: true,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      // Return text-based tooltip only for the value of the bar
                      return BarTooltipItem(
                        'Group meditation | 90\'s Hip-Hop',
                        const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      );
                    },
                  ),
                  touchCallback: (FlTouchEvent event, barTouchResponse) {
                    setState(() {
                      if (barTouchResponse?.spot != null) {
                        touchedIndex = barTouchResponse!.spot!.touchedBarGroupIndex;
                      } else {
                        touchedIndex = -1;
                      }
                    });
                  },
                  handleBuiltInTouches: true,
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) {
                        const months = [
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
                        ];
                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            months[value.toInt()],
                            style: const TextStyle(fontSize: 12, color: Color.fromARGB(236, 0, 0, 0)),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                gridData: FlGridData(show: false),
                barGroups: [
                  _generateBarGroup(0, 40, barWidth),
                  _generateBarGroup(1, 37, barWidth),
                  _generateBarGroup(2, 40, barWidth),
                  _generateBarGroup(3, 30, barWidth),
                  _generateBarGroup(4, 50, barWidth),
                  _generateBarGroup(5, 35, barWidth),
                  _generateBarGroup(6, 20, barWidth),
                  _generateBarGroup(7, 60, barWidth),
                  _generateBarGroup(8, 30, barWidth),
                  _generateBarGroup(9, 60, barWidth),
                  _generateBarGroup(10, 32, barWidth),
                  _generateBarGroup(11, 25, barWidth),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  BarChartGroupData _generateBarGroup(int x, double value, double barWidth, [Color? color]) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: value,
          color: color ?? (touchedIndex == x ? Colors.amber : const Color.fromARGB(255, 45, 88, 244)),
          width: barWidth, // Use the responsive bar width
          borderRadius: BorderRadius.circular(5),
        ),
      ],
    );
  }

  // Helper function to calculate responsive values
  double _responsiveValue(double screenWidth, double minValue, double maxValue) {
    const minScreenWidth = 300.0; // Minimum screen width for responsiveness
    const maxScreenWidth = 1200.0; // Maximum screen width for responsiveness

    // Clamp the screen width within the min and max range
    final clampedWidth = screenWidth.clamp(minScreenWidth, maxScreenWidth);

    // Map the clamped width to the desired value range
    return ((clampedWidth - minScreenWidth) / (maxScreenWidth - minScreenWidth)) *
            (maxValue - minValue) +
        minValue;
  }
}

class DashedLineVerticalPainter extends CustomPainter {
  final Color color;
  DashedLineVerticalPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;
    const dashHeight = 4;
    const dashSpace = 4;
    double startY = 0;
    while (startY < size.height) {
      canvas.drawLine(
        Offset(0, startY),
        Offset(0, startY + dashHeight),
        paint,
      );
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}