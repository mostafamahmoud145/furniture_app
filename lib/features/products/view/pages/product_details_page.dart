import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:furniture_app/features/home/view/components/app_bar/custom_app_bar.dart';
import 'package:furniture_app/features/home/view/widgets/footer.dart';
import 'package:furniture_app/main.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal:
                      (MediaQuery.sizeOf(context).width * 0.025).clamp(20, 50)),
              child: Center(
                child: Column(
                  children: [
                    /// <--- AppBar --->
                    const CustomAppBar(),

                    /// <--- Vertical spacing --->
                    const SizedBox(height: 40),

                    MediaQuery.sizeOf(context).width < 800
                        ? const Column(children: [
                            OrderImagesWidget(),
                            OrderDetailsWidget(),
                          ])
                        : Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.sizeOf(context).width * 0.01),
                            child: const Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: OrderImagesWidget(),
                                ),
                                SizedBox(width: 30),
                                Expanded(
                                  child: OrderDetailsWidget(),
                                ),
                              ],
                            ),
                          ),
                  ],
                ),
              ),
            ),

            /// <--- Vertical spacing --->
            SizedBox(
              height: MediaQuery.sizeOf(context).width > 800 ? 40 : 20,
            ),

            const Footer(),
          ],
        ),
      ),
    );
  }
}

class OrderImagesWidget extends StatelessWidget {
  const OrderImagesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double height =
        (MediaQuery.sizeOf(context).width * 0.4).clamp(200, 500);
    final double width = height * (1.4 / 1);
    return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: SizedBox(
                height: MediaQuery.sizeOf(context).width < 800
                    ? null
                    : (MediaQuery.sizeOf(context).width * 0.4).clamp(200, 500),
                child: AspectRatio(
                  aspectRatio: 1.4 / 1,
                  child: Image.asset(
                    "images/test.jpg",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: width,
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      "images/test.jpg",
                      fit: BoxFit.fill,
                    ),
                  );
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 1 / 1,
                ),
              ),
            ),
          ],
        ));
  }
}

class OrderDetailsWidget extends StatelessWidget {
  const OrderDetailsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<Color> colors = [
      Colors.black,
      Colors.brown,
      Colors.grey,
      Colors.white
    ];
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Product Name :",
                style: TextStyle(
                  fontSize: getResponsiveFontSize(context, fontSize: 18),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Workspace office Chair",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: getResponsiveFontSize(context, fontSize: 16),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: Divider(color: Colors.grey[200]),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Description :",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: getResponsiveFontSize(context, fontSize: 18),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Workspace office Chair Workspace office Chair Workspace office Chair Workspace office Chair office",
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: getResponsiveFontSize(context, fontSize: 14),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: Divider(color: Colors.grey[200]),
          ),
          Text(
            "Price: 100\$",
            style: TextStyle(
              fontSize: getResponsiveFontSize(context, fontSize: 16),
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: Divider(color: Colors.grey[200]),
          ),
          Text(
            "Product Code: AB55",
            style: TextStyle(
              fontSize: getResponsiveFontSize(context, fontSize: 16),
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: Divider(color: Colors.grey[200]),
          ),
          Text(
            "Color: Black",
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: getResponsiveFontSize(context, fontSize: 14),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 50,
            child: Wrap(
              spacing: 10, // Horizontal spacing between items
              runSpacing: 10, // Vertical spacing if needed (optional)
              children: List.generate(
                4, // Number of items
                (index) => Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    color: colors[index],
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
