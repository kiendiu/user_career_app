import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';

@RoutePage()
class RequestPage extends ConsumerStatefulWidget {
  const RequestPage({super.key});

  @override
  ConsumerState createState() => _RequestPageState();
}

class _RequestPageState extends ConsumerState<RequestPage> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  bool _isOngoing = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      customAppBar: AppBar(
        title: Text(
            'Yêu cầu dịch vụ',
            style: const TextStyle(
                color: AppColors.white1Color,
                fontWeight: FontWeight.w500).size(20)
        ),
        backgroundColor: AppColors.main1Color,
        bottom: TabBar(
          labelStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
          labelColor: AppColors.white1Color,
          unselectedLabelColor: AppColors.white1Color.withOpacity(0.6),
          indicatorColor: AppColors.white1Color,
          controller: _tabController,
          tabs: const [
            Tab(text: 'Dịch vụ'),
            Tab(text: 'Của tôi'),
            Tab(text: 'Chào giá'),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Center(
            child: ToggleButtons(
              isSelected: [_isOngoing, !_isOngoing],
              onPressed: (int index) {
                setState(() {
                  _isOngoing = index == 0;
                });
              },
              selectedColor: AppColors.white1Color,
              color: AppColors.black1Color,
              fillColor: AppColors.main1Color,
              borderColor: AppColors.main1Color,
              selectedBorderColor: AppColors.main1Color,
              borderRadius: BorderRadius.circular(8),
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Đang diễn ra'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Đã kết thúc'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildRequestListView('Yêu cầu dịch vụ'),
                _buildRequestListView('Yêu cầu của tôi'),
                _buildRequestListView('Yêu cầu chào giá'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestListView(String type) {
    final requests = List.generate(
      10, (index) => 'Yêu cầu $type ${index + 1} - ${_isOngoing ? 'Đang diễn ra' : 'Đã kết thúc'}',
    );

    return Container(
      color: AppColors.white3Color,
      child: ListView.builder(
        itemCount: requests.length,
        itemBuilder: (context, index) {
          return Card(
            color: AppColors.white1Color,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(requests[index]),
              subtitle: const Text('Chi tiết yêu cầu...'),
            ),
          );
        },
      ),
    );
  }
}