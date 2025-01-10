import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/main.dart';

class CategoryProductItemWidget extends StatelessWidget {
  const CategoryProductItemWidget({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  color: Colors.white,
                ),
                width: double.infinity,
                child: Image.network(
                  "https://xeannllsijuvfdjasizd.supabase.co/storage/v1/object/sign/banner/1.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJiYW5uZXIvMS5wbmciLCJpYXQiOjE3MzYzNjI1NTUsImV4cCI6NjM5MzAxMTMzODU1NX0.4GTY5DIZnrG5z1oSG3VsvN7Qjzm_9K_hUht5UPtiL-8&t=2025-01-08T18%3A55%3A55.931Z",
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      "Chairs For Salon",
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: getResponsiveFontSize(context, fontSize: 18),
                        fontWeight: FontWeight.w600,
                      ),
                      minFontSize: 12, // Minimum font size to shrink to
                      overflow: TextOverflow
                          .ellipsis, // Optional: Truncate with ellipsis if it still overflows
                    ),
                    Text(
                      "desc desc desc desc desc desc desc desc desc desc desc",
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: getResponsiveFontSize(context, fontSize: 16),
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                      overflow: TextOverflow
                          .ellipsis, // Optional: Truncate with ellipsis if it still overflows
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Price: 100\$",
                          maxLines: 1,
                          style: TextStyle(
                            fontSize:
                                getResponsiveFontSize(context, fontSize: 18),
                            fontWeight: FontWeight.w600,
                          ),
                          // minFontSize: 10, // Minimum font size to shrink to
                          overflow: TextOverflow
                              .ellipsis, // Optional: Truncate with ellipsis if it still overflows
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black),
                          child: Text(
                            "View",
                            style: TextStyle(
                                fontSize: getResponsiveFontSize(context,
                                    fontSize: 18),
                                color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
