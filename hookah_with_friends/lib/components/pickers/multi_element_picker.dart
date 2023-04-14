import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../cubit/multi_element_picker/multi_element_picker_cubit.dart";
import "../../util/colors.dart";
import "../cards/small_card.dart";
import "../texts/primary_text.dart";

typedef MultiElementPickerItemBuilder<T> = MultiElementPickerItem Function(T);

class MultiElementPicker<T> extends StatelessWidget {
  MultiElementPicker(
      {super.key,
      required this.elements,
      required this.itemBuilder,
      required this.label})
      : items = elements.map(itemBuilder).toList();

  final String label;
  final List<T> elements;
  final MultiElementPickerItemBuilder<T> itemBuilder;
  final List<MultiElementPickerItem> items;

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
                      child: MultiElementPickerMenu(elements: items));
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
                          return PrimaryText(state.selectedIndexes.length ==
                                  elements.length
                              ? "All"
                              : "${state.selectedIndexes.length}/${elements.length}");
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
  const MultiElementPickerMenu({super.key, required this.elements});

  final List<MultiElementPickerItem> elements;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MultiElementPickerCubit, MultiElementPickerSelected>(
      builder: (BuildContext context, MultiElementPickerSelected state) {
        return ListView.builder(
          itemCount: elements.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Column(
                children: <Widget>[
                  if (state.selectedIndexes.length !=
                      elements.length) ...<Widget>[
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
                  ] else ...<Widget>[
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
                    title: elements[index - 1].title,
                    value: state.selectedIndexes.contains(index - 1),
                    onChanged: (bool? value) {
                      context
                          .read<MultiElementPickerCubit>()
                          .toggleValue(index - 1, value!);
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
