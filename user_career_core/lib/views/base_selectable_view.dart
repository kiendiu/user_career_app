import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';

import 'base_selectable_item_view.dart';

class BaseWrapItemsSelectableView<T extends BaseSelectableItem>
    extends ConsumerStatefulWidget {
  final String title;
  final String itemPickerTitle;
  final Function(List<T> items) onAddNewItems;
  final Function(T item) onRemoveItem;
  final Future<List<T>> Function(int page)? getItems;
  final Future<List<T>> Function()? getItemsByCustomView;
  final bool isMultiSelection;
  final MetadataUpdater<Metadata>? metadataUpdater;
  List<T> items;
  final bool alwaysClearAllItemsWhenDeleteOne;
  final bool isRequired;
  final String? textPlaceHolder;
  final bool isEnable;
  final bool includeOptionAll;
  final Widget? suffixIcon;

  @override
  ConsumerState createState() => _SelectableMembersViewState<T>();

  BaseWrapItemsSelectableView({
    super.key,
    required this.title,
    required this.itemPickerTitle,
    required this.items,
    required this.onAddNewItems,
    required this.onRemoveItem,
    this.getItems,
    this.getItemsByCustomView,
    this.isMultiSelection = true,
    this.metadataUpdater,
    this.alwaysClearAllItemsWhenDeleteOne = true,
    this.isRequired = true,
    this.textPlaceHolder,
    this.isEnable = true,
    this.includeOptionAll = false,
    this.suffixIcon,
  });
}

class _SelectableMembersViewState<T extends BaseSelectableItem>
    extends ConsumerState<BaseWrapItemsSelectableView<T>> {
  List<T> _items = [];

  @override
  void initState() {
    super.initState();
    _items = widget.items.toList();
  }

  @override
  void didUpdateWidget(covariant BaseWrapItemsSelectableView<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _items = widget.items.toList();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !widget.isEnable,
      child: Container(
        // constraints: const BoxConstraints(minHeight: ),
        decoration: ShapeDecoration(
            color: widget.isEnable ? Colors.white : Colors.grey.shade200,
            shape: RoundedRectangleBorder(
                borderRadius: 20.0.borderAll(),
                side: const BorderSide(color: Color(0xFFD0D6E5)))),
        child: LayoutBuilder(builder: (context, constraints) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  VSpace.v8,
                  EasyRichText(
                    widget.isRequired ? "${widget.title} *" : widget.title,
                    defaultStyle: ref.theme.defaultTextStyle,
                    patternList: [
                      if (widget.isRequired)
                        EasyRichTextPattern(
                            targetString: "*",
                            superScript: true,
                            style: const TextStyle(
                                color: Color(0xFFFF0000), fontSize: 16)
                                .weight(FontWeight.w500),
                            hasSpecialCharacters: true)
                    ],
                  ).leftCenter().paddingOnly(left: 16, bottom: 4),
                  if (_items.isEmpty)
                    Text(
                      widget.textPlaceHolder ?? '',
                      style: ref.theme.defaultTextStyle,
                    ).paddingOnly(left: 16, top: 0),
                  if (_items.isNotEmpty)
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _items
                          .mapIndexed(
                              (index, e) => BaseSelectableMemberItemView(
                            member: e,
                            onRemove: () {
                              setState(() {
                                var mem = _items.removeAt(index);
                                widget.onRemoveItem(mem);
                              });
                            },
                          ))
                          .toList(),
                    )
                        .box(w: constraints.maxWidth - 64)
                        .paddingOnly(right: 16, left: 12),
                  VSpace.v8
                ],
              ),
              widget.suffixIcon?.paddingOnly(right: 16).rightCenter() ??
                  const Icon(
                    CupertinoIcons.chevron_down,
                    color: Colors.black87,
                    size: 16,
                  ).paddingOnly(right: 16).rightCenter(),
            ],
          ).onTapWidget(() async {
            if (widget.getItems.isNotNull) {
              context.showOverlay(
                  ItemsPicker<T>(
                    selectedItems: _items.toList(),
                    isMultiSelection: widget.isMultiSelection,
                    metadataUpdater: widget.metadataUpdater,
                    enableLoadMore: true,
                    includeOptionAll: widget.includeOptionAll,
                    padding: const EdgeInsets.only(
                        top: 0, left: 16, right: 16, bottom: 12),
                    emptyDataView: Material(
                        color: Colors.transparent,
                        child: Text(
                          L.common.emptyList,
                          style: ref.theme.mediumTextStyle,
                        )).center().paddingOnly(top: 50),
                    onLoadItems: (page) async {
                      return widget.getItems?.call(page) ?? [];
                    },
                    title: widget.itemPickerTitle,
                    onConfirmSelectSingleItem: (item) async {
                      if (widget.isMultiSelection) return;

                      await Navigator.of(context).maybePop();

                      if (widget.alwaysClearAllItemsWhenDeleteOne) {
                        _items.clear();
                      }

                      _items.add(item);
                      setState(() {});
                      widget.onAddNewItems([item]);
                    },
                    onConfirmSelectMultipleItems: (items) async {
                      if (!widget.isMultiSelection) return;

                      await Navigator.of(context).maybePop();

                      // if (items.isEmpty) return;

                      _items = items;
                      setState(() {});
                      widget.onAddNewItems(items);
                    },
                  ),
                  dismissible: true);
            } else if (widget.getItemsByCustomView.isNotNull) {
              final result = await widget.getItemsByCustomView?.call();
              _items.clear();
              _items.addAll(result ?? []);
              setState(() {});
              widget.onAddNewItems(_items);
            }
          }, radius: 12);
        }),
      ),
    );
  }
}
