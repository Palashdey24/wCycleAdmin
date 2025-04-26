import 'package:flutter/material.dart';
import 'package:wcycle_admin_panel/config/theme/app_color.dart';
import 'package:wcycle_admin_panel/config/theme/app_font.dart';
import 'package:wcycle_admin_panel/model/news_model.dart';
import 'package:wcycle_admin_panel/utlits/style.dart';

class CarouselCard extends StatelessWidget {
  const CarouselCard({super.key, required this.newsModel});

  final NewsModel newsModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColor.kDarkColor,
      clipBehavior: Clip.hardEdge,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(5),
          right: Radius.circular(30),
        ),
      ),
      child: Row(
        children: [
          Flexible(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              spacing: csGap,
              children: [
                Text(
                  newsModel.newsTittle!,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style:
                      AppFont.textSmall(context).copyWith(color: Colors.white),
                ),
                Text(
                  style: AppFont.textMedium(context),
                  maxLines: 3,
                  newsModel.newsDescription!,
                ),
                TextButton(
                    onPressed: () {},
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Card(
                        color: Colors.orange,
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(normalGap),
                          child: Text(
                            newsModel.linkType!,
                            style: AppFont.textMedium(context)
                                .copyWith(color: Colors.yellowAccent),
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(5), right: Radius.circular(30)),
              child: Image.network(
                fit: BoxFit.fill,
                newsModel.ltSrc!,
                height: double.infinity,
                width: double.infinity,
              ),
            ),
          )
        ],
      ),
    );
  }
}
