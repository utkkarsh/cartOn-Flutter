import 'package:flutter/material.dart';

extension CapExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${this.substring(1)}';
  String get allInCaps => this.toUpperCase();
  String get capitalizeFirstofEach => this.split(" ").map((str) => str.inCaps).join(" ");
}


extension Iterables<E> on Iterable<E> {
  Map<K, List<E>> groupBy<K>(K Function(E) keyFunction) => fold(
      <K, List<E>>{},
          (Map<K, List<E>> map, E element) =>
      map..putIfAbsent(keyFunction(element), () => <E>[]).add(element));
}


List<Map<String, List<Map<String, String>>>> MapByKey(String keyName, String newKeyName, String keyForNewName, List<Map<String,String>> input) {
  Map<String, Map<String, List<Map<String, String>>>> returnValue = Map<String, Map<String, List<Map<String, String>>>>();
  for (var currMap in input) {
    if (currMap.containsKey(keyName)) {
      var currKeyValue = currMap[keyName];
      var currKeyValueForNewName = currMap[keyForNewName];
      if (!returnValue.containsKey(currKeyValue)){
        returnValue[currKeyValue] = {currKeyValue : List<Map<String, String>>()};
      }
      returnValue[currKeyValue][currKeyValue].add({newKeyName : currKeyValueForNewName});
    }
  }
  return returnValue.values.toList();
}


class DashSeperatorLine extends StatelessWidget {
  final double height;
  final Color color;

  const DashSeperatorLine({this.height = 1, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = 5.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }

}