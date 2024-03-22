part of '../common_widgets_imports.dart';

class CategoryWiseGraph extends StatefulWidget {
  const CategoryWiseGraph({super.key, required this.exapanses});
  final Map<String, (int, double)> exapanses;

  @override
  State<StatefulWidget> createState() => CategoryWiseGraphState();
}

class CategoryWiseGraphState extends State<CategoryWiseGraph> {
  List<BarChartGroupData> barGroups = [];
  double maxAmount = 0.0;
  @override
  void initState() {
    super.initState();
    addInGroup();
  }

  addInGroup() {
    maxAmount = 0.0;
    int idx = 0;
    barGroups = widget.exapanses.keys.map((key) {
      if (maxAmount < (widget.exapanses[key]?.$2 ?? 0.0)) {
        maxAmount = widget.exapanses[key]?.$2 ?? 0.0;
      }
      idx++;
      return BarChartGroupData(
        x: idx,
        barRods: [
          BarChartRodData(
            toY: widget.exapanses[key]?.$2 ?? 0.0,
            gradient: _barsGradient,
            width: 20,
          )
        ],
        showingTooltipIndicators: [0],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary.withOpacity(0.1),
      padding: const EdgeInsets.only(top: 25),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.6,
            child: BarChart(
              BarChartData(
                barTouchData: barTouchData,
                titlesData: titlesData,
                borderData: borderData,
                barGroups: barGroups,
                gridData: const FlGridData(show: false),
                alignment: BarChartAlignment.spaceAround,
                maxY: maxAmount + 25,
              ),
            ),
          ),
          Divider()
        ],
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 2,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              "\$${rod.toY.round().toStringAsFixed(1)}",
              const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(int id, TitleMeta meta) {
    const style = TextStyle(
      color: AppColors.textDark,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String title = (widget.exapanses.keys.toList())[id - 1];

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(title, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 35,
            getTitlesWidget: (v, t) => getTitles(v.toInt(), t),
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(show: false);

  LinearGradient get _barsGradient => const LinearGradient(
        colors: [
          AppColors.primary,
          AppColors.secondary,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );
}
