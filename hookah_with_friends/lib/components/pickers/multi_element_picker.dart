import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../cubit/multi_element_picker/multi_element_picker_cubit.dart";
import "../../util/colors.dart";
import "../cards/small_card.dart";
import "../texts/primary_text.dart";

abstract class MultiElementPickerPreviewStyle {
  const MultiElementPickerPreviewStyle();

  Widget getPreviewForItem(
    List<MultiElementPickerItem> items,
    List<int> selectedIndices,
  );
}

class CountOfMultiElementPickerPreviewStyle
    extends MultiElementPickerPreviewStyle {
  const CountOfMultiElementPickerPreviewStyle();

  @override
  Widget getPreviewForItem(
    List<MultiElementPickerItem> items,
    List<int> selectedIndices,
  ) {
    return PrimaryText(selectedIndices.length == items.length
        ? "All"
        : "${selectedIndices.length}/${items.length}");
  }
}

class TitlesMultiElementPickerPreviewStyle
    extends MultiElementPickerPreviewStyle {
  const TitlesMultiElementPickerPreviewStyle();

  @override
  Widget getPreviewForItem(
      List<MultiElementPickerItem> items, List<int> selectedIndices) {
    final List<Widget> titles = <Widget>[];
    for (final int index in selectedIndices) {
      titles.add(items[index].title);
    }
    return Column(
      children: titles,
    );
  }
}

typedef MultiElementPickerItemBuilder<T> = MultiElementPickerItem Function(T);

class MultiElementPicker<T> extends StatelessWidget {
  MultiElementPicker({
    super.key,
    required this.elements,
    required this.itemBuilder,
    required this.label,
    this.allowSelectAll = true,
    this.previewStyle = const CountOfMultiElementPickerPreviewStyle(),
  }) : items = elements.map(itemBuilder).toList();

  final String label;
  final List<T> elements;
  final MultiElementPickerItemBuilder<T> itemBuilder;
  final List<MultiElementPickerItem> items;
  final bool allowSelectAll;
  final MultiElementPickerPreviewStyle previewStyle;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MultiElementPickerCubit>(
      create: (BuildContext context) => MultiElementPickerCubit(),
      child: Builder(builder: (BuildContext contextWithBloc) {
        return SmallCard(
          onTap: () {
            showModalBottomSheet(
                backgroundColor: HWFColors.cardBackground.withOpacity(1),
                context: contextWithBloc,
                builder: (BuildContext context) {
                  return BlocProvider<MultiElementPickerCubit>.value(
                    value: contextWithBloc.read<MultiElementPickerCubit>(),
                    child: MultiElementPickerMenu(
                      elements: items,
                      allowSelectAll: allowSelectAll,
                    ),
                  );
                });
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                PrimaryText(label),
                const Spacer(),
                Builder(builder: (BuildContext contextWithBloc) {
                  return Row(
                    children: <Widget>[
                      BlocBuilder<MultiElementPickerCubit,
                          MultiElementPickerSelected>(
                        builder: (BuildContext context,
                            MultiElementPickerSelected state) {
                          return previewStyle.getPreviewForItem(
                              items, state.selectedIndexes);
                        },
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.expand_more_outlined,
                        color: HWFColors.text,
                      ),
                    ],
                  );
                })
              ],
            ),
          ),
        );
      }),
    );
  }
}

class MultiElementPickerMenu extends StatelessWidget {
  const MultiElementPickerMenu(
      {super.key, required this.elements, required this.allowSelectAll});

  final List<MultiElementPickerItem> elements;
  final bool allowSelectAll;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MultiElementPickerCubit, MultiElementPickerSelected>(
      builder: (BuildContext context, MultiElementPickerSelected state) {
        return ListView.builder(
          itemCount: allowSelectAll ? elements.length + 1 : elements.length,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Column(
                children: <Widget>[
                  if (state.selectedIndexes.length != elements.length &&
                      allowSelectAll) ...<Widget>[
                    ListTile(
                      onTap: () {
                        context
                            .read<MultiElementPickerCubit>()
                            .selectAll(elements.length);
                      },
                      title: PrimaryText("Select All"),
                      trailing: PrimaryText(
                          "${state.selectedIndexes.length}/${elements.length}"),
                    ),
                  ] else if (allowSelectAll) ...<Widget>[
                    ListTile(
                      onTap: () {
                        context.read<MultiElementPickerCubit>().unSelectAll();
                      },
                      title: PrimaryText("Deselect All"),
                      trailing: PrimaryText(
                          "${state.selectedIndexes.length}/${elements.length}"),
                    ),
                  ]
                ],
              );
            } else {
              final int currentIndex = allowSelectAll ? index - 1 : index;
              return Column(children: <Widget>[
                Divider(
                  height: 1,
                  color: HWFColors.divider,
                ),
                Theme(
                  data: Theme.of(context).copyWith(
                    unselectedWidgetColor: HWFColors.button,
                  ),
                  child: CheckboxListTile(
                    activeColor: HWFColors.button,
                    title: elements[currentIndex].title,
                    value: state.selectedIndexes.contains(currentIndex),
                    onChanged: (bool? value) {
                      context
                          .read<MultiElementPickerCubit>()
                          .toggleValue(currentIndex, value!);
                    },
                  ),
                ),
              ]);
            }
          },
        );
      },
    );
  }
}

class MultiElementPickerItem {
  MultiElementPickerItem({required this.title});

  final Widget title;
  bool selected = false;
}
