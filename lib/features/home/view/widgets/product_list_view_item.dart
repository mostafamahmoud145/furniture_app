import 'package:flutter/material.dart';
import 'package:furniture_app/main.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({
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
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 80),
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)),
                        color: Colors.white,
                      ),
                      width: double.infinity,
                    ),
                  ),
                  Image.asset(
                    imageUrl,
                    fit: BoxFit.fitHeight,
                    width: double.infinity,
                    height: 400,
                  ),
                ],
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
                    Text(
                      "Chairs For Salon",
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: getResponsiveFontSize(context, fontSize: 20),
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow
                          .ellipsis, // Optional: Truncate with ellipsis if it still overflows
                    ),
                    Text(
                      "desc desc desc desc desc desc desc desc desc desc desc",
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: getResponsiveFontSize(context, fontSize: 18),
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
                          overflow: TextOverflow
                              .ellipsis, // Optional: Truncate with ellipsis if it still overflows
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black),
                          child: Text(
                            "View",
                            style: TextStyle(
                                fontSize: getResponsiveFontSize(context,
                                    fontSize: 20),
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
