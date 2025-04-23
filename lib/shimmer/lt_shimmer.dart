import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wcycle_admin_panel/core/dimensions/device_size.dart';

class LtShimmer extends StatelessWidget {
  const LtShimmer({super.key, this.isVertical});

  final bool? isVertical;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 400,
            childAspectRatio: 1.5,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10),
        itemCount: 100,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
              baseColor: Colors.grey,
              highlightColor: Colors.white,
              child: Stack(
                children: [
                  SizedBox(
                    width: isVertical != null
                        ? (DeviceSize.getDeviceWidth(context) / 1)
                        : (DeviceSize.getDeviceWidth(context) / 2),
                    height: 140,
                    child: Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 8, top: 5),
                          clipBehavior: Clip.hardEdge,
                          width: isVertical != null
                              ? (DeviceSize.getDeviceWidth(context) / 1.10)
                              : DeviceSize.getDeviceWidth(context) / 2.5,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(.10),
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(8),
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(30),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 20,
                          left: 5,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.horizontal(
                                left: Radius.circular(5),
                                right: Radius.circular(40)),
                            child: Container(
                              color: Colors.grey,
                              height: 100,
                              width: 100,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ));
        });
  }
}
