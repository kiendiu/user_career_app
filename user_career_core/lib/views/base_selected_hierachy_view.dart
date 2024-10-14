import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'base_selectable_item_view.dart';

class BaseSelectableHierarchyItem extends BaseSelectableItem {
  final int? parentId;

  BaseSelectableHierarchyItem({
    required super.id,
    this.parentId,
    required super.name,
    super.avatarFullUrl,
    super.shouldShowAvatar = false,
  });
}

class BaseSelectableHierarchyView<T extends BaseSelectableHierarchyItem>
    extends ConsumerStatefulWidget {
  final List<T> items;
  final VoidCallback onRemove;
  final int? selectedParentId;

  const BaseSelectableHierarchyView({
    super.key,
    required this.items,
    required this.onRemove,
    this.selectedParentId,
  });

  @override
  ConsumerState createState() => _SelectableHierarchyViewState<T>();
}

class _SelectableHierarchyViewState<T extends BaseSelectableHierarchyItem>
    extends ConsumerState<BaseSelectableHierarchyView<T>> {

  List<Widget> _buildHierarchyView({int? parentId, int level = 0}) {
    List<Widget> views = [];

    List<T> filteredItems = widget.items
        .where((item) => item.parentId == parentId)
        .toList();
    for (var item in filteredItems) {
      views.add(
        Padding(
          padding: EdgeInsets.only(left: 16.0 * level),
          child: BaseSelectableMemberItemView(
            member: item,
            onRemove: () => widget.onRemove(),
          ),
        ),
      );
      views.addAll(_buildHierarchyView(parentId: item.id, level: level + 1));
    }

    return views;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _buildHierarchyView(parentId: widget.selectedParentId),
    );
  }
}
