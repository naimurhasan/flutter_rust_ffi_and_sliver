import 'package:sticky_list_header/models/list_item_model.dart';

abstract class IRepo{
  List<ListItemModel> getItems();
}

class Repo implements IRepo{
  @override
  List<ListItemModel> getItems() {
    print("LIST GENERATION START");
    List<ListItemModel> itemList1 = List.generate(9, (index) => ListItemModel(title: "Item $index"));
    List<ListItemModel> itemList2 = List.generate(990000, (index) => ListItemModel(title: "Item ${index+10}"));
    itemList1.add(const ListItemModel(title: "Item 9 (10th)", isSticky: true));
    itemList1.addAll(itemList2);
    print("LIST GENERATED");
    return itemList1;
  }
}