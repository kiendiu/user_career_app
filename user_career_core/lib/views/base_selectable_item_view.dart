import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_career_core/user_career_core.dart';


abstract class BaseSelectableItem extends StandardIDComparableEntity
    with ItemPickerCompatible {
  final String? name;
  final String? avatarFullUrl;

  @override
  String get title => name ?? "-";

  bool _isSelected = false;
  final bool _shouldShowAvatar;

  @override
  bool get isSelected => _isSelected;

  bool get shouldShowAvatar => _shouldShowAvatar;

  @override
  set isSelected(bool value) {
    _isSelected = value;
  }

  BaseSelectableItem(
      {super.id, this.name, this.avatarFullUrl, bool shouldShowAvatar = false})
      : _shouldShowAvatar = shouldShowAvatar;
}

class BaseSelectableItemModel<T> extends BaseSelectableItem {
  final T data;

  BaseSelectableItemModel(
      {required this.data,
        required super.id,
        required super.name,
        super.shouldShowAvatar,
        super.avatarFullUrl});
}

class BaseSelectableMemberItemView<T extends BaseSelectableItem>
    extends ConsumerStatefulWidget {
  final T member;
  final VoidCallback onRemove;

  @override
  ConsumerState createState() => _SelectableMemberItemViewState();

  const BaseSelectableMemberItemView({
    super.key,
    required this.member,
    required this.onRemove,
  });
}

class _SelectableMemberItemViewState
    extends ConsumerState<BaseSelectableMemberItemView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 32,
      decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(borderRadius: 8.0.borderAll()),
          color: AppColors.white3Color),
      child: IntrinsicWidth(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HSpace.h8,
            if (widget.member.shouldShowAvatar) ...[
              ImageView(
                url: widget.member.avatarFullUrl ?? "",
                fit: BoxFit.cover,
                radius: 10,
                placeholder: BaseDefaultAvatarView(
                  name: widget.member.name ?? "",
                  size: 20,
                ).center(),
              ).squareBox(edgeSize: 20),
              HSpace.h8,
            ],
            Text(widget.member.name ?? "-", maxLines: null).center().flexible(),
            HSpace.h4,
            const Icon(
              Icons.close,
              size: 16,
              color: AppColors.black3Color,
            ).center().squareBox(edgeSize: 30).onTapWidget(() {
              widget.onRemove();
            }),
          ],
        ),
      ),
    );
  }
}