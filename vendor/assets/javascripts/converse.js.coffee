window.converse = {}
converse.msg_counter = 0
strinclude = (str, needle) ->
  return true  if needle is ""
  return false  if str is null
  String(str).indexOf(needle) isnt -1
  return
converse.autoLink = (text) ->
  # Convert URLs into hyperlinks
  re = /((http|https|ftp):\/\/[\w?=&.\/\-;#~%\-]+(?![\w\s?&.\/;#~%"=\-]*>))/g
  text.replace re, "<a target=\"_blank\" href=\"$1\">$1</a>"
  return
converse.toISOString = (date) ->
  pad = undefined
  if typeof date.toISOString isnt "undefined"
    date.toISOString()
  else
    
    # IE <= 8 Doesn't have toISOStringMethod
    pad = (num) ->
      (if (num < 10) then "0" + num else "" + num)

    date.getUTCFullYear() + "-" + pad(date.getUTCMonth() + 1) + "-" + pad(date.getUTCDate()) + "T" + pad(date.getUTCHours()) + ":" + pad(date.getUTCMinutes()) + ":" + pad(date.getUTCSeconds()) + ".000Z"
  return
converse.parseISO8601 = (datestr) ->
  
  # Parses string formatted as 2013-02-14T11:27:08.268Z to a Date obj.
  #
  numericKeys = [1, 4, 5, 6, 7, 10, 11]
  struct = /^\s*(\d{4})-(\d{2})-(\d{2})T(\d{2}):(\d{2}):(\d{2}\.?\d*)Z\s*$/.exec(datestr)
  minutesOffset = 0
  i = undefined
  k = undefined
  i = 0
  while (k = numericKeys[i])
    struct[k] = +struct[k] or 0
    ++i
  
  # allow undefined days and months
  struct[2] = (+struct[2] or 1) - 1
  struct[3] = +struct[3] or 1
  if struct[8] isnt "Z" and struct[9] isnt `undefined`
    minutesOffset = struct[10] * 60 + struct[11]
    minutesOffset = 0 - minutesOffset  if struct[9] is "+"
  new Date(Date.UTC(struct[1], struct[2], struct[3], struct[4], struct[5] + minutesOffset, struct[6], struct[7]))

converse.updateMsgCounter = ->
  if @msg_counter > 0
    if document.title.search(/^Messages \(\d+\) /) is -1
      document.title = "Messages (" + @msg_counter + ") " + document.title
    else
      document.title = document.title.replace(/^Messages \(\d+\) /, "Messages (" + @msg_counter + ") ")
    window.blur()
    window.focus()
  else document.title = document.title.replace(/^Messages \(\d+\) /, "")  unless document.title.search(/^Messages \(\d+\) /) is -1
  return
converse.incrementMsgCounter = ->
  @msg_counter += 1
  @updateMsgCounter()
  return
converse.clearMsgCounter = ->
  @msg_counter = 0
  @updateMsgCounter()
  return

# FIXME: XEP-0136 specifies 'urn:xmpp:archive' but the mod_archive_odbc
#* add-on for ejabberd wants the URL below. This might break for other
#* Jabber servers.
#
converse.collections = URI: "http://www.xmpp.org/extensions/xep-0136.html#ns"
converse.collections.getLastCollection = (jid, callback) ->
  bare_jid = Strophe.getBareJidFromJid(jid)
  iq = $iq(type: "get").c("list",
    xmlns: @URI
    with: bare_jid
  ).c("set",
    xmlns: "http://jabber.org/protocol/rsm"
  ).c("before").up().c("max").t("1")
  converse.connection.sendIQ iq, callback, ->
    console.log "Error while retrieving collections"
    return
  return

converse.collections.getLastMessages = (jid, callback) ->
  that = this
  @getLastCollection jid, (result) ->
    
    # Retrieve the last page of a collection (max 30 elements).
    $collection = $(result).find("chat")
    jid = $collection.attr("with")
    start = $collection.attr("start")
    iq = $iq(type: "get").c("retrieve",
      start: start
      xmlns: that.URI
      with: jid
    ).c("set",
      xmlns: "http://jabber.org/protocol/rsm"
    ).c("max").t("30")
    converse.connection.sendIQ iq, callback
    return
  return

converse.Message = Backbone.Model.extend()
converse.Messages = Backbone.Collection.extend(model: converse.Message)
converse.ChatBox = Backbone.Model.extend(
  initialize: ->
    if @get("box_id") isnt "controlbox"
      @messages = new converse.Messages()
      @messages.localStorage = new Backbone.LocalStorage(hex_sha1("converse.messages" + @get("jid")))
      @set
        user_id: Strophe.getNodeFromJid(@get("jid"))
        box_id: hex_sha1(@get("jid"))
        fullname: @get("fullname")
        url: @get("url")
        image_type: @get("image_type")
        image_src: @get("image_src")
    return


  messageReceived: (message) ->
    $message = $(message)
    body = converse.autoLink($message.children("body").text())
    from = Strophe.getBareJidFromJid($message.attr("from"))
    composing = $message.find("composing")
    delayed = $message.find("delay").length > 0
    fullname = (@get("fullname") or "").split(" ")[0]
    stamp = undefined
    time = undefined
    sender = undefined
    unless body
      if composing.length
        @messages.add
          fullname: fullname
          sender: "them"
          delayed: delayed
          time: converse.toISOString(new Date())
          composing: composing.length
    else
      if delayed
        stamp = $message.find("delay").attr("stamp")
        time = stamp
      else
        time = converse.toISOString(new Date())
      if from is converse.bare_jid
        fullname = "me"
        sender = "me"
      else
        sender = "them"
      @messages.create
        fullname: fullname
        sender: sender
        delayed: delayed
        time: time
        message: body
    return
)
converse.ChatBoxView = Backbone.View.extend(
  length: 200
  tagName: "div"
  className: "chatbox"
  events:
    "click .close-chatbox-button": "closeChat"
    "keypress textarea.chat-textarea": "keyPressed"

  message_template: _.template("<div class=\"chat-message {{extra_classes}}\">" + "<span class=\"chat-message-{{sender}}\">{{time}} {{username}}:&nbsp;</span>" + "<span class=\"chat-message-content\">{{message}}</span>" + "</div>")
  action_template: _.template("<div class=\"chat-message {{extra_classes}}\">" + "<span class=\"chat-message-{{sender}}\">{{time}}:&nbsp;</span>" + "<span class=\"chat-message-content\">{{message}}</span>" + "</div>")
  new_day_template: _.template("<time class=\"chat-date\" datetime=\"{{isodate}}\">{{datestring}}</time>")
  insertStatusNotification: (message, replace) ->
    $chat_content = @$el.find(".chat-content")
    $chat_content.find("div.chat-event").remove().end().append $("<div class=\"chat-event\"></div>").text(message)
    @scrollDown()
    return

  showMessage: (message) ->
    time = message.get("time")
    times = @model.messages.pluck("time")
    this_date = converse.parseISO8601(time)
    $chat_content = @$el.find(".chat-content")
    previous_message = undefined
    idx = undefined
    prev_date = undefined
    isodate = undefined
    
    # If this message is on a different day than the one received
    # prior, then indicate it on the chatbox.
    idx = _.indexOf(times, time) - 1
    if idx >= 0
      previous_message = @model.messages.at(idx)
      prev_date = converse.parseISO8601(previous_message.get("time"))
      isodate = new Date(this_date.getTime())
      isodate.setUTCHours 0, 0, 0, 0
      isodate = converse.toISOString(isodate)
      if @isDifferentDay(prev_date, this_date)
        $chat_content.append @new_day_template(
          isodate: isodate
          datestring: this_date.toString().substring(0, 15)
        )
    if message.get("composing")
      @insertStatusNotification message.get("fullname") + " " + "is typing"
      return
    else
      $chat_content.find("div.chat-event").remove()
      $chat_content.append @message_template(
        sender: message.get("sender")
        time: this_date.toLocaleTimeString().substring(0, 5)
        message: message.get("message")
        username: message.get("fullname")
        extra_classes: message.get("delayed") and "delayed" or ""
      )
    converse.incrementMsgCounter()  if (message.get("sender") isnt "me") and (converse.windowState is "blur")
    @scrollDown()
    return

  isDifferentDay: (prev_date, next_date) ->
    (next_date.getDate() isnt prev_date.getDate()) or (next_date.getFullYear() isnt prev_date.getFullYear()) or (next_date.getMonth() isnt prev_date.getMonth())
    return

  addHelpMessages: (msgs) ->
    $chat_content = @$el.find(".chat-content")
    i = undefined
    msgs_length = msgs.length
    i = 0
    while i < msgs_length
      $chat_content.append $("<div class=\"chat-help\">" + msgs[i] + "</div>")
      i++
    @scrollDown()
    return

  sendMessage: (text) ->
    
    # TODO: Look in ChatPartners to see what resources we have for the recipient.
    # if we have one resource, we sent to only that resources, if we have multiple
    # we send to the bare jid.
    timestamp = (new Date()).getTime()
    bare_jid = @model.get("jid")
    match = text.replace(/^\s*/, "").match(/^\/(.*)\s*$/)
    msgs = undefined
    if match
      if match[1] is "clear"
        @$el.find(".chat-content").empty()
        @model.messages.reset()
        return
      else if match[1] is "help"
        msgs = ["<strong>/help</strong>: Show this menu", "<strong>/clear</strong>: Remove messages"]
        @addHelpMessages msgs
        return
    message = $msg(
      from: converse.bare_jid
      to: bare_jid
      type: "chat"
      id: timestamp
    ).c("body").t(text).up().c("active",
      xmlns: "http://jabber.org/protocol/chatstates"
    )
    
    # Forward the message, so that other connected resources are also aware of it.
    # TODO: Forward the message only to other connected resources (inside the browser)
    forwarded = $msg(
      to: converse.bare_jid
      type: "chat"
      id: timestamp
    ).c("forwarded",
      xmlns: "urn:xmpp:forward:0"
    ).c("delay",
      xmns: "urn:xmpp:delay"
      stamp: timestamp
    ).up().cnode(message.tree())
    converse.connection.send message
    converse.connection.send forwarded
    
    # Add the new message
    @model.messages.create
      fullname: "me"
      sender: "me"
      time: converse.toISOString(new Date())
      message: text
    return

  keyPressed: (ev) ->
    $textarea = $(ev.target)
    message = undefined
    notify = undefined
    composing = undefined
    if ev.keyCode is 13
      ev.preventDefault()
      message = $textarea.val()
      $textarea.val("").focus()
      if message isnt ""
        if @model.get("chatroom")
          @sendChatRoomMessage message
        else
          @sendMessage message
      @$el.data "composing", false
    else unless @model.get("chatroom")
      
      # composing data is only for single user chat
      composing = @$el.data("composing")
      unless composing
        unless ev.keyCode is 47
          
          # We don't send composing messages if the message
          # starts with forward-slash.
          notify = $msg(
            to: @model.get("jid")
            type: "chat"
          ).c("composing",
            xmlns: "http://jabber.org/protocol/chatstates"
          )
          converse.connection.send notify
        @$el.data "composing", true
    return
  onChange: (item, changed) ->
    if _.has(item.changed, "chat_status")
      chat_status = item.get("chat_status")
      fullname = item.get("fullname")
      if @$el.is(":visible")
        if chat_status is "offline"
          @insertStatusNotification fullname + " " + "has gone offline"
        else if chat_status is "away"
          @insertStatusNotification fullname + " " + "has gone away"
        else if chat_status is "dnd"
          @insertStatusNotification fullname + " " + "is busy"
        else @$el.find("div.chat-event").remove()  if chat_status is "online"
    @showStatusMessage item.get("status")  if _.has(item.changed, "status")
    return
  showStatusMessage: (msg) ->
    @$el.find("p.user-custom-message").text(msg).attr "title", msg
    return
  closeChat: ->
    if converse.connection
      @model.destroy()
    else
      @model.trigger "hide"
    return
  initialize: ->
    @model.messages.on "add", @showMessage, this
    @model.on "show", @show, this
    @model.on "destroy", @hide, this
    @model.on "change", @onChange, this
    @$el.appendTo converse.chatboxesview.$el
    @render().show().model.messages.fetch add: true
    @showStatusMessage @model.get("status")  if @model.get("status")
    return
  template: _.template("<div class=\"chat-head chat-head-chatbox\">" + "<a class=\"close-chatbox-button\">X</a>" + "<a href=\"{{url}}\" target=\"_blank\" class=\"user\">" + "<div class=\"chat-title\"> {{ fullname }} </div>" + "</a>" + "<p class=\"user-custom-message\"><p/>" + "</div>" + "<div class=\"chat-content\"></div>" + "<form class=\"sendXMPPMessage\" action=\"\" method=\"post\">" + "<textarea " + "type=\"text\" " + "class=\"chat-textarea\" " + "placeholder=\"Personal message\"/>" + "</form>")
  render: ->
    @$el.attr("id", @model.get("box_id")).html @template(@model.toJSON())
    if @model.get("image")
      img_src = "data:" + @model.get("image_type") + ";base64," + @model.get("image")
      canvas = $("<canvas height=\"35px\" width=\"35px\" class=\"avatar\"></canvas>")
      ctx = canvas.get(0).getContext("2d")
      img = new Image() # Create new Image object
      img.onload = ->
        ratio = img.width / img.height
        ctx.drawImage img, 0, 0, 35 * ratio, 35

      img.src = img_src
      @$el.find(".chat-title").before canvas
    this

  focus: ->
    @$el.find(".chat-textarea").focus()
    this

  hide: ->
    if converse.animate
      @$el.hide "fast"
    else
      @$el.hide()

  show: ->
    return @focus()  if @$el.is(":visible") and @$el.css("opacity") is "1"
    if converse.animate
      @$el.css(
        opacity: 0
        display: "inline"
      ).animate
        opacity: "1"
      , 200
    else
      @$el.css
        opacity: 1
        display: "inline"

    
    # Without a connection, we haven't yet initialized
    # localstorage
    @model.save()  if converse.connection
    this

  scrollDown: ->
    $content = @$el.find(".chat-content")
    $content.scrollTop $content[0].scrollHeight
    this
)
converse.ContactsPanel = Backbone.View.extend(
  tagName: "div"
  className: "oc-chat-content"
  id: "users"
  events:
    "click a.toggle-xmpp-contact-form": "toggleContactForm"
    "submit form.add-xmpp-contact": "addContactFromForm"
    "submit form.search-xmpp-contact": "searchContacts"
    "click a.subscribe-to-user": "addContactFromList"

  tab_template: _.template("<li><a class=\"s current\" href=\"#users\">Contacts</a></li>")
  template: _.template("<form class=\"set-xmpp-status\" action=\"\" method=\"post\">" + "<span id=\"xmpp-status-holder\">" + "<select id=\"select-xmpp-status\">" + "<option value=\"online\">Online</option>" + "<option value=\"dnd\">Busy</option>" + "<option value=\"away\">Away</option>" + "<option value=\"offline\">Offline</option>" + "</select>" + "</span>" + "</form>" + "<dl class=\"add-converse-contact dropdown\">" + "<dt id=\"xmpp-contact-search\" class=\"fancy-dropdown\">" + "<a class=\"toggle-xmpp-contact-form\" href=\"#\" title=\"Click to add new chat contacts\">Add a contact</a>" + "</dt>" + "<dd class=\"search-xmpp\" style=\"display:none\"><ul></ul></dd>" + "</dl>")
  add_contact_template: _.template("<li>" + "<form class=\"add-xmpp-contact\">" + "<input type=\"text\" name=\"identifier\" class=\"username\" placeholder=\"Contact username\"/>" + "<button type=\"submit\">Add</button>" + "</form>" + "<li>")
  search_contact_template: _.template("<li>" + "<form class=\"search-xmpp-contact\">" + "<input type=\"text\" name=\"identifier\" class=\"username\" placeholder=\"Contact name\"/>" + "<button type=\"submit\">Search</button>" + "</form>" + "<li>")
  render: ->
    markup = undefined
    @$parent.find("#controlbox-tabs").append @tab_template()
    @$parent.find("#controlbox-panes").append @$el.html(@template())
    if converse.xhr_user_search
      markup = @search_contact_template()
    else
      markup = @add_contact_template()
    @$el.find(".search-xmpp ul").append markup
    this

  toggleContactForm: (ev) ->
    ev.preventDefault()
    @$el.find(".search-xmpp").toggle "fast", ->
      $(this).find("input.username").focus()  if $(this).is(":visible")


  searchContacts: (ev) ->
    ev.preventDefault()
    $.getJSON portal_url + "/search-users?q=" + $(ev.target).find("input.username").val(), (data) ->
      $ul = $(".search-xmpp ul")
      $ul.find("li.found-user").remove()
      $ul.find("li.chat-help").remove()
      $ul.append "<li class=\"chat-help\">No users found</li>"  unless data.length
      $(data).each (idx, obj) ->
        $ul.append $("<li class=\"found-user\"></li>").append($("<a class=\"subscribe-to-user\" href=\"#\" title=\"Click to add as a chat contact\"></a>").attr("data-recipient", Strophe.escapeNode(obj.id) + "@" + converse.domain).text(obj.fullname))



  addContactFromForm: (ev) ->
    ev.preventDefault()
    $input = $(ev.target).find("input")
    jid = $input.val()
    unless jid
      
      # this is not a valid JID
      $input.addClass "error"
      return
    converse.getVCard jid, $.proxy((jid, fullname, image, image_type, url) ->
      @addContact jid, fullname
    , this), $.proxy((stanza) ->
      console.log "An error occured while fetching vcard"
      if $(stanza).find("error").attr("code") is "503"
        
        # If we get service-unavailable, we continue to create
        # the user
        jid = $(stanza).attr("from")
        @addContact jid, jid
    , this)
    $(".search-xmpp").hide()

  addContactFromList: (ev) ->
    ev.preventDefault()
    $target = $(ev.target)
    jid = $target.attr("data-recipient")
    name = $target.text()
    @addContact jid, name
    $target.parent().remove()
    $(".search-xmpp").hide()

  addContact: (jid, name) ->
    converse.connection.roster.add jid, name, [], (iq) ->
      converse.connection.roster.subscribe jid, null, converse.xmppstatus.get("fullname")

)
converse.RoomsPanel = Backbone.View.extend(
  tagName: "div"
  id: "chatrooms"
  events:
    "submit form.add-chatroom": "createChatRoom"
    "click input#show-rooms": "showRooms"
    "click a.open-room": "createChatRoom"
    "click a.room-info": "showRoomInfo"

  room_template: _.template("<dd class=\"available-chatroom\">" + "<a class=\"open-room\" data-room-jid=\"{{jid}}\" title=\"Click to open this room\" href=\"#\">{{name}}</a>" + "<a class=\"room-info\" data-room-jid=\"{{jid}}\" title=\"Show more information on this room\" href=\"#\">&nbsp;</a>" + "</dd>")
  room_description_template: _.template("<div class=\"room-info\">" + "<p class=\"room-info\"><strong>Description:</strong> {{desc}}</p>" + "<p class=\"room-info\"><strong>Occupants:</strong> {{occ}}</p>" + "<p class=\"room-info\"><strong>Features:</strong> <ul>" + "{[ if (passwordprotected) { ]}" + "<li class=\"room-info locked\">Requires authentication</li>" + "{[ } ]}" + "{[ if (hidden) { ]}" + "<li class=\"room-info\">Hidden</li>" + "{[ } ]}" + "{[ if (membersonly) { ]}" + "<li class=\"room-info\">Requires an invitation</li>" + "{[ } ]}" + "{[ if (moderated) { ]}" + "<li class=\"room-info\">Moderated</li>" + "{[ } ]}" + "{[ if (nonanonymous) { ]}" + "<li class=\"room-info\">Non-anonymous</li>" + "{[ } ]}" + "{[ if (open) { ]}" + "<li class=\"room-info\">Open room</li>" + "{[ } ]}" + "{[ if (persistent) { ]}" + "<li class=\"room-info\">Permanent room</li>" + "{[ } ]}" + "{[ if (publicroom) { ]}" + "<li class=\"room-info\">Public</li>" + "{[ } ]}" + "{[ if (semianonymous) { ]}" + "<li class=\"room-info\">Semi-anonymous</li>" + "{[ } ]}" + "{[ if (temporary) { ]}" + "<li class=\"room-info\">Temporary room</li>" + "{[ } ]}" + "{[ if (unmoderated) { ]}" + "<li class=\"room-info\">Unmoderated</li>" + "{[ } ]}" + "</p>" + "</div>")
  tab_template: _.template("<li><a class=\"s\" href=\"#chatrooms\">Rooms</a></li>")
  template: _.template("<form class=\"add-chatroom\" action=\"\" method=\"post\">" + "<legend>" + "<input type=\"text\" name=\"chatroom\" class=\"new-chatroom-name\" placeholder=\"Room name\"/>" + "<input type=\"text\" name=\"nick\" class=\"new-chatroom-nick\" placeholder=\"Nickname\"/>" + "<input type=\"{{ server_input_type }}\" name=\"server\" class=\"new-chatroom-server\" placeholder=\"Server\"/>" + "</legend>" + "<input type=\"submit\" name=\"join\" value=\"Join\"/>" + "<input type=\"button\" name=\"show\" id=\"show-rooms\" value=\"Show rooms\"/>" + "</form>" + "<dl id=\"available-chatrooms\"></dl>")
  render: ->
    @$parent.find("#controlbox-tabs").append @tab_template()
    @$parent.find("#controlbox-panes").append @$el.html(@template(server_input_type: converse.hide_muc_server and "hidden" or "text")).hide()
    this

  initialize: ->
    @on "update-rooms-list", (ev) ->
      @updateRoomsList()

    converse.xmppstatus.on "change", $.proxy((model) ->
      return  unless _.has(model.changed, "fullname")
      $nick = @$el.find("input.new-chatroom-nick")
      $nick.val model.get("fullname")  unless $nick.is(":focus")
    , this)
    return
  updateRoomsList: (domain) ->
    converse.connection.muc.listRooms @muc_domain, $.proxy((iq) -> # Success
      name = undefined
      jid = undefined
      i = undefined
      fragment = undefined
      that = this
      $available_chatrooms = @$el.find("#available-chatrooms")
      @rooms = $(iq).find("query").find("item")
      if @rooms.length
        $available_chatrooms.html "<dt>Rooms on " + @muc_domain + "</dt>"
        fragment = document.createDocumentFragment()
        i = 0
        while i < @rooms.length
          name = Strophe.unescapeNode($(@rooms[i]).attr("name") or $(@rooms[i]).attr("jid"))
          jid = $(@rooms[i]).attr("jid")
          fragment.appendChild $(@room_template(
            name: name
            jid: jid
          ))[0]
          i++
        $available_chatrooms.append fragment
        $("input#show-rooms").show().siblings("span.spinner").remove()
      else
        $available_chatrooms.html "<dt>No rooms on " + @muc_domain + "</dt>"
        $("input#show-rooms").show().siblings("span.spinner").remove()
      true
    , this), $.proxy((iq) -> # Failure
      $available_chatrooms = @$el.find("#available-chatrooms")
      $available_chatrooms.html "<dt>No rooms on " + @muc_domain + "</dt>"
      $("input#show-rooms").show().siblings("span.spinner").remove()
    , this)

  showRooms: (ev) ->
    $available_chatrooms = @$el.find("#available-chatrooms")
    $server = @$el.find("input.new-chatroom-server")
    server = $server.val()
    unless server
      $server.addClass "error"
      return
    @$el.find("input.new-chatroom-name").removeClass "error"
    $server.removeClass "error"
    $available_chatrooms.empty()
    $("input#show-rooms").hide().after "<span class=\"spinner\"/>"
    @muc_domain = server
    @updateRoomsList()

  showRoomInfo: (ev) ->
    target = ev.target
    $dd = $(target).parent("dd")
    $div = $dd.find("div.room-info")
    if $div.length
      $div.remove()
    else
      $dd.find("span.spinner").remove()
      $dd.append "<span class=\"spinner hor_centered\"/>"
      converse.connection.disco.info $(target).attr("data-room-jid"), null, $.proxy((stanza) ->
        $stanza = $(stanza)
        
        # All MUC features found here: http://xmpp.org/registrar/disco-features.html
        $dd.find("span.spinner").replaceWith @room_description_template(
          desc: $stanza.find("field[var=\"muc#roominfo_description\"] value").text()
          occ: $stanza.find("field[var=\"muc#roominfo_occupants\"] value").text()
          hidden: $stanza.find("feature[var=\"muc_hidden\"]").length
          membersonly: $stanza.find("feature[var=\"muc_membersonly\"]").length
          moderated: $stanza.find("feature[var=\"muc_moderated\"]").length
          nonanonymous: $stanza.find("feature[var=\"muc_nonanonymous\"]").length
          open: $stanza.find("feature[var=\"muc_open\"]").length
          passwordprotected: $stanza.find("feature[var=\"muc_passwordprotected\"]").length
          persistent: $stanza.find("feature[var=\"muc_persistent\"]").length
          publicroom: $stanza.find("feature[var=\"muc_public\"]").length
          semianonymous: $stanza.find("feature[var=\"muc_semianonymous\"]").length
          temporary: $stanza.find("feature[var=\"muc_temporary\"]").length
          unmoderated: $stanza.find("feature[var=\"muc_unmoderated\"]").length
        )
      , this)

  createChatRoom: (ev) ->
    ev.preventDefault()
    name = undefined
    server = undefined
    jid = undefined
    $name = undefined
    $server = undefined
    errors = undefined
    if ev.type is "click"
      jid = $(ev.target).attr("data-room-jid")
    else
      $name = @$el.find("input.new-chatroom-name")
      $nick = @$el.find("input.new-chatroom-nick")
      $server = @$el.find("input.new-chatroom-server")
      server = $server.val()
      nick = $nick.val()
      name = $name.val().trim().toLowerCase()
      $name.val "" # Clear the input
      if name and server and nick
        jid = Strophe.escapeNode(name) + "@" + server
        $name.removeClass "error"
        $nick.removeClass "error"
        $server.removeClass "error"
        @muc_domain = server
      else
        errors = true
        $name.addClass "error"  unless name
        $nick.addClass "error"  unless nick
        $server.addClass "error"  unless server
        return
    converse.chatboxes.create
      id: jid
      jid: jid
      name: Strophe.unescapeNode(Strophe.getNodeFromJid(jid))
      nick: nick
      chatroom: true
      box_id: hex_sha1(jid)

)
converse.ControlBoxView = converse.ChatBoxView.extend(
  tagName: "div"
  className: "chatbox"
  id: "controlbox"
  events:
    "click a.close-chatbox-button": "closeChat"
    "click ul#controlbox-tabs li a": "switchTab"

  initialize: ->
    @$el.appendTo converse.chatboxesview.$el
    @model.on "change", $.proxy((item, changed) ->
      i = undefined
      if _.has(item.changed, "connected")
        @render()
        converse.features.on "add", $.proxy(@featureAdded, this)
        
        # Features could have been added before the controlbox was
        # initialized. Currently we're only interested in MUC
        feature = converse.features.findWhere(var: "http://jabber.org/protocol/muc")
        @featureAdded feature  if feature
      @show()  if item.changed.visible is true  if _.has(item.changed, "visible")
    , this)
    @model.on "show", @show, this
    @model.on "destroy", @hide, this
    @model.on "hide", @hide, this
    @show()  if @model.get("visible")

  featureAdded: (feature) ->
    if feature.get("var") is "http://jabber.org/protocol/muc"
      @roomspanel.muc_domain = feature.get("from")
      $server = @$el.find("input.new-chatroom-server")
      $server.val @roomspanel.muc_domain  unless $server.is(":focus")
      @roomspanel.trigger "update-rooms-list"  if converse.auto_list_rooms

  template: _.template("<div class=\"chat-head oc-chat-head\">" + "<ul id=\"controlbox-tabs\"></ul>" + "<a class=\"close-chatbox-button\">X</a>" + "</div>" + "<div id=\"controlbox-panes\"></div>")
  switchTab: (ev) ->
    ev.preventDefault()
    $tab = $(ev.target)
    $sibling = $tab.parent().siblings("li").children("a")
    $tab_panel = $($tab.attr("href"))
    $sibling_panel = $($sibling.attr("href"))
    $sibling_panel.fadeOut "fast", ->
      $sibling.removeClass "current"
      $tab.addClass "current"
      $tab_panel.fadeIn "fast", ->



  addHelpMessages: (msgs) ->
    
    # Override addHelpMessages in ChatBoxView, for now do nothing.
    return

  render: ->
    @$el.html @template(@model.toJSON())
    if (not converse.prebind) and (not converse.connection)
      
      # Add login panel if the user still has to authenticate
      @loginpanel = new converse.LoginPanel()
      @loginpanel.$parent = @$el
      @loginpanel.render()
    else
      @contactspanel = new converse.ContactsPanel()
      @contactspanel.$parent = @$el
      @contactspanel.render()
      @roomspanel = new converse.RoomsPanel()
      @roomspanel.$parent = @$el
      @roomspanel.render()
    this
)
converse.ChatRoomView = converse.ChatBoxView.extend(
  length: 300
  tagName: "div"
  className: "chatroom"
  events:
    "click a.close-chatbox-button": "closeChat"
    "click a.configure-chatroom-button": "configureChatRoom"
    "keypress textarea.chat-textarea": "keyPressed"

  info_template: _.template("<div class=\"chat-event\">{{message}}</div>")
  sendChatRoomMessage: (body) ->
    match = body.replace(/^\s*/, "").match(/^\/(.*?)(?: (.*))?$/) or [false]
    $chat_content = undefined
    switch match[1]
      
      # TODO: Private messages
      when "msg", "topic"
        converse.connection.muc.setTopic @model.get("jid"), match[2]
      when "kick"
        converse.connection.muc.kick @model.get("jid"), match[2]
      when "ban"
        converse.connection.muc.ban @model.get("jid"), match[2]
      when "op"
        converse.connection.muc.op @model.get("jid"), match[2]
      when "deop"
        converse.connection.muc.deop @model.get("jid"), match[2]
      when "help"
        $chat_content = @$el.find(".chat-content")
        $chat_content.append "<div class=\"chat-help\"><strong>/help</strong>: Show this menu</div>" + "<div class=\"chat-help\"><strong>/topic</strong>: Set chatroom topic</div>"
        
        # TODO:
        #$chat_content.append($('<div class="chat-help"><strong>/kick</strong>: Kick out user</div>'));
        #$chat_content.append($('<div class="chat-help"><strong>/ban</strong>: Ban user</div>'));
        #$chat_content.append($('<div class="chat-help"><strong>/op $user</strong>: Remove messages</div>'));
        #$chat_content.append($('<div class="chat-help"><strong>/deop $user</strong>: Remove messages</div>'));
        #
        @scrollDown()
      else
        @last_msgid = converse.connection.muc.groupchat(@model.get("jid"), body)

  template: _.template("<div class=\"chat-head chat-head-chatroom\">" + "<a class=\"close-chatbox-button\">X</a>" + "<a class=\"configure-chatroom-button\" style=\"display:none\">&nbsp;</a>" + "<div class=\"chat-title\"> {{ name }} </div>" + "<p class=\"chatroom-topic\"><p/>" + "</div>" + "<div class=\"chat-body\">" + "<img class=\"spinner centered\" src=\"images/spinner.gif\"/>" + "</div>")
  chatarea_template: _.template("<div class=\"chat-area\">" + "<div class=\"chat-content\"></div>" + "<form class=\"sendXMPPMessage\" action=\"\" method=\"post\">" + "<textarea type=\"text\" class=\"chat-textarea\" " + "placeholder=\"Message\"/>" + "</form>" + "</div>" + "<div class=\"participants\">" + "<ul class=\"participant-list\"></ul>" + "</div>")
  render: ->
    @$el.attr("id", @model.get("box_id")).html @template(@model.toJSON())
    this

  renderChatArea: ->
    @$el.find("img.spinner.centered").remove()
    @$el.find(".chat-body").append @chatarea_template()
    this

  initialize: ->
    converse.connection.muc.join @model.get("jid"), @model.get("nick"), $.proxy(@onChatRoomMessage, this), $.proxy(@onChatRoomPresence, this), $.proxy(@onChatRoomRoster, this), null
    @model.messages.on "add", @showMessage, this
    @model.on "destroy", ((model, response, options) ->
      @$el.hide "fast"
      converse.connection.muc.leave @model.get("jid"), @model.get("nick"), @onLeave, `undefined`
    ), this
    @$el.appendTo converse.chatboxesview.$el
    @render().show().model.messages.fetch add: true

  onLeave: ->

  form_input_template: _.template("<label>{{label}}<input name=\"{{name}}\" type=\"{{type}}\" value=\"{{value}}\"></label>")
  select_option_template: _.template("<option value=\"{{value}}\">{{label}}</option>")
  form_select_template: _.template("<label>{{label}}<select name=\"{{name}}\">{{options}}</select></label>")
  form_checkbox_template: _.template("<label>{{label}}<input name=\"{{name}}\" type=\"{{type}}\" {{checked}}\"></label>")
  renderConfigurationForm: (stanza) ->
    $form = @$el.find("form.chatroom-form")
    $stanza = $(stanza)
    $fields = $stanza.find("field")
    title = $stanza.find("title").text()
    instructions = $stanza.find("instructions").text()
    i = undefined
    j = undefined
    options = []
    input_types =
      "text-private": "password"
      "text-single": "textline"
      boolean: "checkbox"
      hidden: "hidden"
      "list-single": "dropdown"

    $form.find("img.spinner").remove()
    $form.append $("<legend>").text(title)
    $form.append $("<p>").text(instructions)  unless instructions is title
    i = 0
    while i < $fields.length
      $field = $($fields[i])
      if $field.attr("type") is "list-single"
        options = []
        $options = $field.find("option")
        j = 0
        while j < $options.length
          options.push @select_option_template(
            value: $($options[j]).find("value").text()
            label: $($options[j]).attr("label")
          )
          j++
        $form.append @form_select_template(
          name: $field.attr("var")
          label: $field.attr("label")
          options: options.join("")
        )
      else if $field.attr("type") is "boolean"
        $form.append @form_checkbox_template(
          name: $field.attr("var")
          type: input_types[$field.attr("type")]
          label: $field.attr("label") or ""
          checked: $field.find("value").text() is "1" and "checked=\"1\"" or ""
        )
      else
        $form.append @form_input_template(
          name: $field.attr("var")
          type: input_types[$field.attr("type")]
          label: $field.attr("label") or ""
          value: $field.find("value").text()
        )
      i++
    $form.append "<input type=\"submit\" value=\"Save\"/>"
    $form.append "<input type=\"button\" value=\"Cancel\"/>"
    $form.on "submit", $.proxy(@saveConfiguration, this)
    $form.find("input[type=button]").on "click", $.proxy(@cancelConfiguration, this)

  field_template: _.template("<field var=\"{{name}}\"><value>{{value}}</value></field>")
  saveConfiguration: (ev) ->
    ev.preventDefault()
    that = this
    $inputs = $(ev.target).find(":input:not([type=button]):not([type=submit])")
    count = $inputs.length
    configArray = []
    $inputs.each ->
      $input = $(this)
      value = undefined
      if $input.is("[type=checkbox]")
        value = $input.is(":checked") and 1 or 0
      else
        value = $input.val()
      cnode = $(that.field_template(
        name: $input.attr("name")
        value: value
      ))[0]
      configArray.push cnode
      converse.connection.muc.saveConfiguration that.model.get("jid"), configArray, $.proxy(that.onConfigSaved, that), $.proxy(that.onErrorConfigSaved, that)  unless --count

    @$el.find("div.chatroom-form-container").hide ->
      $(this).remove()
      that.$el.find(".chat-area").show()
      that.$el.find(".participants").show()


  onConfigSaved: (stanza) ->

  
  # XXX
  onErrorConfigSaved: (stanza) ->
    @insertStatusNotification "An error occurred while trying to save the form."

  cancelConfiguration: (ev) ->
    ev.preventDefault()
    that = this
    @$el.find("div.chatroom-form-container").hide ->
      $(this).remove()
      that.$el.find(".chat-area").show()
      that.$el.find(".participants").show()


  configureChatRoom: (ev) ->
    ev.preventDefault()
    return  if @$el.find("div.chatroom-form-container").length
    @$el.find(".chat-area").hide()
    @$el.find(".participants").hide()
    @$el.find(".chat-body").append $("<div class=\"chatroom-form-container\">" + "<form class=\"chatroom-form\">" + "<img class=\"spinner centered\" src=\"images/spinner.gif\"/>" + "</form>" + "</div>")
    converse.connection.muc.configure @model.get("jid"), $.proxy(@renderConfigurationForm, this)

  renderPasswordForm: ->
    @$el.find("img.centered.spinner").remove()
    @$el.find(".chat-body").append $("<div class=\"chatroom-form-container\">" + "<form class=\"chatroom-form\">" + "<legend>This chat room requires a password</legend>" + "<label>Password: <input type=\"password\" name=\"password\"/></label>" + "<input type=\"submit\"/>" + "</form>" + "</div>")
    @$el.find(".chatroom-form").on "submit", $.proxy(@submitPassword, this)

  renderErrorMessage: (msg) ->
    @$el.find("img.centered.spinner").remove()
    @$el.find(".chat-body").append $("<p>" + msg + "</p>")

  submitPassword: (ev) ->
    ev.preventDefault()
    password = @$el.find(".chatroom-form").find("input[type=password]").val()
    @$el.find(".chatroom-form-container").replaceWith "<img class=\"spinner centered\" src=\"images/spinner.gif\"/>"
    converse.connection.muc.join @model.get("jid"), @model.get("nick"), $.proxy(@onChatRoomMessage, this), $.proxy(@onChatRoomPresence, this), $.proxy(@onChatRoomRoster, this), password

  onChatRoomPresence: (presence, room) ->
    nick = room.nick
    $presence = $(presence)
    from = $presence.attr("from")
    $item = undefined
    if $presence.attr("type") isnt "error"
      @renderChatArea()  unless @$el.find(".chat-area").length
      
      # This is a new chatroom. We create an instant
      # chatroom, and let the user manually set any
      # configuration setting.
      converse.connection.muc.createInstantRoom room.name  if $presence.find("status[code='201']").length
      
      # check for status 110 to see if it's our own presence
      if $presence.find("status[code='110']").length
        $item = $presence.find("item")
        @$el.find("a.configure-chatroom-button").show()  if $item.attr("affiliation") is "owner"  if $item.length
        
        # check if server changed our nick
        @model.set nick: Strophe.getResourceFromJid(from)  if $presence.find("status[code='210']").length
    else
      $error = $presence.find("error")
      $chat_content = @$el.find(".chat-content")
      
      # We didn't enter the room, so we must remove it from the MUC
      # add-on
      converse.connection.muc.removeRoom room.name
      if $error.attr("type") is "auth"
        if $error.find("not-authorized").length
          @renderPasswordForm()
        else if $error.find("registration-required").length
          @renderErrorMessage "You are not on the member list of this room"
        else @renderErrorMessage "You have been banned from this room"  if $error.find("forbidden").length
      else if $error.attr("type") is "modify"
        @renderErrorMessage "No nickname was specified"  if $error.find("jid-malformed").length
      else if $error.attr("type") is "cancel"
        if $error.find("not-allowed").length
          @renderErrorMessage "You are not allowed to create new rooms"
        else if $error.find("not-acceptable").length
          @renderErrorMessage "Your nickname doesn't conform to this room's policies"
        else if $error.find("conflict").length
          @renderErrorMessage "Your nickname is already taken"
        else if $error.find("item-not-found").length
          @renderErrorMessage "This room does not (yet) exist"
        else @renderErrorMessage "This room has reached it's maximum number of occupants"  if $error.find("service-unavailable").length
    true

  communicateStatusCodes: ($message, $chat_content) ->
    
    # Parse the message for status codes and communicate their purpose
    #* to the user.
    #* See: http://xmpp.org/registrar/mucstatus.html
    #
    status_messages =
      100: "This room is not anonymous"
      102: "This room now shows unavailable members"
      103: "This room does not show unavailable members"
      104: "Non-privacy-related room configuration has changed"
      170: "Room logging is now enabled"
      171: "Room logging is now disabled"
      172: "This room is now non-anonymous"
      173: "This room is now semi-anonymous"
      174: "This room is now fully-anonymous"

    $message.find("x").find("status").each $.proxy((idx, item) ->
      code = $(item).attr("code")
      message = code and status_messages[code] or null
      $chat_content.append @info_template(message: message)  if message
    , this)

  onChatRoomMessage: (message) ->
    $message = $(message)
    body = $message.children("body").text()
    jid = $message.attr("from")
    $chat_content = @$el.find(".chat-content")
    resource = Strophe.getResourceFromJid(jid)
    sender = resource and Strophe.unescapeNode(resource) or ""
    delayed = $message.find("delay").length > 0
    subject = $message.children("subject").text()
    match = undefined
    template = undefined
    message_datetime = undefined
    message_date = undefined
    dates = undefined
    isodate = undefined
    stamp = undefined
    if delayed
      stamp = $message.find("delay").attr("stamp")
      message_datetime = converse.parseISO8601(stamp)
    else
      message_datetime = new Date()
    
    # If this message is on a different day than the one received
    # prior, then indicate it on the chatbox.
    dates = $chat_content.find("time").map(->
      $(this).attr "datetime"
    ).get()
    message_date = new Date(message_datetime.getTime())
    message_date.setUTCHours 0, 0, 0, 0
    isodate = converse.toISOString(message_date)
    if _.indexOf(dates, isodate) is -1
      $chat_content.append @new_day_template(
        isodate: isodate
        datestring: message_date.toString().substring(0, 15)
      )
    @communicateStatusCodes $message, $chat_content
    if subject
      @$el.find(".chatroom-topic").text(subject).attr "title", subject
      $chat_content.append @info_template(message: "Topic set by " + sender + " to: " + subject)
    return true  unless body
    match = body.match(/^\/(.*?)(?: (.*))?$/)
    if (match) and (match[1] is "me")
      body = body.replace(/^\/me/, "*" + sender)
      template = @action_template
    else
      template = @message_template
    sender = "me"  if sender is @model.get("nick")
    $chat_content.append template(
      sender: sender is "me" and sender or "room"
      time: message_datetime.toLocaleTimeString().substring(0, 5)
      message: body
      username: sender
      extra_classes: delayed and "delayed" or ""
    )
    @scrollDown()
    true

  occupant_template: _.template("<li class=\"{{role}}\" " + "{[ if (role === \"moderator\") { ]}" + "title=\"This user is a moderator\"" + "{[ } ]}" + "{[ if (role === \"participant\") { ]}" + "title=\"This user can send messages in this room\"" + "{[ } ]}" + "{[ if (role === \"visitor\") { ]}" + "title=\"This user can NOT send messages in this room\"" + "{[ } ]}" + ">{{nick}}</li>")
  onChatRoomRoster: (roster, room) ->
    @renderChatArea()  unless @$el.find(".chat-area").length
    controlboxview = converse.chatboxesview.views.controlbox
    roster_size = _.size(roster)
    $participant_list = @$el.find(".participant-list")
    participants = []
    keys = _.keys(roster)
    i = undefined
    @$el.find(".participant-list").empty()
    i = 0
    while i < roster_size
      participants.push @occupant_template(
        role: roster[keys[i]].role
        nick: Strophe.unescapeNode(keys[i])
      )
      i++
    $participant_list.append participants.join("")
    true
)
converse.ChatBoxes = Backbone.Collection.extend(
  model: converse.ChatBox
  onConnected: ->
    @localStorage = new Backbone.LocalStorage(hex_sha1("converse.chatboxes-" + converse.bare_jid))
    unless @get("controlbox")
      @add
        id: "controlbox"
        box_id: "controlbox"

    else
      @get("controlbox").save()
    
    # This will make sure the Roster is set up
    @get("controlbox").set connected: true
    
    # Get cached chatboxes from localstorage
    @fetch
      add: true
      success: $.proxy((collection, resp) ->
        
        # If the controlbox was saved in localstorage, it must be visible
        @get("controlbox").set(visible: true).save()  if _.include(_.pluck(resp, "id"), "controlbox")
      , this)


  messageReceived: (message) ->
    partner_jid = undefined
    $message = $(message)
    message_from = $message.attr("from")
    
    # FIXME: Forwarded messages should be sent to specific resources,
    # not broadcasted
    return true  if message_from is converse.connection.jid
    $forwarded = $message.children("forwarded")
    $message = $forwarded.children("message")  if $forwarded.length
    from = Strophe.getBareJidFromJid(message_from)
    to = Strophe.getBareJidFromJid($message.attr("to"))
    resource = undefined
    chatbox = undefined
    if from is converse.bare_jid
      
      # I am the sender, so this must be a forwarded message...
      partner_jid = to
      resource = Strophe.getResourceFromJid($message.attr("to"))
    else
      partner_jid = from
      resource = Strophe.getResourceFromJid(message_from)
    chatbox = @get(partner_jid)
    unless chatbox
      converse.getVCard partner_jid, $.proxy((jid, fullname, image, image_type, url) ->
        chatbox = @create(
          id: jid
          jid: jid
          fullname: fullname
          image_type: image_type
          image: image
          url: url
        )
        chatbox.messageReceived message
        converse.roster.addResource partner_jid, resource
      , this), $.proxy(->
        
        # # FIXME
        console.log "An error occured while fetching vcard"
      , this)
      return true
    chatbox.messageReceived message
    converse.roster.addResource partner_jid, resource
    true
)
converse.ChatBoxesView = Backbone.View.extend(
  el: "#collective-xmpp-chat-data"
  initialize: ->
    
    # boxesviewinit
    @views = {}
    @model.on "add", ((item) ->
      view = @views[item.get("id")]
      unless view
        if item.get("chatroom")
          view = new converse.ChatRoomView(model: item)
        else if item.get("box_id") is "controlbox"
          view = new converse.ControlBoxView(model: item)
          view.render()
        else
          view = new converse.ChatBoxView(model: item)
        @views[item.get("id")] = view
      else
        view.model = item
        view.initialize()
        
        # FIXME: Why is it necessary to again append chatboxes?
        view.$el.appendTo @$el  if item.get("id") isnt "controlbox"
    ), this
)
converse.RosterItem = Backbone.Model.extend(initialize: (attributes, options) ->
  jid = attributes.jid
  attributes.fullname = jid  unless attributes.fullname
  _.extend attributes,
    id: jid
    user_id: Strophe.getNodeFromJid(jid)
    resources: []
    chat_status: "offline"
    status: "offline"
    sorted: false

  @set attributes
)
converse.RosterItemView = Backbone.View.extend(
  tagName: "dd"
  events:
    "click .accept-xmpp-request": "acceptRequest"
    "click .decline-xmpp-request": "declineRequest"
    "click .open-chat": "openChat"
    "click .remove-xmpp-contact": "removeContact"

  openChat: (ev) ->
    ev.preventDefault()
    jid = Strophe.getBareJidFromJid(@model.get("jid"))
    chatbox = converse.chatboxes.get(jid)
    if chatbox
      chatbox.trigger "show"
    else
      converse.chatboxes.create
        id: @model.get("jid")
        jid: @model.get("jid")
        fullname: @model.get("fullname")
        image_type: @model.get("image_type")
        image: @model.get("image")
        url: @model.get("url")


  removeContact: (ev) ->
    ev.preventDefault()
    result = confirm("Are you sure you want to remove this contact?")
    if result is true
      bare_jid = @model.get("jid")
      converse.connection.roster.remove bare_jid, (iq) ->
        converse.connection.roster.unauthorize bare_jid
        converse.rosterview.model.remove bare_jid


  acceptRequest: (ev) ->
    jid = @model.get("jid")
    converse.connection.roster.authorize jid
    converse.connection.roster.add jid, @model.get("fullname"), [], (iq) ->
      converse.connection.roster.subscribe jid, null, converse.xmppstatus.get("fullname")

    ev.preventDefault()

  declineRequest: (ev) ->
    ev.preventDefault()
    converse.connection.roster.unauthorize @model.get("jid")
    @model.destroy()

  template: _.template("<a class=\"open-chat\" title=\"Click to chat with this contact\" href=\"#\">{{ fullname }}</a>" + "<a class=\"remove-xmpp-contact\" title=\"Click to remove this contact\" href=\"#\"></a>")
  pending_template: _.template("<span>{{ fullname }}</span>" + "<a class=\"remove-xmpp-contact\" title=\"Click to remove this contact\" href=\"#\"></a>")
  request_template: _.template("<div>{{ fullname }}</div>" + "<button type=\"button\" class=\"accept-xmpp-request\">" + "Accept</button>" + "<button type=\"button\" class=\"decline-xmpp-request\">" + "Decline</button>" + "")
  render: ->
    item = @model
    ask = item.get("ask")
    subscription = item.get("subscription")
    @$el.addClass item.get("chat_status")
    if ask is "subscribe"
      @$el.addClass "pending-xmpp-contact"
      @$el.html @pending_template(item.toJSON())
    else if ask is "request"
      @$el.addClass "requesting-xmpp-contact"
      @$el.html @request_template(item.toJSON())
      converse.showControlBox()
    else if subscription is "both" or subscription is "to"
      @$el.addClass "current-xmpp-contact"
      @$el.html @template(item.toJSON())
    this

  initialize: ->
    @options.model.on "change", ((item, changed) ->
      @$el.attr "class", item.changed.chat_status  if _.has(item.changed, "chat_status")
    ), this
)
converse.getVCard = (jid, callback, errback) ->
  converse.connection.vcard.get $.proxy((iq) ->
    $vcard = $(iq).find("vCard")
    fullname = $vcard.find("FN").text()
    img = $vcard.find("BINVAL").text()
    img_type = $vcard.find("TYPE").text()
    url = $vcard.find("URL").text()
    callback jid, fullname, img, img_type, url
  , this), jid, errback

converse.RosterItems = Backbone.Collection.extend(
  model: converse.RosterItem
  comparator: (rosteritem) ->
    chat_status = rosteritem.get("chat_status")
    rank = 4
    switch chat_status
      when "offline"
        rank = 0
      when "unavailable"
        rank = 1
      when "xa"
        rank = 2
      when "away"
        rank = 3
      when "dnd"
        rank = 4
      when "online"
        rank = 5
    rank

  subscribeToSuggestedItems: (msg) ->
    $(msg).find("item").each ->
      $this = $(this)
      jid = $this.attr("jid")
      action = $this.attr("action")
      fullname = $this.attr("name")
      if action is "add"
        converse.connection.roster.add jid, fullname, [], (iq) ->
          converse.connection.roster.subscribe jid, null, converse.xmppstatus.get("fullname")


    true

  isSelf: (jid) ->
    Strophe.getBareJidFromJid(jid) is Strophe.getBareJidFromJid(converse.connection.jid)

  getItem: (id) ->
    Backbone.Collection::get.call this, id

  addResource: (bare_jid, resource) ->
    item = @getItem(bare_jid)
    resources = undefined
    if item
      resources = item.get("resources")
      if resources
        if _.indexOf(resources, resource) is -1
          resources.push resource
          item.set resources: resources
      else
        item.set resources: [resource]

  removeResource: (bare_jid, resource) ->
    item = @getItem(bare_jid)
    resources = undefined
    idx = undefined
    if item
      resources = item.get("resources")
      idx = _.indexOf(resources, resource)
      if idx isnt -1
        resources.splice idx, 1
        item.set resources: resources
        return resources.length
    0

  subscribeBack: (jid) ->
    bare_jid = Strophe.getBareJidFromJid(jid)
    if converse.connection.roster.findItem(bare_jid)
      converse.connection.roster.authorize bare_jid
      converse.connection.roster.subscribe jid, null, converse.xmppstatus.get("fullname")
    else
      converse.connection.roster.add jid, "", [], (iq) ->
        converse.connection.roster.authorize bare_jid
        converse.connection.roster.subscribe jid, null, converse.xmppstatus.get("fullname")


  unsubscribe: (jid) ->
    
    # Upon receiving the presence stanza of type "unsubscribed",
    #* the user SHOULD acknowledge receipt of that subscription state
    #* notification by sending a presence stanza of type "unsubscribe"
    #* this step lets the user's server know that it MUST no longer
    #* send notification of the subscription state change to the user.
    #
    converse.xmppstatus.sendPresence "unsubscribe"
    if converse.connection.roster.findItem(jid)
      converse.connection.roster.remove jid, (iq) ->
        converse.rosterview.model.remove jid


  getNumOnlineContacts: ->
    count = 0
    models = @models
    models_length = models.length
    i = undefined
    i = 0
    while i < models_length
      count++  if _.indexOf(["offline", "unavailable"], models[i].get("chat_status")) is -1
      i++
    count

  cleanCache: (items) ->
    
    # The localstorage cache containing roster contacts might contain
    #* some contacts that aren't actually in our roster anymore. We
    #* therefore need to remove them now.
    #
    id = undefined
    i = undefined
    roster_ids = []
    i = 0
    while i < items.length
      roster_ids.push items[i].jid
      ++i
    i = 0
    while i < @models.length
      id = @models[i].get("id")
      @getItem(id).destroy()  if _.indexOf(roster_ids, id) is -1
      ++i

  rosterHandler: (items) ->
    @cleanCache items
    _.each items, ((item, index, items) ->
      return  if @isSelf(item.jid)
      model = @getItem(item.jid)
      unless model
        is_last = false
        is_last = true  if index is (items.length - 1)
        @create
          jid: item.jid
          subscription: item.subscription
          ask: item.ask
          fullname: item.name or item.jid
          is_last: is_last

      else
        if (item.subscription is "none") and (item.ask is null)
          
          # This user is no longer in our roster
          model.destroy()
        else if model.get("subscription") isnt item.subscription or model.get("ask") isnt item.ask
          
          # only modify model attributes if they are different from the
          # ones that were already set when the rosterItem was added
          model.set
            subscription: item.subscription
            ask: item.ask

          model.save()
    ), this

  presenceHandler: (presence) ->
    $presence = $(presence)
    jid = $presence.attr("from")
    bare_jid = Strophe.getBareJidFromJid(jid)
    resource = Strophe.getResourceFromJid(jid)
    presence_type = $presence.attr("type")
    $show = $presence.find("show")
    chat_status = $show.text() or "online"
    status_message = $presence.find("status")
    item = undefined
    if @isSelf(bare_jid)
      
      # Another resource has changed it's status, we'll update ours as well.
      # FIXME: We should ideally differentiate between converse.js using
      # resources and other resources (i.e Pidgin etc.)
      converse.xmppstatus.set status: chat_status  if (converse.connection.jid isnt jid) and (presence_type isnt "unavailabe")
      return true
    else return true  if ($presence.find("x").attr("xmlns") or "").indexOf(Strophe.NS.MUC) is 0 # Ignore MUC
    item = @getItem(bare_jid)
    item.set status: status_message.text()  if item and (status_message.text() isnt item.get("status"))
    if (presence_type is "error") or (presence_type is "subscribed") or (presence_type is "unsubscribe")
      return true
    else if presence_type is "subscribe"
      if converse.auto_subscribe
        if (not item) or (item.get("subscription") isnt "to")
          @subscribeBack jid
        else
          converse.connection.roster.authorize bare_jid
      else
        if (item) and (item.get("subscription") isnt "none")
          converse.connection.roster.authorize bare_jid
        else
          converse.getVCard bare_jid, $.proxy((jid, fullname, img, img_type, url) ->
            @add
              jid: bare_jid
              subscription: "none"
              ask: "request"
              fullname: fullname
              image: img
              image_type: img_type
              url: url
              is_last: true

          , this), $.proxy((jid, fullname, img, img_type, url) ->
            console.log "Error while retrieving vcard"
            @add
              jid: bare_jid
              subscription: "none"
              ask: "request"
              fullname: jid
              is_last: true

          , this)
    else if presence_type is "unsubscribed"
      @unsubscribe bare_jid
    else if presence_type is "unavailable"
      item.set chat_status: "offline"  if item  if @removeResource(bare_jid, resource) is 0
    else if item
      
      # presence_type is undefined
      @addResource bare_jid, resource
      item.set chat_status: chat_status
    true
)
converse.RosterView = Backbone.View.extend(
  tagName: "dl"
  id: "converse-roster"
  rosteritemviews: {}
  removeRosterItem: (item) ->
    view = @rosteritemviews[item.id]
    if view
      view.$el.remove()
      delete @rosteritemviews[item.id]

      @render()

  initialize: ->
    @model.on "add", ((item) ->
      view = new converse.RosterItemView(model: item)
      @rosteritemviews[item.id] = view
      @render item
    ), this
    @model.on "change", ((item, changed) ->
      return  if (_.size(item.changed) is 1) and _.contains(_.keys(item.changed), "sorted")
      @updateChatBox item, changed
      @render item
    ), this
    @model.on "remove", ((item) ->
      @removeRosterItem item
    ), this
    @model.on "destroy", ((item) ->
      @removeRosterItem item
    ), this
    @$el.hide().html @template()
    @model.fetch add: true # Get the cached roster items from localstorage
    @initialSort()
    @$el.appendTo converse.chatboxesview.views.controlbox.contactspanel.$el

  updateChatBox: (item, changed) ->
    chatbox = converse.chatboxes.get(item.get("jid"))
    changes = {}
    return  unless chatbox
    changes.chat_status = item.get("chat_status")  if _.has(item.changed, "chat_status")
    changes.status = item.get("status")  if _.has(item.changed, "status")
    chatbox.save changes

  template: _.template("<dt id=\"xmpp-contact-requests\">Contact requests</dt>" + "<dt id=\"xmpp-contacts\">My contacts</dt>" + "<dt id=\"pending-xmpp-contacts\">Pending contacts</dt>")
  render: (item) ->
    $my_contacts = @$el.find("#xmpp-contacts")
    $contact_requests = @$el.find("#xmpp-contact-requests")
    $pending_contacts = @$el.find("#pending-xmpp-contacts")
    $count = undefined
    presence_change = undefined
    if item
      jid = item.id
      view = @rosteritemviews[item.id]
      ask = item.get("ask")
      subscription = item.get("subscription")
      crit = order: "asc"
      if ask is "subscribe"
        $pending_contacts.after view.render().el
        $pending_contacts.after $pending_contacts.siblings("dd.pending-xmpp-contact").tsort(crit)
      else if ask is "request"
        $contact_requests.after view.render().el
        $contact_requests.after $contact_requests.siblings("dd.requesting-xmpp-contact").tsort(crit)
      else if subscription is "both" or subscription is "to"
        unless item.get("sorted")
          
          # this attribute will be true only after all of the elements have been added on the page
          # at this point all offline
          $my_contacts.after view.render().el
        else
          
          # just by calling render will be enough to change the icon of the existing item without
          # having to reinsert it and the sort will come from the presence change
          view.render()
      presence_change = view.model.changed.chat_status
      if presence_change
        
        # resort all items only if the model has changed it's chat_status as this render
        # is also triggered when the resource is changed which always comes before the presence change
        # therefore we avoid resorting when the change doesn't affect the position of the item
        $my_contacts.after $my_contacts.siblings("dd.current-xmpp-contact.offline").tsort("a", crit)
        $my_contacts.after $my_contacts.siblings("dd.current-xmpp-contact.unavailable").tsort("a", crit)
        $my_contacts.after $my_contacts.siblings("dd.current-xmpp-contact.away").tsort("a", crit)
        $my_contacts.after $my_contacts.siblings("dd.current-xmpp-contact.dnd").tsort("a", crit)
        $my_contacts.after $my_contacts.siblings("dd.current-xmpp-contact.online").tsort("a", crit)
      if item.get("is_last") and not item.get("sorted")
        
        # this will be true after all of the roster items have been added with the default
        # options where all of the items are offline and now we can show the rosterView
        item.set "sorted", true
        @initialSort()
        @$el.show()
    
    # Hide the headings if there are no contacts under them
    _.each [$my_contacts, $contact_requests, $pending_contacts], (h) ->
      if h.nextUntil("dt").length
        h.show()
      else
        h.hide()

    $count = $("#online-count")
    $count.text "(" + @model.getNumOnlineContacts() + ")"
    $count.show()  unless $count.is(":visible")
    this

  initialSort: ->
    $my_contacts = @$el.find("#xmpp-contacts")
    crit = order: "asc"
    $my_contacts.after $my_contacts.siblings("dd.current-xmpp-contact.offline").tsort("a", crit)
    $my_contacts.after $my_contacts.siblings("dd.current-xmpp-contact.unavailable").tsort("a", crit)
)
converse.XMPPStatus = Backbone.Model.extend(
  initialize: ->
    @set
      status: @get("status")
      status_message: @get("status_message")
      fullname: @get("fullname")


  initStatus: ->
    stat = @get("status")
    if stat is `undefined`
      @save status: "online"
    else
      @sendPresence stat

  sendPresence: (type) ->
    status_message = @get("status_message")
    presence = undefined
    
    # Most of these presence types are actually not explicitly sent,
    # but I add all of them here fore reference and future proofing.
    if (type is "unavailable") or (type is "probe") or (type is "error") or (type is "unsubscribe") or (type is "unsubscribed") or (type is "subscribe") or (type is "subscribed")
      presence = $pres(type: type)
    else
      if type is "online"
        presence = $pres()
      else
        presence = $pres().c("show").t(type).up()
      presence.c("status").t status_message  if status_message
    converse.connection.send presence

  setStatus: (value) ->
    @sendPresence value
    @save status: value

  setStatusMessage: (status_message) ->
    converse.connection.send $pres().c("show").t(@get("status")).up().c("status").t(status_message)
    @save status_message: status_message
)
converse.XMPPStatusView = Backbone.View.extend(
  el: "span#xmpp-status-holder"
  events:
    "click a.choose-xmpp-status": "toggleOptions"
    "click #fancy-xmpp-status-select a.change-xmpp-status-message": "renderStatusChangeForm"
    "submit #set-custom-xmpp-status": "setStatusMessage"
    "click .dropdown dd ul li a": "setStatus"

  toggleOptions: (ev) ->
    ev.preventDefault()
    $(ev.target).parent().parent().siblings("dd").find("ul").toggle "fast"

  change_status_message_template: _.template("<form id=\"set-custom-xmpp-status\">" + "<input type=\"text\" class=\"custom-xmpp-status\" {{ status_message }}\" placeholder=\"Custom status\"/>" + "<button type=\"submit\">Save</button>" + "</form>")
  status_template: _.template("<div class=\"xmpp-status\">" + "<a class=\"choose-xmpp-status {{ chat_status }}\" data-value=\"{{status_message}}\" href=\"#\" title=\"Click to change your chat status\">" + "{{ status_message }}" + "</a>" + "<a class=\"change-xmpp-status-message\" href=\"#\" Title=\"Click here to write a custom status message\"></a>" + "</div>")
  renderStatusChangeForm: (ev) ->
    ev.preventDefault()
    status_message = @model.get("status") or "offline"
    input = @change_status_message_template(status_message: status_message)
    @$el.find(".xmpp-status").replaceWith input
    @$el.find(".custom-xmpp-status").focus().focus()

  setStatusMessage: (ev) ->
    ev.preventDefault()
    status_message = $(ev.target).find("input").attr("value")
    status_message is ""
    @model.setStatusMessage status_message

  setStatus: (ev) ->
    ev.preventDefault()
    $el = $(ev.target)
    value = $el.attr("data-value")
    @model.setStatus value
    @$el.find(".dropdown dd ul").hide()

  getPrettyStatus: (stat) ->
    if stat is "chat"
      pretty_status = "online"
    else if stat is "dnd"
      pretty_status = "busy"
    else if stat is "xa"
      pretty_status = "away for long"
    else
      pretty_status = stat or "online"
    pretty_status

  updateStatusUI: (model) ->
    return  if not (_.has(model.changed, "status")) and not (_.has(model.changed, "status_message"))
    stat = model.get("status")
    status_message = model.get("status_message") or "I am " + @getPrettyStatus(stat)
    @$el.find("#fancy-xmpp-status-select").html @status_template(
      chat_status: stat
      status_message: status_message
    )

  choose_template: _.template("<dl id=\"target\" class=\"dropdown\">" + "<dt id=\"fancy-xmpp-status-select\" class=\"fancy-dropdown\"></dt>" + "<dd><ul></ul></dd>" + "</dl>")
  option_template: _.template("<li>" + "<a href=\"#\" class=\"{{ value }}\" data-value=\"{{ value }}\">{{ text }}</a>" + "</li>")
  initialize: ->
    @model.on "change", @updateStatusUI, this

  render: ->
    
    # Replace the default dropdown with something nicer
    $select = @$el.find("select#select-xmpp-status")
    chat_status = @model.get("status") or "offline"
    options = $("option", $select)
    $options_target = undefined
    options_list = []
    that = this
    @$el.html @choose_template()
    @$el.find("#fancy-xmpp-status-select").html @status_template(
      status_message: "I am " + @getPrettyStatus(chat_status)
      chat_status: chat_status
    )
    
    # iterate through all the <option> elements and add option values
    options.each ->
      options_list.push that.option_template(
        value: $(this).val()
        text: @text
      )

    $options_target = @$el.find("#target dd ul").hide()
    $options_target.append options_list.join("")
    $select.remove()
    this
)
converse.Feature = Backbone.Model.extend()
converse.Features = Backbone.Collection.extend(
  
  # Service Discovery
  #* -----------------
  #* This collection stores Feature Models, representing features
  #* provided by available XMPP entities (e.g. servers)
  #* See XEP-0030 for more details: http://xmpp.org/extensions/xep-0030.html
  #* All features are shown here: http://xmpp.org/registrar/disco-features.html
  #
  model: converse.Feature
  initialize: ->
    @localStorage = new Backbone.LocalStorage(hex_sha1("converse.features" + converse.bare_jid))
    if @localStorage.records.length is 0
      
      # localStorage is empty, so we've likely never queried this
      # domain for features yet
      converse.connection.disco.info converse.domain, null, $.proxy(@onInfo, this)
      converse.connection.disco.items converse.domain, null, $.proxy(@onItems, this)
    else
      @fetch add: true

  onItems: (stanza) ->
    $(stanza).find("query item").each $.proxy((idx, item) ->
      converse.connection.disco.info $(item).attr("jid"), null, $.proxy(@onInfo, this)
    , this)

  onInfo: (stanza) ->
    $stanza = $(stanza)
    
    # This isn't an IM server component
    return  if ($stanza.find("identity[category=server][type=im]").length is 0) and ($stanza.find("identity[category=conference][type=text]").length is 0)
    $stanza.find("feature").each $.proxy((idx, feature) ->
      @create
        var: $(feature).attr("var")
        from: $stanza.attr("from")

    , this)
)
converse.LoginPanel = Backbone.View.extend(
  tagName: "div"
  id: "login-dialog"
  events:
    "submit form#converse-login": "authenticate"

  tab_template: _.template("<li><a class=\"current\" href=\"#login\">Sign in</a></li>")
  template: _.template("<form id=\"converse-login\">" + "<label>XMPP/Jabber Username:</label>" + "<input type=\"text\" id=\"jid\">" + "<label>Password:</label>" + "<input type=\"password\" id=\"password\">" + "<input class=\"login-submit\" type=\"submit\" value=\"Log In\">" + "</form\">")
  bosh_url_input: _.template("<label>BOSH Service URL:</label>" + "<input type=\"text\" id=\"bosh_service_url\">")
  connect: (jid, password) ->
    connection = new Strophe.Connection(converse.bosh_service_url)
    connection.connect jid, password, $.proxy((status, message) ->
      if status is Strophe.Status.CONNECTED
        console.log "Connected"
        converse.onConnected connection
      else if status is Strophe.Status.DISCONNECTED
        $button.show().siblings("img").remove()
        converse.giveFeedback "Disconnected", "error"
      else if status is Strophe.Status.Error
        $button.show().siblings("img").remove()
        converse.giveFeedback "Error", "error"
      else if status is Strophe.Status.CONNECTING
        converse.giveFeedback "Connecting"
      else if status is Strophe.Status.CONNFAIL
        $button.show().siblings("img").remove()
        converse.giveFeedback "Connection Failed", "error"
      else if status is Strophe.Status.AUTHENTICATING
        converse.giveFeedback "Authenticating"
      else if status is Strophe.Status.AUTHFAIL
        $button.show().siblings("img").remove()
        converse.giveFeedback "Authentication Failed", "error"
      else if status is Strophe.Status.DISCONNECTING
        converse.giveFeedback "Disconnecting", "error"
      else console.log "Attached"  if status is Strophe.Status.ATTACHED
    , this)

  authenticate: (ev) ->
    ev.preventDefault()
    $form = $(ev.target)
    $jid_input = $form.find("input#jid")
    jid = $jid_input.val()
    $pw_input = $form.find("input#password")
    password = $pw_input.val()
    $bsu_input = null
    errors = false
    unless converse.bosh_service_url
      $bsu_input = $form.find("input#bosh_service_url")
      converse.bosh_service_url = $bsu_input.val()
      unless converse.bosh_service_url
        errors = true
        $bsu_input.addClass "error"
    unless jid
      errors = true
      $jid_input.addClass "error"
    unless password
      errors = true
      $pw_input.addClass "error"
    return  if errors
    $button = $form.find("input[type=submit]")
    $button.hide().after "<img class=\"spinner login-submit\" src=\"images/spinner.gif\"/>"
    @connect jid, password

  remove: ->
    @$parent.find("#controlbox-tabs").empty()
    @$parent.find("#controlbox-panes").empty()

  render: ->
    @$parent.find("#controlbox-tabs").append @tab_template()
    template = @template()
    template.find("form").append @bosh_url_input  unless @bosh_url_input
    @$parent.find("#controlbox-panes").append @$el.html(template)
    @$el.find("input#jid").focus()
    this
)
converse.showControlBox = ->
  controlbox = @chatboxes.get("controlbox")
  unless controlbox
    @chatboxes.add
      id: "controlbox"
      box_id: "controlbox"
      visible: true

    @chatboxes.get("controlbox").save()  if @connection
  else
    controlbox.trigger "show"

converse.toggleControlBox = ->
  if $("div#controlbox").is(":visible")
    controlbox = @chatboxes.get("controlbox")
    if @connection
      controlbox.destroy()
    else
      controlbox.trigger "hide"
  else
    @showControlBox()

converse.giveFeedback = (message, klass) ->
  $(".conn-feedback").text message
  $(".conn-feedback").attr "class", "conn-feedback"
  $(".conn-feedback").addClass klass  if klass

converse.onConnected = (connection) ->
  @connection = connection
  @connection.xmlInput = (body) ->
    console.log body

  @connection.xmlOutput = (body) ->
    console.log body

  @bare_jid = Strophe.getBareJidFromJid(@connection.jid)
  @domain = Strophe.getDomainFromJid(@connection.jid)
  @features = new @Features()
  
  # Set up the roster
  @roster = new @RosterItems()
  @roster.localStorage = new Backbone.LocalStorage(hex_sha1("converse.rosteritems-" + @bare_jid))
  @xmppstatus = new @XMPPStatus(id: 1)
  @xmppstatus.localStorage = new Backbone.LocalStorage(hex_sha1("converse.xmppstatus-" + @bare_jid))
  @chatboxes.onConnected()
  @rosterview = new @RosterView(model: @roster)
  @xmppstatusview = new @XMPPStatusView(model: @xmppstatus).render()
  @xmppstatus.fetch success: $.proxy((xmppstatus, resp) ->
    unless xmppstatus.get("fullname")
      # No 'to' attr when getting one's own vCard
      @getVCard null, $.proxy((jid, fullname, image, image_type, url) ->
        @xmppstatus.save fullname: fullname
      , this)
  , this)
  @connection.addHandler $.proxy(@roster.subscribeToSuggestedItems, @roster), "http://jabber.org/protocol/rosterx", "message", null
  @connection.roster.registerCallback $.proxy(@roster.rosterHandler, @roster), null, "presence", null
  @connection.roster.get $.proxy(->
    @connection.addHandler $.proxy((presence) ->
      @presenceHandler presence
      true
    , @roster), null, "presence", null
    @connection.addHandler $.proxy((message) ->
      @chatboxes.messageReceived message
      true
    , this), null, "message", "chat"
    @xmppstatus.initStatus()
  , this)
  $(window).on "blur focus", $.proxy((e) ->
    converse.clearMsgCounter()  if (@windowState isnt e.type) and (e.type is "focus")
    @windowState = e.type
  , this)
  @giveFeedback "Online Contacts"

converse.initialize = (settings) ->
  
  # Default values
  @animate = true
  @auto_list_rooms = false
  @auto_subscribe = false
  @hide_muc_server = false
  @prebind = false
  @xhr_user_search = false
  _.extend this, settings
  @chatboxes = new @ChatBoxes()
  @chatboxesview = new @ChatBoxesView(model: @chatboxes)
  $("a.toggle-online-users").bind "click", $.proxy((e) ->
    e.preventDefault()
    @toggleControlBox()
  , this)

return converse