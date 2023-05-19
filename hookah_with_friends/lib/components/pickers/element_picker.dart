import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../cubit/element_picker/element_picker_cubit.dart";
import "../../util/colors.dart";
import "../cards/small_card.dart";
import "../texts/primary_text.dart";

typedef ElementPickerItemBuilder<T> = ElementPickerItem Function(T);

class ElementPicker<T> extends StatelessWidget {
  ElementPicker(
      {super.key,
      required this.elements,
      required this.itemBuilder,
      required this.label,
      this.controller})
      : items = elements.map(itemBuilder).toList() {
    controller?.currentSelection = elements.first;
  }

  final String label;
  final List<T> elements;
  final ElementPickerItemBuilder<T> itemBuilder;
  final List<ElementPickerItem> items;
  final ElementPickerController<T>? controller;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ElementPickerCubit>(
      create: (BuildContext context) => ElementPickerCubit(),
      child: Builder(builder: (BuildContext contextWithBloc) {
        return SmallCard(
          onTap: () {
            showModalBottomSheet(
                backgroundColor: HWFColors.cardBackground.withOpacity(1),
                context: contextWithBloc,
                builder: (BuildContext context) {
                  return BlocProvider<ElementPickerCubit>.value(
                      value: contextWithBloc.read<ElementPickerCubit>(),
                      child: ElementPickerMenu<T>(elements: items));
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
                      BlocBuilder<ElementPickerCubit, ElementPickerSelected>(
                        builder: (BuildContext context,
                            ElementPickerSelected state) {
                          return items[state.selectedIndex].title;
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

class ElementPickerMenu<T> extends StatelessWidget {
  const ElementPickerMenu({super.key, required this.elements, this.controller});

  final List<ElementPickerItem> elements;
  final ElementPickerController<T>? controller;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: elements.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(children: <Widget>[
          ListTile(
            onTap: () {
              context.read<ElementPickerCubit>().selectIndex(index);
              if (controller != null) {
                context
                    .read<ElementPickerCubit>()
                    .updateSelection(index, controller!, elements);
              }
              Navigator.pop(context);
            },
            title: elements[index].title,
            subtitle: elements[index].subtitle,
          ),
          Divider(
            height: 1,
            color: HWFColors.divider,
          )
        ]);
      },
    );
  }
}

class ElementPickerItem {
  ElementPickerItem({required this.title, required this.subtitle});

  final Widget title;
  final Widget subtitle;
}

class ElementPickerController<T> {
  late T currentSelection;
}
