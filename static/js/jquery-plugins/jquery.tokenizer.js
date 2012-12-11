/* THE GOAL OF THIS PLUGIN IS TO MAKE AN FB-STYLE TOKENIZER WITH PHOTO OPTION
accepts json data each object containing three fields, a label, a value, and an image path */

/* As much as I love the jQuery UI framework it was a goal of mine to keep this agnostic of that as much as possible. */
/* for now, it will be dependent on the jquery UI autocomplete but nothing else */

;(function($){
    var debug = true;
    
    var methods = {
        /* INITIAL SETTINGS / HTML INJECTION */
        init : function( options ) {
            var settings = $.extend(
                                {},
                                $.tokenize.defaults,
                                options
                            );
            
            return this.each(function () {
                var tokenized = new $.tokenize(this, settings);
            });
        }
    };
    
    /* METHOD CALLS */
    $.fn.tokenizer = function(method) {
        if ( methods[method] ) {
          return methods[ method ].apply( this, Array.prototype.slice.call( arguments, 1 ));
        } else if ( typeof method === 'object' || ! method ) {
          return methods.init.apply( this, arguments );
        } else {
          $.error( 'Method ' +  method + ' does not exist on jQuery.tokenizer' );
        }
    };
    
    /* TOKENIZE - Internal core logic */
    $.tokenize = function(input,settings) {
        /*log(input);
        log(settings);*/
        var KEY = {
            BACKSPACE: 8,
            TAB: 9,
            RETURN: 13,
            ESC: 27,
            LEFT: 37,
            UP: 38,
            RIGHT: 39,
            DOWN: 40,
            COMMA: 188,
            ENTER: 13,
			DELETE: 46
        };
        // storage variables
        var $tokens = null;
        var token_items = [];
        
        $.template("token_template",settings.tokenTmpl);
        
        // ORIGINAL INPUT - hidden
        var $hiddenInput = $(input)
								.hide()
								.focus(function () { })
								.blur(function () { 
										$input.blur(); 
									})
								.attr({
									  name:$(input).attr('name') + '_loaded'
									  });
        
        // NEW INPUT ELEMENT
        var $input = $("<input type=\"text\">")
                        .addClass('uiTokenField')
                        .focus(function () {
                           
                        })
                        .blur(function () {
                            //hide_dropdown();
                        })
                        .keydown(function (event) {
                            var previous_token;
                            var next_token;
                
                            switch(event.keyCode) {
                                case KEY.LEFT:
                                case KEY.RIGHT:
                                case KEY.UP:
                                case KEY.DOWN:
                                    
                                    break;
            
                                case KEY.BACKSPACE:
                                    
                                    break;
                                case KEY.TAB:
                                case KEY.RETURN:
                                case KEY.COMMA:
                                  
                                  break;
                
                                case KEY.ESC:
                                
                                  return true;
                            }
                        });
        
        // TOKENIZER WRAPPER - contains all elements for this instance of the tokenizer
        var $wrapper = $('<div/>').addClass('uiTokenizer mrl');
        
        switch(settings.type) {
            case 'token':
                settings.typeOpts = {
                    imgSize:0,
                    dragOffset:{
                        top:-10,
                        left:-30
                    }
                }
            break;
            case 'tokenImage':
                settings.typeOpts = {
                    imgSize:62,
                    dragOffset:{
                        top:23,
                        left:30
                    }
                }
                
                $wrapper.addClass('uiImageTokenizer');
                break;
            case 'list':
                settings.typeOpts = {
                    imgSize:0,
                    dragOffset:{
                        top:-10,
                        left:40
                    }
                }
                $wrapper.addClass('uiListTokenizer');
                break;
            case 'listImage':
                settings.typeOpts = {
                    imgSize:20,
                    dragOffset:{
                        top:-10,
                        left:40
                    }
                }
                $wrapper.addClass('uiListImageTokenizer');
                break;
        }
        
        // TOKEN AREA - contains all of your tokens
        var $tokenarea = $('<div/>')
                .addClass('uiTokenarea hide clearfix')
                .appendTo($wrapper)
                ;
        
        // AUTOCOMPLETE container element
        var $typeahead = $('<div/>').addClass('uiTypeahead').prependTo($wrapper);
        $input.appendTo($typeahead);
        
        // AUTOCOMPLETE (requires jQuery UI autocomplete widget
        if($.isFunction($.fn.autocomplete)) {
            $input.autocomplete({
                //define callback to format results
                selectFirst:true,
                source: function(req, add){
                    $.ajax({
                        url: settings.url,
                        type:settings.ajaxMethod,
                        dataType: "json",
                        data: $.extend({},
                                       settings.ajaxParams,
                                        {
                                        q:req.term
                                        }),
                        success: function( data ) {
                            //create array for response objects
                            var suggestions = [];
                            
                            //process response
                            $.each(data, function(i, val){    
                                var anItem = data[i];
                                anItem.label = data[i].TEXT;
                                anItem.value = data[i].OBJECT_ID;                            
                                suggestions.push(anItem);
                            });
                            
                            //pass array to callback
                            add(suggestions);
                        }
                    });
                },
                delay:50,
                //define select handler
                select: function(e, ui) {
                    typeahead_select(ui.item);
                    return false;
                },
                
                //define select handler
                change: function() {
                    
                    //prevent 'to' field being updated and correct position
                    $("#Degrees").val("").css("top", 2);
                }
            });
            
            //log("autocomplete plugin is installed.");
        }
        
        // INJECT ALL OF THE HTML INTO THE PAGE
        $wrapper.insertAfter($hiddenInput);
        
        // if you want to use watermarkText then JQUERY.WATERMARK PLUGIN NEEDED
        if(jQuery.watermark) {
            //log("watermark plugin is installed.");
            $input.watermark(settings.watermarkText);
        }
                
        var refreshTokens = function(clickOffset) {
            var counter = 0;
            
            tokens = $tokenarea.children('.uiToken').not('.droppable_placeholder');
            if(clickOffset){
                
            } else {
                clickOffset = { x:0,y:0 }    
            }
            if(settings.type == 'tokenImage') {
                var textAll = '';
                tokens.each(function() {
                    var token = $(this);
                    var index = token.index();
                    var text = token.find('.text').text();
                    
                    textAll = textAll + ', ' + text;
                    if(counter < 5) {
                        makeTokenShown(token);
                    } else {
                        makeTokenHidden(token);
                        //        marginOffset = parseInt($(token).height() * clickOffset.y);
                        /*if($(token).hasClass('drag')) {
                            $(token).css({
                                'margin-top':'auto'
                            });
                        } else {
                            $(token).css({
                                'margin-top':'auto'
                            });
                        }
                        console.log(marginOffset);*/
                    }
                    
                    counter++;
                });
            }
        }
        
        function makeDragShown(ui) {
            ui.item.addClass('shown').removeClass('hidden').find('.tokenImg').show();
            ui.placeholder.addClass('shown shownPlaceholder').css({ height:102,width:72 }).removeClass('hidden hiddenPlaceholder').find('.tokenImg').show();
            ui.helper.addClass('shown shownPlaceholder').css({ height:102,width:72 }).removeClass('hidden hiddenPlaceholder').find('.tokenImg').show();
        }
        
        function makeDragHidden(ui) {
            ui.item.removeClass('shown').addClass('hidden').find('.tokenImg').hide();
            ui.placeholder.removeClass('shown shownPlaceholder').css({ height:16,width:72 }).addClass('hidden hiddenPlaceholder').find('.tokenImg').hide();
            ui.helper.removeClass('shown shownPlaceholder').css({ height:16,width:72 }).addClass('hidden hiddenPlaceholder').find('.tokenImg').hide();
            
        }
        
        function makeTokenShown(token) {
            token.addClass('shown').removeClass('hidden').find('.tokenImg').show();
            
            if(token.hasClass('drag')) {
                //console.log('drag');
            }
        }
        
        function makeTokenHidden(token) {
            token.removeClass('shown').addClass('hidden').find('.tokenImg').hide();
            
        }
        
        load_default();
        
        
        function is_printable_character(keycode) {
            if((keycode >= 48 && keycode <= 90) ||      // 0-1a-z
               (keycode >= 96 && keycode <= 111) ||     // numpad 0-9 + - / * .
               (keycode >= 186 && keycode <= 192) ||    // ; = , - . / ^
               (keycode >= 219 && keycode <= 222)       // ( \ ) '
              ) {
                  return true;
              } else {
                  return false;
              }
        }
        
        function load_default() {
            var list_opts = $hiddenInput.find('option:selected');
            
            var token = {};
            list_opts.each(function() {
                token.label = $(this).text();
                token.value = $(this).val();
                
                token_add(token);
            });
            
            refresh_binding();
        }
        
        function typeahead_select(token) {
            token_add(token);
            $input.val('');
            $input.blur();
        }
        
        function refresh_binding() {
            tokens = $tokenarea.children('.uiToken').not('.droppable_placeholder');
            tokens.drag("start",function(ev,dd) {
                            var placeholder = $("<span/>").addClass('uiToken shown shownPlaceholder droppable_placeholder');
                            var startIndex = $(this).index();
                            var startHeight = $(this).height();
                            var startWidth = $(this).width();
                            $(this).data("startIndex",startIndex);
                            $(this).data("startHeight",startHeight);
                            $(this).data("startWidth",startWidth);
                            
                            $(this).data("placeholder",placeholder);
                            var clickOffset = {
                                x:parseInt(ev.pageX-dd.originalX)/100,
                                y:parseInt(ev.pageY-dd.originalY)/100
                            };
                            $(this).data("clickOffset",clickOffset);
                            
                            var startOffset = $(this).height() * clickOffset.y;
                            $(this).data("startOffset",startOffset);
                            //console.log(startOffset);
                            var container = $tokenarea.offset();
                            $(this).addClass('drag');
                            $(this).css({
                                position:'absolute',
                                'z-index':'1000'
                            });
                        })
                        .drag(function(ev,dd){
                            var placeholder = $(this).data("placeholder");
                            var clickOffset = $(this).data("clickOffset");
                            var startOffset = $(this).data("startOffset");
                            var startHeight = $(this).data("startHeight");
                            var startWidth = $(this).data("startWidth");
                            var startIndex = $(this).data("startIndex");
                            var container = $tokenarea.offset();
							
                            var drop = dd.drop[0], method = $.data( drop || {}, "drop+reorder" );
                            var rel = {
                                y:parseInt(ev.pageY-container.top),
                                x:parseInt(ev.pageX-container.left)
                            };
                            
                            var top = rel.y+parseInt(dd.offsetY-ev.pageY)+19;
                            var left = rel.x+parseInt(dd.offsetX-ev.pageX);
                            
							if($(drop).parents().filter($tokenarea).length>0) {
								if ( drop && $(drop).is('.uiToken') && ( drop != dd.current || method != dd.method ) ){    
									$( this )[ method ]( drop );
									dd.current = drop;
									dd.method = method;
									dd.update();
									refreshTokens(clickOffset);
									placeholder.insertAfter($(this));
								}
							}
                            
                            
							if(settings.type == 'tokenImage') {
								if($(this).index() > 4) {
									placeholder.addClass('hidden hiddenPlaceholder').removeClass('shown shownPlaceholder')
										.css({
											 height:$(this).height(),
											 width:$(this).width()
											 });
									
								} else {
									placeholder
										.addClass('shown shownPlaceholder')
										.removeClass('hidden hiddenPlaceholder')
										.css({
											 height:$(this).height()
											 });
								}
							} else {
								placeholder
									.removeClass('shown shownPlaceholder')
									.removeClass('hidden hiddenPlaceholder')
									/*.css({
										 height:$(this).height(),
										 width:$(this).width()
										 })*/;
							}
                            
                            var currHeight = $(this).height();
                            var currWidth = $(this).width();
                            var currHeightOffset = (currHeight*clickOffset.y);
                            var testY = parseFloat(ev.pageY-dd.offsetY) - parseFloat(currHeightOffset);
                            var currWidthOffset = (currWidth*clickOffset.x);
                            var testX = parseFloat(ev.pageX-dd.offsetX) - parseFloat(currWidthOffset);
                            
                            if(currWidth < startWidth) {
                                left = parseFloat(left) + parseFloat(testX)*clickOffset.x;
                                //console.log(testX);
                            }
                            
                            if(currHeight < startHeight) {
                                top = parseFloat(top) + parseFloat(testY);
                                //console.log(top);
                            }
                            
                            $(this).css({
                                position:'absolute',
                                'z-index':'1000',
                                'top':top,
                                'left':left
                            });
                        })
                        .drag("end",function(ev,dd) {
                            var placeholder = $(this).data("placeholder");
                            var container = $tokenarea.offset();
                            placeholder.remove();
                            
                            $(this).css({
                                position:'relative',
                                'z-index':'0',
                                top: 0,
                                left: 0,
                                'margin-top':'auto'
                            });
                            
                            $(this).removeClass('drag');
                        })
                        .drop("init",function( ev, dd ){
                            return !( this == dd.drag );
                        });
                    
                        $.drop({
                            mode:'mouse',
                            tolerance: function( event, proxy, target ){
								var placeholder = $(this).data("placeholder");
								var testV = event.pageY > ( target.top + target.height / 2 );
								var testH = event.pageX > ( target.left + target.width / 2 );
								var container = $tokenarea.offset();
								
								//$('.debugger').text(parseFloat(event.pageY-container.top) + ' ' + parseFloat(event.pageX-container.left));
								$.data(target.elem, "drop+reorder", testV ? "insertAfter" : "insertBefore" );  
								
                                return this.contains( target, [ event.pageX, event.pageY ] );
                            }
                });
        }
        
		function token_delete($token) {
			$token.remove();	
			
			return false;
		}
		
		function token_deselect($token) {
            $token.removeClass('uiTokenSelected').removeClass('uiTokenShownSelected');
			
			return false;
		}
		
        function token_select($token) {
			var $nextToken = $token.next();
			var $prevToken = $token.prev();
			
			$token.addClass('uiTokenSelected');
			
			if($token.hasClass('shown')) {
				$token.addClass('uiTokenShownSelected');
			}
			
			$(document).keydown(function(e) {
				if($token.hasClass('uiTokenSelected')) {
					switch(e.keyCode) {
						case KEY.LEFT:
							if($prevToken.is('.uiToken')) {
								token_deselect($token);
								$(document).unbind("keydown");
								token_select($prevToken);
							}
							break;
						case KEY.RIGHT:
							if($nextToken.is('.uiToken')) {
								token_deselect($token);
								$(document).unbind("keydown");
								token_select($nextToken);
							}
							break;
						case KEY.TAB:
							if(e.shiftKey) {
								if($prevToken.is('.uiToken')) {
								token_deselect($token);
								$(document).unbind("keydown");
								token_select($prevToken);
							}
							} else {
								if($nextToken.is('.uiToken')) {
									token_deselect($token);
									$(document).unbind("keydown");
									token_select($nextToken);
								}
							}
							break;
						case KEY.BACKSPACE:
							token_delete($token);
							$(document).unbind("keydown");
							
							refreshTokens();
							token_select($nextToken);
							break;
						case KEY.DELETE:
							token_delete($token);
							$(document).unbind("keydown");
							
							refreshTokens();
							token_select($nextToken);
							break;
						
		
						case KEY.ESC:
							token_deselect($token);
							$(document).unbind("keydown");
						break;
					}
				}
				return false;
			});
			
			$("body").click();
			$("html").one("click",function() {
				token_deselect($token);
			
				
				 return false;
			 });
			
			return false;
        }
		
		function refreshHiddenInput() {
			var $tokens = $tokenarea.children('.uiToken');
			
			$hiddenInput.val('').html("");
		}
        
        function token_add(token) {
            var shownTokens = [];
            var hiddenTokens = [];
            
            var $token = $("<span/>")
                              .addClass('uiToken');
            
            if(settings.type == 'tokenImage' || settings.type == 'listImage') {
                var $tokenImg = $("<span/>").addClass('tokenImg').appendTo($token);
                var $hubPhoto = $("<div/>").css({
                                                height:settings.typeOpts.imgSize + 'px',
                                                width:settings.typeOpts.imgSize + 'px'
                                                }).addClass('hubPhoto').appendTo($tokenImg);
                $("<img/>")
                    .attr({
                        width:settings.typeOpts.imgSize,
                        height:settings.typeOpts.imgSize,
                        src:'/static/images/no-photo/none_i.png'
                     }).appendTo($hubPhoto);
            }
            
			$("<input/>").attr({
							   	type:'hidden',
								value:token.value,
								name:settings.fieldName,
								autocomplete:'off'
							   }).appendTo($token);
			$("<input/>").attr({
							   	type:'hidden',
								value:token.label,
								name:'text_' + settings.fieldName,
								autocomplete:'off'
							   }).appendTo($token);
			
            /* BINDS */
			$token.click(function() {
			 	token_select($token);
				
				return false;
			 });
            var $tokenText = $("<span/>")
                                .addClass('text')
                                .text(token.label).appendTo($token);

            $tokenarea.addClass('expanded').removeClass('hide');
            
            token_items.push(token);
            $token.prependTo($tokenarea);
            
            /* keeps $tokens list selector up to date */
            refreshTokens();
            
            return false;
        }
    }
    
     $.tokenize.defaults = {
         ajaxParams:null,
         shownImages: true,
         shownCount: 5,
        watermarkText: "Type in a search term",
        searchDelay: 300,
        minChars: 1,
         ajaxMethod:'get',
        type:'token',
        tokenLimit: null,
        jsonContainer: null,
        method: "GET",
        tokenTmpl: '<span title="${label}" class="uiToken ${shown}">' +
                        '        <span class="tokenImg hide">' +
                        '            <div style="height: 62px; width: 62px;" class="hubPhoto">' +
                        '                <img height="62" src="/static/images/no-photo/none_i.png" class="img">' +
                        '            </div>' +
                        '        </span>' +
                        '        <span class="text">' +
                        '            ${label}' +
                        '        </span>' +
                        '        <input type="hidden" value="${value}" name="${fieldName}" autocomplete="off">' +
                        '        <input type="hidden" value="${label}" name="text_${fieldName}" autocomplete="off">' +
                        '    </span>',
        contentType: "json",
        autocomplete:null,
        queryParam: "q",
        onResult: null,
        selectFirst: true,
        autoFill: false,
        defaultData:null
    };
    
    function log() {
        if(jQuery.log) {
            $.log(arguments);
        }
    };

})(jQuery);