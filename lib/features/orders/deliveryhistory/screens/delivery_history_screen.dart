import 'package:delivery_app/data/models/model.dart';
import 'package:delivery_app/features/orders/deliveryhistory/screens/delivery_controller.dart';
import 'package:delivery_app/core/widgets/deliveryhistorywidgets/empty_state.dart';
import 'package:delivery_app/features/orders/deliveryhistory/dialog/fliter_sheet.dart';
import 'package:delivery_app/core/widgets/deliveryhistorywidgets/order_card.dart';
import 'package:delivery_app/features/orders/deliveryhistory/dialog/order_details_dialog.dart';
import 'package:delivery_app/features/orders/deliveryhistory/dialog/search_dialog.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/core/widgets/deliveryhistorywidgets/filter_chip.dart';
class DeliveryHistoryScreen extends StatefulWidget {
  const DeliveryHistoryScreen({super.key});

  @override
  State<DeliveryHistoryScreen> createState() => _DeliveryHistoryScreenState();
}

class _DeliveryHistoryScreenState extends State<DeliveryHistoryScreen> {
  final DeliveryHistoryController _controller = DeliveryHistoryController();

  @override
  void initState() {
    super.initState();
    _controller.applyDateFilter('Today');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final displayOrders = _controller.getOrdersForDisplay();
    final paddingHorizontal = size.width * 0.04;
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 22, 120, 200),
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Delivery History',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: size.width * 0.045,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.calendar_month,
                      color: Colors.white,
                      size: size.width * 0.06,
                    ),
                    onPressed: () => _selectDateRange(context),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: size.width * 0.06,
                    ),
                    onPressed: () => _showSearchDialog(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(paddingHorizontal),
          child: Column(
            children: [
              _buildTimeFilters(),
              SizedBox(height: size.height * 0.01),
              _buildFilterButton(),
              if (_controller.searchQuery.isNotEmpty)
                _buildSearchQueryIndicator(),
              SizedBox(height: size.height * 0.02),
              
              // Content area
              displayOrders.isEmpty
                ? const Expanded(child: EmptyState())
                : Expanded(
                    child: ListView.builder(
                      itemCount: displayOrders.length,
                      itemBuilder: (context, index) {
                        return OrderCard(
                          order: displayOrders[index],
                          onViewDetails: () => _viewOrderDetails(context, displayOrders[index]),
                        );
                      },
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeFilters() {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.05,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FliteredChip(
                  label: 'Today', 
                  icon: Icons.access_time,
                  isSelected: _controller.selectedTimeFilter == 'Today',
                  onTap: () => setState(() => _controller.applyDateFilter('Today')),
                ),
                SizedBox(width: size.width * 0.02),
                FliteredChip(
                  label: 'This Week', 
                  icon: Icons.calendar_today,
                  isSelected: _controller.selectedTimeFilter == 'This Week',
                  onTap: () => setState(() => _controller.applyDateFilter('This Week')),
                ),
                SizedBox(width: size.width * 0.02),
                FliteredChip(
                  label: 'Custom', 
                  icon: Icons.date_range,
                  isSelected: _controller.selectedTimeFilter == 'Custom',
                  onTap: () => _selectDateRange(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton() {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton.icon(
          icon: Icon(Icons.filter_list, size: size.width * 0.035),
          label: Text(
            'Filter',
            style: TextStyle(fontSize: size.width * 0.035),
          ),
          onPressed: () => _showFilterBottomSheet(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(size.width * 0.04),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.03,
              vertical: size.height * 0.01,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchQueryIndicator() {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: size.height * 0.015),
      child: Row(
        children: [
          Text(
            'Search: ',
            style: TextStyle(fontSize: size.width * 0.035),
          ),
          Expanded(
            child: Text(
              _controller.searchQuery,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: size.width * 0.035,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                _controller.searchQuery = '';
              });
            },
            child: Icon(
              Icons.close,
              size: size.width * 0.04,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      initialDateRange: DateTimeRange(
        start: _controller.startDate ?? DateTime.now().subtract(const Duration(days: 7)),
        end: _controller.endDate ?? DateTime.now(),
      ),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.indigo,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _controller.setCustomDateRange(picked.start, picked.end);
      });
    }
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return SearchDialog(
          initialQuery: _controller.searchQuery,
          onSearch: (query) {
            setState(() {
              _controller.searchQuery = query;
            });
          },
        );
      },
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return FilterBottomSheet(
          statusFilters: _controller.statusFilters,
          selectedStatusFilter: _controller.selectedStatusFilter,
          onApply: (status) {
            setState(() {
              _controller.selectedStatusFilter = status;
            });
          },
        );
      },
    );
  }

  void _viewOrderDetails(BuildContext context, OrderDisplayModel order) {
    showDialog(
      context: context,
      builder: (context) {
        return OrderDetailsDialog(order: order);
      },
    );
  }
}