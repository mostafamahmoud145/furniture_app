import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:furniture_app/features/products/data/models/product_model.dart';
import 'package:furniture_app/features/home/view/widgets/category_product_list_view_item.dart';

class CategoryProductsListView extends StatefulWidget {
  final String? categoryId;
  final String searchTerm;

  const CategoryProductsListView({
    super.key,
    this.categoryId,
    required this.searchTerm,
  });

  @override
  _CategoryProductsListViewState createState() =>
      _CategoryProductsListViewState();
}

class _CategoryProductsListViewState extends State<CategoryProductsListView> {
  static const _pageSize = 10;
  final PagingController<int, ProductModel> _pagingController =
      PagingController(firstPageKey: 0);

  DocumentSnapshot? _lastDocument;

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  @override
  void didUpdateWidget(covariant CategoryProductsListView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.searchTerm != widget.searchTerm) {
      _lastDocument = null; // Reset the last document
      _pagingController.refresh(); // Refresh the list
    }
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      Query query = FirebaseFirestore.instance.collection('Products');
      if (widget.categoryId != null) {
        query = query.where("categoryId", isEqualTo: widget.categoryId);
      }
      if (widget.searchTerm.isNotEmpty) {
        query = query.where("name",
            isGreaterThanOrEqualTo: widget.searchTerm,
            isLessThan: widget.searchTerm + '\uf8ff');
      }

      query = query.orderBy('id').limit(_pageSize);

      if (_lastDocument != null) {
        query = query.startAfterDocument(_lastDocument!);
      }

      QuerySnapshot snapshot = await query.get();

      final newItems = snapshot.docs
          .map((doc) =>
              ProductModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      if (snapshot.docs.isNotEmpty) {
        _lastDocument = snapshot.docs.last;
      }

      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        _pagingController.appendPage(newItems, pageKey + newItems.length);
      }
    } catch (error) {
      _pagingController.error = error;
      print("Error fetching products: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    int crossAxisCount = 2;

    if (width <= 770) {
      crossAxisCount = 2;
    } else if (width <= 1000) {
      crossAxisCount = 3;
    } else {
      crossAxisCount = 4;
    }
    return PagedSliverGrid<int, ProductModel>(
      pagingController: _pagingController,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: 5 / 6.5,
      ),
      builderDelegate: PagedChildBuilderDelegate<ProductModel>(
        itemBuilder: (context, product, index) {
          return CategoryProductItemWidget(product: product);
        },
        noItemsFoundIndicatorBuilder: (context) =>
            const Center(child: Text('No products found')),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
