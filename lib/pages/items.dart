import 'package:Embark_mobile/feature/models/product_models/product.dart';
import 'package:Embark_mobile/feature/services/product_api\'s.dart';
import 'package:Embark_mobile/feature/shared/email_avatar.dart';
import 'package:Embark_mobile/feature/util/product_card.dart';
import 'package:Embark_mobile/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:searchfield/searchfield.dart';

class ItemsPage extends StatefulWidget {
  const ItemsPage({super.key});

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

List<String> filters = [
  'bottles ',
  'clothings',
  'furniture',
  'electronics',
  'accessories',
  'automobile',
  'wears',
];
late String _selectedFilter;

class _ItemsPageState extends State<ItemsPage> {
  List<Product> products = [];
  List<Product> filteredProducts = [];
  List<String> productNames = [];
  bool _isGridView = true;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getProducts();
    productNames = [];
    _selectedFilter = filters[0];
  }

  Future<List<Product>> getProducts() async {
    setState(() => isLoading = true);

    await Future.delayed(const Duration(seconds: 3));

    final product = await ProductApi().fetchProducts();
    setState(() {
      products = product;
      filteredProducts = products
          .where((item) =>
              item.category == _selectedFilter.split(' ').first.toLowerCase())
          .toList();
      productNames = products.map((e) => e.description).toList();
      isLoading = false;
    });

    return products;
  }

  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Theme.of(context).colorScheme.surface,
          child: Container(
            height: 200.h,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(25.sp))),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.sp),
              child: Column(
                children: [
                  Gap(65.h),
                  Row(
                    children: [
                      // drawer icon
                      Builder(builder: (context) {
                        return GestureDetector(
                          onTap: () {
                            Scaffold.of(context).openDrawer();
                          },
                          child: Theme(
                            data: ThemeData(
                              splashColor: Colors.transparent,
                            ),
                            child: Container(
                              height: 35.h,
                              width: 35.w,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  shape: BoxShape.circle),
                              child: Icon(Icons.menu_outlined,
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                          ),
                        );
                      }),
                      Gap(15.h),
                      // title
                      Text(
                        'Inventory List',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: Colors.white, fontSize: 22),
                      ),
                      Gap(25.w),
                      // account icon
                      EmailAvatar(),
                      Gap(15.h),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isGridView = !_isGridView;
                          });
                        },
                        child: Theme(
                          data: ThemeData(
                            splashFactory: NoSplash.splashFactory,
                          ),
                          child: Container(
                            width: 90.w,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                              color: Colors.blue.shade700,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 8),
                              child: Row(
                                children: [
                                  Icon(
                                    _isGridView
                                        ? Icons.list
                                        : Icons.grid_view_outlined,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  const Gap(4),
                                  Text(
                                    _isGridView ? 'List' : 'Grid',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(15),
                  Container(
                    height: 40,
                    child: SearchField<String>(
                      onSuggestionTap: (SearchFieldListItem<String> item) {
                        setState(() {
                          filteredProducts = products
                              .where((p) => p.description
                                  .toLowerCase()
                                  .contains(item.searchKey.toLowerCase()))
                              .toList();
                        });
                      },
                      itemHeight: 40,
                      suggestions: productNames
                          .map<SearchFieldListItem<String>>(
                              (e) => SearchFieldListItem<String>(e))
                          .toList(),
                      suggestionStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                      searchInputDecoration: SearchInputDecoration(
                          searchStyle: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.normal),
                          contentPadding: EdgeInsets.only(
                              left: 15, right: 15, top: 0, bottom: 0),
                          suffixIcon: Icon(Icons.search_outlined,
                              size: 18, color: Colors.grey.shade500),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: Theme.of(context).colorScheme.surface,
                          filled: true,
                          hintText: 'Search product',
                          hintStyle: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: Colors.grey.shade500, fontSize: 16),
                          maintainHintHeight: true,
                          maintainHintSize: true),
                      marginColor: Theme.of(context).colorScheme.surface,
                      maxSuggestionsInViewPort: 8,
                      onSubmit: (String value) {
                        setState(() {
                          filteredProducts = products
                              .where((p) => p.description
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                              .toList();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          height: 70,
          decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  style: BorderStyle.none,
                  color: Colors.transparent,
                ),
                bottom: BorderSide(color: Colors.grey.shade300),
              ),
              color: Theme.of(context).colorScheme.surface,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade400,
                    spreadRadius: 2.0,
                    blurRadius: 2.0,
                    offset: Offset(0, 3)),
              ]),
          child: ListView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: filters.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedFilter = filters[index];
                      filteredProducts = products
                          .where((item) =>
                              item.category ==
                              _selectedFilter.split(' ').first.toLowerCase())
                          .toList();
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Chip(
                      backgroundColor: _selectedFilter == filters[index]
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.surface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: _selectedFilter == filters[index]
                            ? BorderSide(color: Colors.transparent)
                            : BorderSide(color: Colors.grey.shade600),
                      ),
                      label: Text('${filters[index]}'),
                      labelPadding: const EdgeInsets.symmetric(horizontal: 6),
                      labelStyle:
                          Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontSize: 16,
                                color: _selectedFilter == filters[index]
                                    ? Theme.of(context).colorScheme.surface
                                    : Theme.of(context).colorScheme.secondary,
                              ),
                    ),
                  ));
            },
          ),
        ),
        Expanded(
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: _isGridView
                      ? GridView.builder(
                          padding: EdgeInsets.only(top: 15),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 200.0,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.8,
                          ),
                          itemCount: filteredProducts.length,
                          itemBuilder: (context, index) {
                            final item = filteredProducts[index];
                            return ProductCard(
                              id: item.id,
                              imagePath: item.imagePath,
                              description: item.description,
                              price: item.price.toInt(),
                              color: getColorFromString(item.color),
                              volume: item.volume ?? '',
                              size: item.size ?? '',
                              model: item.model ?? '',
                              code: item.code,
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  PageRoutes.productDetails.name,
                                  arguments: item,
                                );
                              },
                            );
                          },
                        )
                      : ListView.builder(
                          padding: EdgeInsets.only(top: 15),
                          itemCount: filteredProducts.length,
                          itemBuilder: (context, index) {
                            final item = filteredProducts[index];
                            var style = Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary);
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0.0, vertical: 5),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                contentPadding: EdgeInsets.only(right: 10),
                                tileColor:
                                    Theme.of(context).colorScheme.surface,
                                leading: CircleAvatar(
                                  radius: 40.h,
                                  backgroundImage: AssetImage(item.imagePath),
                                ),
                                title: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item.description,
                                        style: style?.copyWith(
                                            fontSize: 16,
                                            color: getColorFromString(
                                                item.color))),
                                    Text('\$${item.code}', style: style)
                                  ],
                                ),
                                subtitle: Text('${item.volume}', style: style),
                                trailing: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('${item.id.toInt()}', style: style),
                                    Text('\$${item.price.toInt()}',
                                        style: style)
                                  ],
                                ),
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    PageRoutes.productDetails.name,
                                    arguments: item,
                                  );
                                },
                              ),
                            );
                          },
                        ),
                ),
        ),
      ],
    );
  }

  Color getColorFromString(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'red':
        return Colors.red;
      case 'blue':
        return Colors.blue;
      case 'black':
        return Colors.black;
      case 'green':
        return Colors.green;
      case 'brown':
        return Colors.brown;
      case 'gold':
        return Colors.amber;
      case 'purple':
        return Colors.purple;
      case 'blues':
        return Colors.blue.shade400;
      case 'yellow':
        return Colors.yellow;
      default:
        return Colors.black;
    }
  }
}
