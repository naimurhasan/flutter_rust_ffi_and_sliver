import 'package:sticky_list_header/models/list_item_model.dart';
// slices keeps either a single sticky item or non-sticky list of items
class ListSliceModel {
  final bool isSticky;
  final List<ListItemModel> items;
  ListSliceModel({required this.isSticky, required this.items});
}