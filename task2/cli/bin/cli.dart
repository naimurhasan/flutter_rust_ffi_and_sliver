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
