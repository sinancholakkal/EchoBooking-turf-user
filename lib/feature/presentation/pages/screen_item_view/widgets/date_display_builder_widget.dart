import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateDisplayBuilderWidget extends StatelessWidget {
  const DateDisplayBuilderWidget({
    super.key,
    required this.dateKeys,
    required this.selectedDateIndex,
  required this.selectedTimeIndex
  });

  final List<String> dateKeys;
  final ValueNotifier<int> selectedDateIndex;
  final ValueNotifier<int?> selectedTimeIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dateKeys.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              selectedDateIndex.value = index;
              selectedTimeIndex.value = null;
            },
            child: ValueListenableBuilder(
              valueListenable: selectedDateIndex,
              builder: (context, value, child) {
                return Container(
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: value == index
                        ? Colors.blue.withOpacity(0.2)
                        : Colors.transparent,
                    borderRadius:
                        BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Text(
                        DateFormat('dd MMM').format(
                            DateFormat('yyyy-MM-dd')
                                .parse(
                                    dateKeys[index])),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: value == index
                              ? Colors.blue
                              : Colors.grey,
                        ),
                      ),
                      if (value == index)
                        Container(
                          margin:
                              EdgeInsets.only(top: 4),
                          height: 4,
                          width: 20,
                          color: Colors.blue,
                        ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}