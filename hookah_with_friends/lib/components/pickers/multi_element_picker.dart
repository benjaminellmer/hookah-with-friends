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
typedef MultiElementPickerItemSearcher<T> = String Function(T);

class MultiElementPicker<T> extends StatelessWidget {
  MultiElementPicker({
    super.key,
    required this.elements,
    required this.itemBuilder,
    required this.label,
    this.itemSearcher,
    this.allowSelectAll = true,
    this.allowSearch = true,
    this.previewStyle = const CountOfMultiElementPickerPreviewStyle(),
    this.controller,
  }) : items = elements.map(itemBuilder).toList();

  final String label;
  final List<T> elements;
  final MultiElementPickerItemBuilder<T> itemBuilder;
  final MultiElementPickerItemSearcher<T>? itemSearcher;
  final List<MultiElementPickerItem> items;
  final bool allowSelectAll;
  final bool allowSearch;
  final MultiElementPickerPreviewStyle previewStyle;
  final MultiElementPickerController<T>? controller;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MultiElementPickerCubit<T>>(
      create: (BuildContext context) => MultiElementPickerCubit<T>(
          elements: elements, controller: controller),
      child: Builder(builder: (BuildContext contextWithBloc) {
        return SmallCard(
          onTap: () {
            showModalBottomSheet(
                backgroundColor: HWFColors.cardBackground.withOpacity(1),
                context: contextWithBloc,
                builder: (BuildContext context) {
                  return BlocProvider<MultiElementPickerCubit<T>>.value(
                    value: contextWithBloc.read<MultiElementPickerCubit<T>>(),
                    child: MultiElementPickerMenu<T>(
                      elements: items,
                      allowSelectAll: allowSelectAll,
                      allowSearch: allowSearch,
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
                      BlocBuilder<MultiElementPickerCubit<T>,
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

class MultiElementPickerMenu<T> extends StatelessWidget {
  const MultiElementPickerMenu(
      {super.key, required this.elements, required this.allowSelectAll, required this.allowSearch});

  final List<MultiElementPickerItem> elements;
  final bool allowSelectAll;
  final bool allowSearch;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MultiElementPickerCubit<T>, MultiElementPickerSelected>(
      builder: (BuildContext context, MultiElementPickerSelected state) {
           return SingleChildScrollView(
             child: Column(
               children: <Widget>[
                 ListView.builder(
                   shrinkWrap: true,
                   primary: false,
                   itemCount: allowSelectAll ? (allowSearch ? 2 : 1) : (allowSearch ? 1 : 0),
                   itemBuilder: (BuildContext context, int index) {
                     if(allowSelectAll) {
                       return Column(
                         children: <Widget>[
                           if (state.selectedIndexes.length !=
                               elements.length) ...<Widget>[
                             ListTile(
                               onTap: () {
                                 context
                                     .read<MultiElementPickerCubit<T>>()
                                     .selectAll(elements.length);
                               },
                               title: PrimaryText("Select All"),
                               trailing: PrimaryText(
                                   "${state.selectedIndexes.length}/${elements.length}"),
                             ),
                           ] else ...<Widget>[
                             ListTile(
                               onTap: () {
                                 context
                                     .read<MultiElementPickerCubit<T>>()
                                     .unSelectAll();
                               },
                               title: PrimaryText("Deselect All"),
                               trailing: PrimaryText(
                                   "${state.selectedIndexes.length}/${elements.length}"),
                             ),
                           ],
                         ],
                       );
                     }
                   },
                 ),
                 ListView.builder(
                   shrinkWrap: true,
                   primary: false,
                   itemCount: elements.length,
                   itemBuilder: (BuildContext context, int index) {
                     final int currentIndex = index;
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
                                 .read<MultiElementPickerCubit<T>>()
                                 .toggleValue(currentIndex, value!);
                           },
                         ),
                       ),
                     ]);
                   },
                 ),
               ],
             ),
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

class MultiElementPickerController<T> {
  List<T> currentSelection = <T>[];
}
