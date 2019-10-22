![Build Status](https://travis-ci.org/smolck/dart-nvim-api.svg?branch=master)

# Dart Nvim API
Neovim API implementation for [Dart](dart.dev), based on and inspired by [neovim-lib](https://github.com/daa84/neovim-lib).
Still a WIP, so any feedback, contributions, etc. are greatly appreciated.

__NOTE__: Currently, this library
only supports _asynchronous_ calls to Neovim. This is due to how
Dart's [`Socket` class](https://api.dartlang.org/stable/2.5.2/dart-io/Socket-class.html) (used
internally by the `Session` class here), is best used with `async/await`. However,
I do plan to (attempt) creating a blocking implementation, so feel free to open an issue
on the topic if you have any suggestsions or want to help.

# Contributing
Changes to the `Neovim` class (and other changes in `lib/dart_nvim_api.dart`) should be done
in the template file `gen_bindings/dart_nvim_api.dart`. To generate `lib/dart_nvim_api.dart` do 
the following from the project root (requires `pip` in addition to `python` v3.7.4. Note that older versions 
of Python 3 may work, I just haven't tested them):
```console
$ pip install -g datetime jinja2
# Replacing <nvim binary path> as necessary:
$ python gen_bindings/gen_bindings.py <nvim binary path> 'lib/'
```
Changes to any other files can be done as usual.
