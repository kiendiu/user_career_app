import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';

@RoutePage()
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          TextField(
            decoration: InputDecoration(
              hintText: 'Tìm kiếm...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              fillColor: Colors.grey[200],
              filled: true,
            ),
          ),
          SizedBox(height: 20),

          // Các buổi tư vấn sắp tới
          Text(
            'Các buổi tư vấn sắp tới',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Expanded(
            flex: 2,
            child: ListView.builder(
              itemCount: 5, // Số lượng buổi tư vấn
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: Icon(Icons.calendar_today),
                    title: Text('Buổi tư vấn ${index + 1}'),
                    subtitle: Text('Chi tiết buổi tư vấn'),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),

          // Danh mục (scroll ngang)
          Text(
            'Danh mục',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Container(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5, // Số lượng danh mục
              itemBuilder: (context, index) {
                return Container(
                  width: 120,
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blueAccent,
                  ),
                  child: Center(
                    child: Text(
                      'Danh mục ${index + 1}',
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),

          // Danh sách chuyên gia hot tháng
          Text(
            'Chuyên gia hot tháng',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Expanded(
            flex: 3,
            child: ListView.builder(
              itemCount: 5, // Số lượng chuyên gia
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      child: Text('H${index + 1}'),
                    ),
                    title: Text('Chuyên gia ${index + 1}'),
                    subtitle: Text('Lĩnh vực chuyên môn'),
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
