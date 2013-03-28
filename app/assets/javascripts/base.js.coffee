root = this

root.ce = do ($) ->
  _init = (name,el) ->
    console.log("init: app");
    appContainer = el

  pub =
    init: _init