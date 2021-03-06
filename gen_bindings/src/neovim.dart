// Generated 2019-10-23 12:28:11.546414 by `gen_bindings.py`.
// DO NOT MODIFY DIRECTLY!

import 'dart:async';

import 'package:meta/meta.dart';

import 'tabpage.dart';
import 'window.dart';
import 'buffer.dart';
import 'ui_events.dart';
import 'session.dart';
import 'ui_attach_options.dart';

/// Represents an instance of Neovim which can be communicated with via
/// methods.
class Neovim {
  Session _session;

  /// The Neovim session, which holds information such as pending
  /// requests, responses, and notifications from Neovim, and which
  /// also allows for direct communication with Neovim. See [Session]
  /// class for more details.
  get session => _session;

  /// Create a Neovim instance from a [Session] instance.
  Neovim.fromSession(this._session);

  /// Communicate over TCP with an already-running Neovim instance
  /// (i.e. a Neovim instance run with `--listen <host>:<port>`).
  Neovim.connectToRunningInstance({
    @required String host,
    @required int port,
  }) : _session = Session.fromRunningInstance(host: host, port: port);
  /// Start a [Neovim] instance using the optional `nvimBinaryPath` or
  /// the default of 'usr/bin/nvim'.
  ///
  /// If `communicateWithParentProcess` is true, then return a [Neovim]
  /// instance that receives events from and sends events to the Neovim
  /// process which started the current process via `jobstart`.
  Neovim({String nvimBinaryPath, bool communicateWithParentProcess})
      : _session = communicateWithParentProcess
            ? Session.fromCurrentStdinStdout()
            : Session(nvim: nvimBinaryPath ?? '/usr/bin/nvim');

  /// From Neovim's `:help nvim_ui_attach()` documentation:
  /// "Activates UI events on the channel."
  ///
  /// "Entry point of all UI clients. Allows |--embed| to continue
  /// startup. Implies that the client is ready to show the UI. Adds
  /// the client to the list of UIs. |nvim_list_uis()|"
  ///
  /// `width` and `height` are the requested screen columns and rows of the
  /// Neovim session, respectively.
  ///
  /// `options` is an instance of [UiAttachOptions], which contains information
  /// related to the UI; see Neovim's `:help ui-option` documentation.
  Future attachUi({@required int width, @required int height, UiAttachOptions options}) async {
    return await _session.call("nvim_ui_attach", args: [width, height, options?.asMap()]);
  }

  {% for f in functions if not f.ext %}
    {% set trimmedFname = f.name | replace('nvim_', '') %}
    /// since: {{ f.since }}
    Future<{{ f.return_type.native_type_ret }}> {{ to_camel_case(trimmedFname) }}({{ f.argstring }}) async {
        return _session.call("{{ f.name }}",
          args: [{{ make_args_from_params(f.parameters) | map(attribute =
              "name") | join(", ") }}])
        {% if is_void(f.return_type.native_type_ret) %}
          ;
        {% else %}
          .then<{{ f.return_type.native_type_ret }}>((v) =>
          {% if is_list(f.return_type.native_type_ret) %}
            (v as List).cast<{{ remove_wrapping_list(f.return_type.native_type_ret) }}>());
          {% else %}
            v as {{ f.return_type.native_type_ret }});
          {% endif %}
        {% endif %}
    }

    {% endfor %}
}
