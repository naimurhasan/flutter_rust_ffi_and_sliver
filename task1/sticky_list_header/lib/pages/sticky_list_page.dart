import 'package:flutter/material.dart';
import 'package:sticky_list_header/data/repo.dart';
import 'package:sticky_list_header/models/list_item_model.dart';
import 'package:sticky_list_header/models/list_slice_model.dart';
import 'package:sticky_list_header/widgets/sticky_header_delegate.dart';

class StickyListPage extends StatefulWidget {
  const StickyListPage({super.key});

  @override
  State<StickyListPage> createState() => _StickyListPageState();
}

class _StickyListPageState extends State<StickyListPage> {
  late final List<ListItemModel> listItems;
  late final List<ListSliceModel> slices;

  @override
  void initState() {
    listItems = Repo().getItems();
    slices = generateSlices(listItems);
    print("NUMBER OF SLICES ${slices.length}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('Task 1'),
            pinned: true,
          ),
          for (int i = 0; i < slices.length; i++)
            slices[i].isSticky
                ? SliverPersistentHeader(
                    pinned: true,
                    delegate: StickyHeaderDelegate(
                      child: Container(
                        alignment: Alignment.center,
                        color: Colors.blue,
                        padding: const EdgeInsets.all(20),
                        child: Text(slices[i].items.first.title),
                      ),
                    ),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return ListTile(
                          title: Text('Item ${slices[i].items[index].title}'),
                          leading: const Icon(Icons.star),
                        );
                      },
                      childCount: slices[i].items.length,
                    ),
                  ),

          
        ],
      ),
    );
  }

  // make as large slices as possible
  List<ListSliceModel> generateSlices(List<ListItemModel> listItems) {
    List<ListSliceModel> slices = [];

    for (int i = 0; i < listItems.length; i++) {
      if (listItems[i].isSticky) {
        slices.add(ListSliceModel(isSticky: true, items: [listItems[i]]));
        
        i+=1;
      } else {
        List<ListItemModel> slice = [];
        int j = i;
        for(j = i; j<listItems.length; j++){
          if(listItems[j].isSticky){
            break;
          }
          slice.add(listItems[j]);
        }
        slices.add(ListSliceModel(isSticky: false, items: slice));
        i += j-1;
      }
    }

    return slices;
  }
}
