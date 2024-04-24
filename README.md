## RUST FFI Call from Dart + Large Sliver Builder With Sticky Header

### Task 1 |
Sticky Header With Large Sliver List Builder

**[To play video demo: click below thumbnail]**
<div align="left">
      <a target="_blank" href="https://www.youtube.com/watch?v=78qle77_o2A">
         <img src="https://img.youtube.com/vi/78qle77_o2A/0.jpg" style="width:200px;">
      </a>
</div>

[ 🔗 Task 1 Directory](https://github.com/naimurhasan/flutter_rust_ffi_and_sliver/tree/main/task1/sticky_list_header)

#### repo.dart

```dart
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
```

### sticky list page.dart

```dart
import 'package:flutter/material.dart';
...
class _StickyListPageState extends State<StickyListPage> {
  late final List<ListItemModel> listItems;
  late final List<ListSliceModel> slices;

  @override
  void initState() {
    listItems = Repo().getItems();
    slices = generateSlices(listItems);
    ...
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            ...
          ),
          for (int i = 0; i < slices.length; i++)
            slices[i].isSticky
                ? SliverPersistentHeader(
                    pinned: true,
                    delegate: StickyHeaderDelegate(
                      child: Container(
                        ....
                        child: Text(slices[i].items.first.title),
                      ),
                    ),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return ListTile(
                          title: Text('Item ${slices[i].items[index].title}'),
                          ...
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
    ...
    return slices;
  }
}
```


### Task 2 | RUST FFI CALL
A repo that shows how you can call rust foreign function interfaces from Dart.

[ 🔗 Task 2 Directory](https://github.com/naimurhasan/flutter_rust_ffi_and_sliver/blob/main/task2)

#### main dart file

```dart
import 'dart:ffi';
import 'dart:io';

// Load the dynamic library. 
DynamicLibrary openLibrary() {
  if (Platform.isLinux) {
    return DynamicLibrary.open(''); // path of linux lib file
  } else if (Platform.isWindows) {
    return DynamicLibrary.open(''); // path of linux windows lib file
  } else if (Platform.isMacOS) {
    return DynamicLibrary.open('/Users/naimur/Devlopment/coding_round/task2/hello/target/release/libhello.dylib');
  }
  throw UnsupportedError('Unsupported platform');
}

// Define the function signature.
typedef SayHelloNative = Void Function();
typedef SayHello = void Function();


void main(List<String> arguments) {
  final library = openLibrary();
  final sayHello = library.lookupFunction<SayHelloNative, SayHello>('say_hello');

  sayHello();
}
```
