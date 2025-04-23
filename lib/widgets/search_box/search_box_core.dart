import 'package:flutter/material.dart';
import 'package:wcycle_admin_panel/config/theme/app_color.dart';
import 'package:wcycle_admin_panel/core/dimensions/app_gap.dart';

class SearchBoxCore extends StatelessWidget {
  const SearchBoxCore({super.key, this.filterIncluder});
  final bool? filterIncluder;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Flex(
        direction: Axis.horizontal,
        spacing: AppGap.kNormalGap,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.kDarkColor.withValues(alpha: 0.8),
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(13.0),
                  bottomLeft: Radius.circular(13.0),
                  topLeft: Radius.circular(13.0),
                  topRight: Radius.circular(13.0),
                ),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: TextFormField(
                        onTapOutside: (event) =>
                            FocusScope.of(context).unfocus(),
                        style: const TextStyle(
                          fontFamily: 'WorkSans',
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                          color: AppColor.kSecondColor,
                        ),
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: 'Search',
                          border: InputBorder.none,
                          helperStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: AppColor.kDarkColor,
                          ),
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            letterSpacing: 0.2,
                            color: Colors.white,
                          ),
                        ),
                        onEditingComplete: () {},
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 54,
                    height: 54,
                    child: Icon(Icons.search, color: Colors.blueGrey),
                  ),
                ],
              ),
            ),
          ),
          if (filterIncluder == true)
            CircleAvatar(
                backgroundColor: AppColor.kDarkColor.withValues(alpha: 0.3),
                child: IconButton(
                    onPressed: () {}, icon: const Icon(Icons.filter_alt)))
        ],
      ),
    );
  }
}
