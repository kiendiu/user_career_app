import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';
import 'package:user_career_core/views/common_empty_list_view.dart';
import 'package:user_career_more/core/router.gm.dart';
import 'package:user_career_more/expect_certificates/controllers/certificate_controller.dart';
import 'package:user_career_more/expect_certificates/models/certificate_response.dart';

@RoutePage()
class ExpectCertificatesPage extends ConsumerStatefulWidget {
  const ExpectCertificatesPage({super.key});

  @override
  ConsumerState createState() => _ExpectCertificatesPageState();
}

class _ExpectCertificatesPageState
    extends ConsumerState<ExpectCertificatesPage> {
  final _controller = TableViewController();

  @override
  void initState() {
    super.initState();
    NotificationCenter().addObserver(
        RawStringNotificationName('reloadListCertificate'), callback: (_) {
      _controller.refresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      backgroundColor: AppColors.white3Color,
      customAppBar: AppBar(
        title: const Text(
          "Thêm chứng chỉ",
          style: TextStyle(
            color: AppColors.white1Color,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.mainColor,
        leading: const BackButton(color: AppColors.white1Color),
      ),
      fab: FloatingActionButton(
        backgroundColor: AppColors.mainColor,
        onPressed: () {
          context.pushRoute(const AddCertificateRoute());
        },
        child: const Icon(Icons.add, color: AppColors.white1Color,),
      ),
      body: ExtendedListView<CertificateResponse>(
        emptyDataSource: InfiniteListViewEmptyDataSourceBuilder(
          customEmptyViewBuilder: () => CommonEmptyListView(
            onRefresh: () {
              _controller.refresh();
            },
          )
        ),
        initialRefresh: true,
        controller: _controller,
        metadataUpdater: ref.watch(certificateControllerProvider.notifier),
        padding: EdgeInsets.zero,
        onLoadItems: (page) async {
          return ref
              .read(certificateControllerProvider.notifier)
              .getCertificates(page);
        },
        tableViewItemBuilder: (tableViewItem) {
          final experience = tableViewItem.item;
          return Container(
            decoration: BoxDecoration(
              color: AppColors.white1Color,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4.0,
                  offset: Offset(0, 2),
                ),
              ],
              border: Border.all(
                color: Colors.grey.shade300,
              ),
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      experience.certificateName ?? "",
                      style: ref.theme.bigTextStyle.weight(FontWeight.bold),
                      maxLines: 2,
                    ).paddingOnly(bottom: 5),
                  ],
                ).paddingOnly(left: 10.0).expand(),
                CupertinoMenuButton(
                  child: const Icon(Icons.menu),
                  itemsBuilder: (BuildContext context) {
                    return [
                      CupertinoMenuItem(
                          onTap: (){
                            context.pushRoute(UpdateCertificateRoute(certificateResponse: experience));
                          },
                          child: const Row(
                            children: [
                              Icon(Icons.edit),
                              SizedBox(width: 10),
                              Text("Chỉnh sửa"),
                            ],
                          )
                      ),
                      CupertinoMenuItem(
                          onTap: () {
                            ref.read(certificateControllerProvider.notifier)
                                .deleteCertificate(experience.certificateId).then((value) {
                              if(value == true){
                                _controller.refresh();
                              }
                            });
                          },
                          child: const Row(
                            children: [
                              Icon(Icons.delete, color: Colors.red),
                              SizedBox(width: 10),
                              Text("Xóa"),
                            ],
                          )
                      ),
                    ];
                  },
                ).paddingOnly(right: 10.0),
              ],
            ).marginSymmetric(horizontal: 5, vertical: 5),
          ).paddingOnly(bottom: 12);
        }
      ).paddingSymmetric(horizontal: 10.0)
          .paddingOnly(top: 10.0),
    );
  }
}
