import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:wcycle_admin_panel/api/apis.dart';
import 'package:wcycle_admin_panel/config/theme/app_color.dart';
import 'package:wcycle_admin_panel/model/littered_model.dart';
import 'package:wcycle_admin_panel/widgets/littered_list_item_info.dart';

final apis = Apis();

class LitteredListItem extends StatelessWidget {
  const LitteredListItem(
      {super.key, required this.ltListModel, this.isVertical});

  final LitteredModel ltListModel;
  final bool? isVertical;

  @override
  Widget build(BuildContext context) {
    final imgSrc = ltListModel.ltSrc;
    return Stack(
      children: [
        InkWell(
          onTap: () {
            /*Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LitteredSpotDetails(
                  ltData: ltListModel,
                ),
              ));*/
          },
          child: SizedBox(
            width: 400,
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                Container(
                    margin: const EdgeInsets.only(left: 58, top: 5),
                    clipBehavior: Clip.hardEdge,
                    width: 400,
                    decoration: const BoxDecoration(
                      color: AppColor.kSixthColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8),
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: LitteredListItemInfo(
                      ltList: ltListModel,
                      isVertical: isVertical,
                    )),
                Positioned(
                  left: 5,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(5), right: Radius.circular(40)),
                    child: FadeInImage.memoryNetwork(
                      fit: BoxFit.cover,
                      placeholder: kTransparentImage,
                      image: imgSrc,
                      height: 150,
                      width: 120,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
