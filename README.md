[![Build Status](https://travis-ci.org/smolck/dart-nvim-api.svg?branch=master)](https://travis-ci.org/smolck/dart-nvim-api)
[![Pub](https://img.shields.io/pub/v/dart_nvim_api.svg)](https://pub.dartlang.org/packages/dart_nvim_api)
# Dart Nvim API

Neovim API implementation for [Dart](dart.dev), based on and inspired by [neovim-lib](https://github.com/daa84/neovim-lib).
Still a WIP, so any feedback, contributions, etc. are greatly appreciated.

> NOTE: Dart Nvim API is still in its early stages, so there are likely to be breaking API changes.

# Example Usage
```dart
import 'package:dart_nvim_api/dart_nvim_api.dart';

main(List<String> args) async {
  // Start up Neovim instance and communicate over stdin/stdout:
  var nvim = Neovim(nvimBinaryPath: 'nvim');

  // Or connect to already running instance over TCP:
  // var nvim = Neovim.connectToRunningInstance(host: '127.0.0.1', port: 8888);

  // Run Neovim ex command.
  await nvim.command("echo 'hello'");

  // Get ex command output.
  assert(await nvim.commandOutput("echo 'hello'") == null);

  // Buffer example:
  var buf = await nvim.createBuf(true, false);
  var bufNum = await buf.getNumber(nvim);
  assert(bufNum == 2);
  assert(await nvim.getCurrentBuf() is Buffer);

  // Beyond that, you can run any Neovim api command. See `:help api-rpc` doc in Neovim.
  // See also `example` directory.
}
```

# Contributing
Changes to the `Neovim`, `Window`, `Buffer`, and `Tabpage` classes should be done
in the template files in the `gen_bindings/src` folder. To generate `lib/src/*.dart` do 
the following from the project root (requires `pip` in addition to `python` v3.7.4. Note that older versions 
of Python 3 may work, I just haven't tested them):
```console
$ pip install -g datetime jinja2
# Replacing <nvim binary path> as necessary:
$ python gen_bindings/gen_bindings.py <nvim binary path> 'lib/src' 'gen_bindings/src/'
```

Changes to any other files can be done as usual.
