###!
* NEWS FEED COMPONENT
###
class App.Components.NewsFeed
  constructor: (@settings) ->
    App.logInfo "New History: in '#{@settings.el}'"
    Self = @
    Self = _.extend(Self,Backbone.Events)

    @$container = $(@settings.el)
    ###
    LIST SETUP
    ###
    @$list = $('<div class="history-list"></div>')

    class @Collection extends App.Collection
      parse: (response) ->
        return response.PAYLOAD
      url:"/admin/_com/ajax_history.cfc?method=list"

    ###
    FILTER OPTIONS SETUP
    ###
    filterHtml = '<div class="history-filter btn-group"></div>'
    

    ###
    FILTER BUTTONS
    ###
    @$filters = $(filterHtml)
    filterTemplate = _.template('<a href="" class="btn" data-mode="<%= filter%>"><%= label%></a>')
    console.log @settings.modes
    #LOOP OVER PROVIDED MODES AND GET CONFIG INFO FROM FILTERTYPES
    _.each @settings.modes,(mode,key) ->
      console.log "#{mode},#{key}"
      filterContext = Self.filterTypes[Self.settings.hub][mode]
      console.log filterContext
      $filter = $(filterTemplate(filterContext))
      Self.$filters.append($filter)
      
      $filter.on "click", (e) ->
        $link = $(this)
        mode = $link.data("mode")
        label = $link.text()
        Self.lister.setMode mode
        Self.lister.getList true
        $link.siblings(".active").removeClass "active"
        $link.addClass "active"
        e.preventDefault()
      return true

    @$filters.appendTo @$container
    @$list.appendTo @$container
    @collection = new @Collection()

    ###
    PRIMARY LIST VIEW
    ###
    class ListerView extends App.View
      constructor: (properties) ->
        # SET DEFAULT VALUES 
        self = this
        settings = properties

        @setMode = (mode) ->
          settings.mode = mode

        @setStartRow = (startrow) ->
          settings.data.startrow = startrow

        @setMaxRows = (maxrows) ->
          settings.data.maxrows = maxrows

        @getList = (clear, startTime, inject) ->
          inject = "append"  unless inject
          settings.data.starttime = startTime

          # switch settings.mode
          #   when "activityTo"
          #     dataToSend.activityTo = settings.data.activityto
          #   when "personTo"
          #     dataToSend.personTo = settings.data.personto
          #   when "personFrom"
          #     dataToSend.personFrom = settings.data.personfrom
          #   when "personAll"
          #     dataToSend.personTo = settings.data.personto
          #     dataToSend.personFrom = settings.data.personfrom
          #   when "all"
          #     dataToSend.startrow = settings.data.startrow
          #dataToSend.maxrows = settings.data.maxrows
          
          if clear
            Self.$list.empty()
          Self.listHistory settings.data, inject
          return
        return
    
    ###
    LISTER VIEW SETUP
    ###
    listerParams = _.defaults({
      startrow:1
      maxrows:25
    },@settings.queryParams)
    
    @lister = new ListerView
      mode: @settings.defaultMode
      appendto: @$list
      data: listerParams  

    #returns

    ###
    START THE LIST
    ###
    @lister.getList true
    return {
      lister: Self.lister
    }
  
  filterTypes:
    person:
      "personAll":
        "label":'All'
        "filter":'personAll'
      "personTo":
        "label":'To Person'
        "filter":'personTo'
      "personFrom":
        "label":'By Person'
        "filter":'personFrom'
    activity:
      "activityAll":
        "label":'All'
        "filter":'activityTo'
    user:
      "personTo":
        "label":'To Me'
        "filter":'personTo'
      "personFrom":
        "label":'By Me'
        "filter":'personFrom'

  itemTemplate: _.template('<div class="history-item" id="history-item-<%=row.HISTORYID%>">
                              <div class="history-line">
                                <img src="/admin/_images/icons/<%=row.ICONIMG%>" border="0" />
                                <%=content%>
                              </div>
                              <% if(subcontent) { %>
                              <div class="history-subbox clearfix"><%=subcontent%></div>
                              <% } %>
                              <div class="history-meta">
                                <a title="<%=row.CREATED%>">
                                <%=row.CREATED%>
                                </a>
                              </div>
                            </div>')
  listHistory: (params, inject) ->
    Self = @
    output = ""
    
    @collection.fetch
      data: params
      success: (newsItems, response, options) ->
        newsItems.each (itemModel) ->
          item = itemModel.attributes
          $historyitem = ""
          rendered = Self.renderItem(item)
          if inject is "append"
            Self.$list.append rendered
            $historyitem = $("#history-item-" + item.HISTORYID)
            $historyitem.show()
          else if inject is "prepend"
            Self.$list.prepend Self.renderItem(item)
            $historyitem = $("#history-item-" + item.HISTORYID)
            $historyitem.fadeIn()
          $historyitem.find(".history-meta a").prettyDate()
          $historyitem.find(".prettydate").prettyDate()
          setInterval (->
            $historyitem.find(".history-meta a").prettyDate()
          ), 5000
          setInterval (->
            $historyitem.find(".prettydate").prettyDate()
          ), 5000
        return
    return

  stop: ->
    
  renderItem: (row) ->
    Self = @
    re = /\%[A-Za-z]+\%/g
    itemContext =
      content: row.TEMPLATEFROM
      subcontent: $.Replace(row.TOCONTENT, "/index.cfm/event/", sMyself, "ALL") || ""
      row: row

    aFoundFields = _.flatten(itemContext.content.match(re))
    aFoundFields = _.unique(aFoundFields)
    sOutput = ""

    _.each aFoundFields, (value,key,list) ->
      itemContext.content = $.Replace itemContext.content, value, row[value.replace(/%/g,'').toUpperCase()], "ALL"
      return true

    sOutput = @itemTemplate(itemContext)
    #sOutput = sOutput.replace /g/%,''
    sOutput