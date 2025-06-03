import 'package:Embark_mobile/feature/providers/cart_provider.dart';
import 'package:Embark_mobile/feature/shared/email_avatar.dart';
import 'package:Embark_mobile/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatefulWidget {
  final Map<String, dynamic> products;
  const OrdersPage({
    super.key,
    required this.products,
  });

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  List<String> orders = [];

  List<String> status = ['pending', 'shipped', 'delivered', 'cancelled'];

  List<Map<String, dynamic>> filter = [
    {'filter': 'All'},
    {'icon': Icons.pending_actions_outlined, 'filter': 'Pending'},
    {'icon': Icons.flight_outlined, 'filter': 'Shipped'},
    {'icon': Icons.check_circle_outlined, 'filter': 'Delivered'},
  ];

  late String _selectedFilter;

  final user = FirebaseAuth.instance.currentUser;

  DateTime now = DateTime.now();
  late String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);

  @override
  void initState() {
    super.initState();
    _selectedFilter = filter[0]['filter'];
  }

  @override
  Widget build(BuildContext context) {
    final order = Provider.of<CartProvider>(context, listen: false).order;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 180.h,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(25.sp),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.sp),
                child: Column(
                  children: [
                    Gap(65.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Orders',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: Colors.white, fontSize: 22),
                        ),
                        EmailAvatar(),
                      ],
                    ),
                    Gap(15.h),
                    // Search Field
                    // Container(
                    //   height: 40.h,
                    //   child: SearchField<String>(
                    //     suggestions: orders
                    //         .map((e) => SearchFieldListItem<String>(e))
                    //         .toList(),
                    //     searchInputDecoration: SearchInputDecoration(
                    //       hint: 'Search',
                    //       maintainHintSize: 20,
                    //       searchStyle: Theme.of(context)
                    //           .textTheme
                    //           .bodyMedium
                    //           ?.copyWith(
                    //               fontSize: 14, fontWeight: FontWeight.normal),
                    //       contentPadding:
                    //           EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                    //       suffixIcon: Icon(
                    //         Icons.search_outlined,
                    //         size: 18,
                    //         color: Colors.grey.shade500,
                    //       ),
                    //       border: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(20),
                    //           borderSide: BorderSide.none),
                    //       fillColor: Theme.of(context).colorScheme.surface,
                    //       filled: true,
                    //       hintText: 'Search product',
                    //       hintStyle:
                    //           Theme.of(context).textTheme.bodyMedium?.copyWith(
                    //                 color: Colors.grey.shade500,
                    //                 fontSize: 16,
                    //               ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            Gap(15.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: filter.asMap().entries.map((entry) {
                int index = entry.key;
                var e = entry.value;
                final Color color = _selectedFilter == e['filter']
                    ? Theme.of(context).colorScheme.surface
                    : Theme.of(context).colorScheme.secondary;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedFilter = filter[index]['filter'];
                    });
                  },
                  child: Chip(
                    backgroundColor: _selectedFilter == e['filter']
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.surface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(style: BorderStyle.none),
                    ),
                    padding: EdgeInsets.all(4),
                    label: e['icon'] == null
                        ? Text(
                            e['filter'],
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: color),
                          )
                        : Row(
                            children: [
                              Icon(
                                e['icon'],
                                size: 15,
                                color: color,
                              ),
                              Gap(5),
                              Text(
                                e['filter'],
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: color),
                              ),
                            ],
                          ),
                  ),
                );
              }).toList(),
            ),
            Expanded(
                child: order.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.shopping_bag_outlined,
                                size: 80, color: Colors.grey.shade400),
                            Gap(10),
                            Text(
                              "You haven't ordered anything yet",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      fontSize: 16,
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: order.length,
                        itemBuilder: (context, index) {
                          final style = Theme.of(context).textTheme.bodySmall;
                          final orderItem = order[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5)
                                .copyWith(top: 15),
                            child: Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // order ID and status
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        orderItem['description'],
                                        style: style,
                                      ),
                                      Card(
                                        color: status[index] == 'pending'
                                            ? Colors.grey.shade300
                                            : status == 'shipped'
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .primary
                                                : status == 'delivered'
                                                    ? Colors.green
                                                    : Colors.red,
                                        margin: EdgeInsets.zero,
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              status[index],
                                              style: style?.copyWith(
                                                  fontSize: 12,
                                                  color:
                                                      status[index] == 'pending'
                                                          ? Theme.of(context)
                                                              .colorScheme
                                                              .secondary
                                                          : Theme.of(context)
                                                              .colorScheme
                                                              .surface),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Gap(10.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Order ID: #12345 ',
                                            style: style?.copyWith(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            (orderItem['model'] != null &&
                                                    orderItem['model']
                                                        .toString()
                                                        .isNotEmpty)
                                                ? 'Model: ${orderItem['model']}'
                                                : (orderItem['size'] != null &&
                                                        orderItem['size']
                                                            .toString()
                                                            .isNotEmpty)
                                                    ? 'Size: ${orderItem['size']}'
                                                    : 'Volume: ${orderItem['volume']}',
                                            style: style?.copyWith(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Gap(10.h),
                                          Text(
                                            formattedDate,
                                            style: style?.copyWith(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                          )
                                        ],
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        height: 75,
                                        color: Colors.grey.shade300,
                                        child: orderItem['imagePath'] != null &&
                                                orderItem['imagePath']
                                                    .toString()
                                                    .isNotEmpty
                                            ? Image.asset(
                                                orderItem['imagePath'],
                                                fit: BoxFit.cover,
                                              )
                                            : Icon(Icons.image_not_supported),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }))
          ],
        ),
      ),
    );
  }
}
