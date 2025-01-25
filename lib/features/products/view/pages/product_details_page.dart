import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/features/home/view/components/app_bar/custom_app_bar.dart';
import 'package:furniture_app/features/home/view/widgets/footer.dart';
import 'package:furniture_app/features/products/data/models/product_model.dart';
import 'package:furniture_app/features/products/view_model/get_product_cubit/get_product_cubit.dart';
import 'package:furniture_app/main.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: BlocBuilder<GetProductCubit, GetProductState>(
          builder: (context, state) {
            ProductModel? productModel;
            if (state is GetProductSuccess) {
              productModel = state.product;
            }
            return Column(
              children: [
                /// <--- AppBar --->
                const CustomAppBar(),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: (MediaQuery.sizeOf(context).width * 0.025)
                          .clamp(20, 50)),
                  child: Center(
                    child: Column(
                      children: [
                        MediaQuery.sizeOf(context).width < 800
                            ? Column(children: [
                                Skeletonizer(
                                    enabled: state is GetProductLoading,
                                    child: OrderImagesWidget(
                                      product: productModel,
                                    )),
                                Skeletonizer(
                                  enabled: state is GetProductLoading,
                                  child: OrderDetailsWidget(
                                    productModel: productModel,
                                  ),
                                ),
                              ])
                            : Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.sizeOf(context).width *
                                            0.01),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Skeletonizer(
                                          enabled: state is GetProductLoading,
                                          child: OrderImagesWidget(
                                            product: productModel,
                                          )),
                                    ),
                                    const SizedBox(width: 30),
                                    Expanded(
                                      child: Skeletonizer(
                                          enabled: state is GetProductLoading,
                                          child: OrderDetailsWidget(
                                            productModel: productModel,
                                          )),
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
            );
          },
        ),
      ),
    );
  }
}

class OrderImagesWidget extends StatefulWidget {
  const OrderImagesWidget({super.key, this.product});

  final ProductModel? product;

  @override
  State<OrderImagesWidget> createState() => _OrderImagesWidgetState();
}

class _OrderImagesWidgetState extends State<OrderImagesWidget> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    Future.delayed(const Duration(seconds: 3)).then((_) {
      if (mounted) {
        setState(() {
          _currentIndex =
              (_currentIndex + 1) % (widget.product?.images.length ?? 1);
          _pageController.animateToPage(
            _currentIndex,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        });
        _startAutoScroll();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> images = widget.product?.images ?? [];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          // Main image display
          SizedBox(
            height: MediaQuery.sizeOf(context).width < 800
                ? MediaQuery.sizeOf(context).width * 0.4
                : (MediaQuery.sizeOf(context).width * 0.4).clamp(200, 500),
            child: PageView.builder(
              controller: _pageController,
              itemCount: images.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: FadeInImage.assetNetwork(
                      image: images[index],
                      fit: BoxFit.contain,
                      placeholder: "assets/icons/loading.gif",
                      placeholderFit: BoxFit.contain,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Image.asset("assets/icons/loading.gif"),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 15),
          // Small images displayed in a grid
          SizedBox(
            // width: width,
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: widget.product != null
                    ? 4
                    : 4, // Display 4 small images in a single row
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1 / 1,
              ),
              itemCount: images.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentIndex = index;
                      _pageController.jumpToPage(index);
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: FadeInImage.assetNetwork(
                        image: images[index],
                        fit: BoxFit.fill,
                        width: double.infinity,
                        placeholder: "assets/icons/loading.gif",
                        placeholderFit: BoxFit.contain,
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Image.asset("assets/icons/loading.gif"),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class OrderDetailsWidget extends StatelessWidget {
  const OrderDetailsWidget({
    super.key,
    this.productModel,
  });

  final ProductModel? productModel;

  @override
  Widget build(BuildContext context) {
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
                "${productModel?.name}",
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
                "${productModel?.description}",
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: getResponsiveFontSize(context, fontSize: 14),
                ),
              ),
            ],
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(
          //     vertical: 10,
          //   ),
          //   child: Divider(color: Colors.grey[200]),
          // ),
          // Text(
          //   "Price: ${productModel?.price}\$",
          //   style: TextStyle(
          //     fontSize: getResponsiveFontSize(context, fontSize: 16),
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: Divider(color: Colors.grey[200]),
          ),
          Text(
            "Product Code: ${productModel?.productCode}",
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
            "Colors:",
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: getResponsiveFontSize(context, fontSize: 14),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            // height: 50,
            child: Wrap(
              spacing: 10, // Horizontal spacing between items
              runSpacing: 10, // Vertical spacing if needed (optional)
              children: List.generate(
                  productModel?.imageColors.length ?? 4, // Number of items
                  (index) {
                Map<String, dynamic> color = productModel != null
                    ? productModel!.imageColors[index]
                    : {};
                return Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    color: productModel != null
                        ? Color.fromARGB(
                            color['a'], color['r'], color['g'], color['b'])
                        : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(5),
                  ),
                );
              }),
            ),
          ),

          /// <--- Vertical spacing --->
          const SizedBox(
            height: 50,
          ),

          WhatsAppButton(
              phoneNumber: '+201068811722',
              productDetailsMessage:
                  'hello i want to ask about this product ${productModel?.productCode}'),

          /// <--- Vertical spacing --->
          SizedBox(
            height: MediaQuery.sizeOf(context).width > 800 ? 40 : 20,
          ),
        ],
      ),
    );
  }
}

class WhatsAppButton extends StatelessWidget {
  final String phoneNumber; // WhatsApp number
  final String productDetailsMessage; // Message to send

  const WhatsAppButton({
    super.key,
    required this.phoneNumber,
    required this.productDetailsMessage,
  });

  void _openWhatsAppChat() async {
    final Uri whatsappUrl = Uri.parse(
        'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(productDetailsMessage)}');
    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    } else {
      // Handle error (e.g., WhatsApp not installed)
      debugPrint('Could not open WhatsApp');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: _openWhatsAppChat,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            const Color.fromARGB(255, 33, 158, 37), // WhatsApp's color
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      icon: Image.asset(
        "assets/icons/whatsapp.png",
        // color: Colors.white,
        height: 40,
        width: 40,
      ),
      label: Text(
        "Contact on WhatsApp to ask for more details",
        style: TextStyle(
            color: Colors.white,
            fontSize: getResponsiveFontSize(context, fontSize: 16)),
      ),
    );
  }
}
