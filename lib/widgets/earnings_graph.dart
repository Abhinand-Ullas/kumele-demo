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
    return Expanded(
      child: BarChart(
        BarChartData(
          maxY: 100,
          minY: 0,
          alignment: BarChartAlignment.spaceAround,
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
                    'Mar',
                    'Apr',
                    'May',
                    'Jun',
                    'Jul',
                    'Aug',
                    'Sep',
                    'Oct',
                    'Nov'
                  ];
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      months[value.toInt()],
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          gridData: FlGridData(show: false),
          barGroups: [
            _generateBarGroup(0, 80),
            _generateBarGroup(1, 60),
            _generateBarGroup(2, 90),
            _generateBarGroup(3, 75),
            _generateBarGroup(4, 40),
            _generateBarGroup(5, 95),
            _generateBarGroup(6, 65),
            _generateBarGroup(7, 85),
            _generateBarGroup(8, 70),
          ],
        ),
      ),
    );
  }

  BarChartGroupData _generateBarGroup(int x, double value, [Color? color]) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: value,
          color: color ?? (touchedIndex == x ? Colors.amber : Colors.blue),
          width: 16,
          borderRadius: BorderRadius.circular(2),
        ),
      ],
    );
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
