/* 

												swipeThis v0.7.3 jQuery Plugin

	author: Fortes [at] noumeni.us

 	Released under the GNU licence

Dependencies
  jQuery 

Configuration Options:
	
	Multiple (default: false)
	fillContainer (default: true)
	fullScreen (default: false)
	itemWidth (default: 170)
	itemHeight (default: 140)
	indicator : Image url for the icon that tells users to swipe (default:'')
	marginRight: Margin applied to items in Multiple mode (default: 0)
	speed: Transition speed (default: 100)
	easein: jQuery easeIn function (default: '')
	tolerance: (default: 0.5)

*/

(function($){
	
	var debug = false;
	
	var supportTouch = 'ontouchstart' in document.documentElement,
			scrollEvent = "touchmove scroll",
			touchStartEvent = supportTouch ? "touchstart" : "mousedown",
			touchStopEvent = supportTouch ? "touchend" : "mouseup",
			touchMoveEvent = supportTouch ? "touchmove" : "mousemove";
			touchResizeEvent = supportTouch ? "orientationchange" : "resize";

	var methods = {
			init : function(options){
				return this.each(function(){
				  var $this = $(this);
		      data = $this.data('swipeThis');
		      if(data) return; //run init only once
		      
		      var settings = {
	      		'multiple'			: false,
						'fillContainer'	: true,
						'fullScreen'		: false,
						'indicator'			: '',
						'itemHeight'		: 140,
						'itemWidth'			: 170,
						'marginRight'		: 0,
						'speed'					: 100,
						'easein'				:	'',
						'tolerance'			: 0.5 
			    };
				  if (options) { $.extend( settings, options );}
				  
				  var items = {
			  		count		:	$this.children().length,
						visible	:	0,
						active	: 0,
						height	:	0,
						width		:	0
				  };
				  var touch = {
						touching 	: false,
						x					: 0,
						xOffset		:	0
					};
		
				  $this.wrap('<div class="swipeThis"/>');
		      var swipeThis = $this.parent();
				  swipeThis.prepend('<div class="swipeArea"/>');
				  var swipeArea = swipeThis.children('.swipeArea');
					 
		      position($this, items, settings);
		      
		      if(settings.indicator != '') {
          	swipeThis.children('.swipeIndicator').remove();
          	var indicatorLeft;
          	if(settings.multiple)
  	        	indicatorLeft = parseInt(swipeThis.parent().width()-48);
          	else
          		indicatorLeft = parseInt(items.width-48);
          	var indicatorTop = parseInt(items.height/2-24);
          	
          	swipeArea.after('<div class="swipeIndicator" '
          		+'style="z-index:100;pointer-events: none;position: absolute; margin-left: '
          				+indicatorLeft+'px;'
          		+'margin-top: '+indicatorTop+'px;">'
          			+'<img src="'+settings.indicator+'" border="0" alt=""/>'
          		+'</div>');
          }
		     
		      
		      $(window).bind(touchResizeEvent,function(event){
		      	if($this.has(':visible').length != 0) {
			      	/*if(debug)
			      		console.log('touchResizeEvent:'
			      				+$this.parent().parent().attr('id'));*/
			      	var data = $this.data('swipeThis');
			      	if(data) {
				      	position($this,data.items, data.settings);
				      	
				        $this.data('swipeThis', {
									items			: data.items,
									settings	:  data.settings
								});
			      	}
		      	}
		      });
		      
		      swipeArea.bind(touchStartEvent,function(event){
		      	if(debug)
		      		console.log('touchStart');
		        if(!touch.touching){
              console.log('not touching?');
		        	var eventData = event.originalEvent.touches 
		        			? event.originalEvent.touches[0] : event;
		    			touch.touching = true;
		          touch.x = eventData.pageX;  
		        }
		        return false;
		      });
		      
		      swipeArea.on(touchMoveEvent,function(event){
            if(debug)
              console.log('touchMove');
		      	if(touch.touching){
		      		var eventData = event.originalEvent.touches 
		        			? event.originalEvent.touches[0] : event;
		        	touch.xOffset = eventData.pageX - touch.x;
		        	$this.css('left', -items.active 
		        			* (items.width + settings.marginRight) + touch.xOffset);
		        }
		        return false; 
		      }); 
		       
		      swipeArea.bind(touchStopEvent,function(event){
		      	if(debug)
			      	console.log('touchEnd - xOffset:'+touch.xOffset);
		      	touch.touching = false; 
		      	//pass Tap-Click event through if the item contains a link
		      	if(!touch.xOffset) { 
		      		if(debug)
				      	console.log('Tap/Click Event');
		      		var eventData = event.originalEvent.changedTouches 
    	    		? event.originalEvent.changedTouches[0] : event;	
		      		$this.children('li').each(function() {
		      			var li = $(this);
		      			var a = li.find('a');
		      			if(a.attr('href') != undefined) {
		      				var mouseX = eventData.pageX;
		      				var mouseY = eventData.pageY;
		      				var offset = li.offset();
		      				var width = li.width();
		      				var height = li.height();
		      				if (mouseX > offset.left && mouseX < offset.left+width
		      						&& mouseY > offset.top && mouseY < offset.top+height) {
		      					a.click(); 
		      				}
		      			}
		      		});
		          return false;
		        }
		      	
		      	var w = parseInt(items.width);
						var scrolledImages = 1;
						if(settings.multiple) {
							scrolledImages = Math.abs(parseInt(touch.xOffset / w)) + 1; 
						}
						
						var limit = (w/2) - (w * settings.tolerance);
						if(-touch.xOffset > limit){
							items.active+=scrolledImages;
							items.active = items.active+items.visible >= items.count 
									? items.count-items.visible : items.active;
						} 
						else if(touch.xOffset > limit){
							items.active-=scrolledImages;
							items.active = items.active < 0 ? 0 : items.active;
						} 
						$this.animate(
								{left: -items.active * (items.width + settings.marginRight)},
								settings.speed,
								settings.easein);
						
					 if(settings.indicator 
							 	&& $this.children('.swipeIndicator').css('display')!='none')
							$('.swipeIndicator').hide();//.fadeOut('slow');
						
						touch.xOffset = 0;
						return false; 
		      });
		      
					if(!supportTouch) {
						swipeArea.mouseleave(function(event){
							if(touch.xOffset) {
							  swipeArea.mouseup();
							}
						});
					}

					
					$this.data('swipeThis', {
						items			: items,
						settings	:  settings
					});
					
					
				});
			},
			reposition : function() {
				return this.each(function(){
					var $this = $(this);
					data = $this.data('swipeThis');

					if(data) {
						position($this,data.items, data.settings);
						$this.data('swipeThis', data);
					}
				});
			},
			destroy : function() {
				return this.each(function(){
					var $this = $(this),
					data = $this.data('swipeThis');
					// Namespacing FTW
          $this.prev('.swipeArea').remove();
          $this.unwrap();
          $this.css({
            height:"inherit",
            "min-height":"inherit",
            width:"inherit"
          })
          $this.children().css({
            height:"inherit",
            "min-height":"inherit",
            width:"inherit"
          });
					$(window).unbind('.swipeThis');
					//data.swipeThis.remove();
					$this.removeData('swipeThis');

				});
			}
	};
      
     
	$.fn.swipeThis = function( method ) {
		if ( methods[method] ) {
		 return methods[method].apply(this,Array.prototype.slice.call(arguments,1));
		} else if ( typeof method === 'object' || ! method ) {
			return methods.init.apply( this, arguments );
		} else {
			$.error( 'Method ' +  method + ' does not exist on jQuery.swipeThis' );
		}    
	};
	  
	  
	/*
	 *  Private functions
	 */ 
  function setItemSize(swipeThis,items,settings) {
    if(settings.fullScreen) {
      items.width  = screen.width;
      items.height = screen.height;
    }
  	else if(settings.fillContainer) {
      items.width = swipeThis.parent().width();
      items.height = swipeThis.parent().height();
    }
    else {
      items.width  = parseInt(settings.itemWidth);  
      items.height = parseInt(settings.itemHeight); 
    }
  }
  
  function resizeElements($this,items,settings) {
  	$this.find('li').each(function(){
  		var li = $(this);
  		li.css('height', items.height);
  		li.css('width', items.width);
  		
  		//hack to avoid problems in items.height when the image is slow to load
  		li.css('min-height', parseInt(settings.itemHeight) + 'px');
  		
  		li.css('marginRight', settings.marginRight + 'px');
  		
  		var img = li.find('img');
  		if(img) {
  			img.load(function() {
	  			var imgW, imgH, w, h,marginTop,marginLeft;
	  			imgW = img.width;
					imgH = img.height; 
	  			
	  			if(settings.fillContainer) {
	  				w = items.width;
	  				h = w/imgW*imgH;
	  			}
	  			else if(imgW/items.width < imgH/items.height) {
	  				w = items.width;
	  				h = w/imgW*imgH;
	  			}
	  			else {
	  				h = items.height;
	  				w = h/items.height*imgW;
	  			}
	  			marginTop = (items.height - h)/2;
	  			marginLeft = (items.width - w)/2;
	  			
	  			img.css({'margin-top' 	: marginTop + 'px',
	  							 'margin-left' 	: marginLeft + 'px',
	  							 'height'				: h + 'px',
	  							 'width'				: w + 'px'});
	  			if(debug)
	  				console.log('EndimgResize:'+img.attr('src')+'('+w+','+h+')');
	      });
  			
	      if(img.complete) img.trigger('load');

  		}
  	});
  }
  
  function position($this,items,settings){
  	var swipeThis = $this.parent();
  	var swipeArea = swipeThis.children('.swipeArea');
  	
  	setItemSize(swipeThis,items,settings);
    
  	resizeElements($this,items,settings);
        
  	if(settings.multiple) {
  		var containerWidth = swipeThis.parent().width();
  		var itemWidth = items.width + settings.marginRight;
  		swipeArea.width(containerWidth);
  		items.visible = parseInt(containerWidth / itemWidth);	
  	}
  	else {
  		swipeArea.width(items.width + settings.marginRight);
  		items.visible = 1;
  	}
  	
  	//hack to avoid problems in items.height when the image is slow to load
    swipeArea.css('min-height', parseInt(settings.itemHeight) + 'px');
  	swipeArea.height(items.height);
  	
  	//swipeArea.css('left', swipeThis.position().left);
  	//swipeArea.css('top', swipeThis.position().top);
  	if(debug)
  		swipeArea.css('border', '2px solid red');
  	
  	$this.width((items.count * (items.width + settings.marginRight)));
  	
  	items.active = items.active+items.visible >= items.count ?
    		items.count-items.visible : items.active;
    $this.animate(
    			{left: -items.active * (items.width + settings.marginRight)}, 
    			settings.speed,
    			settings.easein); 
    
    var swipeIndicator = swipeThis.children('.swipeIndicator');
    if(swipeIndicator.has(':visible').lenght != 0) {
	  	var indicatorLeft;
	  	if(settings.multiple)
	    	indicatorLeft = parseInt(swipeThis.parent().width()-48);
	  	else
	  		indicatorLeft = parseInt(items.width-48);
	  	var indicatorTop = parseInt(items.height/2-24);
	  	
	  	swipeIndicator.css({'margin-top' 	: indicatorTop + 'px',
				 'margin-left' 	: indicatorLeft + 'px'});
    }
  }
	
})( jQuery );