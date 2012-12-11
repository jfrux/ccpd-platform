/*!
 * Karmic Flow 0.1
 * http://www.karmagination.com
 * Released under the MIT, BSD, and GPL Licenses - Choose one that fit your needs
 * Copyright (c) 2009 Kean L. Tan 
 * Start date: 2009-07-20
 * Build date: 2009-09-02
*/
 
(function karmicFlow($){$.fn.karmicFlow = function(opts){
	// default options
	opts = $.extend({
		container: 'karmic_flow_container',
		slider: 'karmic_flow_slider',
		slides: 'karmic_flow_slides',
		sliding: 'karmic_flow_sliding',
		slide_selected: 'karmic_flow_slide_selected',
		slide_overflow: 'karmic_flow_slide_overflow',
		controller: 'karmic_flow_controller',
		controller_selected: 'karmic_flow_controller_selected',
		next: 'karmic_flow_next_controller',
		prev: 'karmic_flow_prev_controller',
		play: 'karmic_flow_play_controller',
		pause: 'karmic_flow_pause_controller',
		duration: 300,
		timer: 2500,
		auto: false
	}, opts || {});
	
	this.data('opts', opts);
	this.data('cur_index', this.data('cur_index') || 0);

	var playSlide = function(el, auto){
		
		var $el = $(el),
			target_container = $el.attr('target'),
			$container = $('#'+target_container),
			$slider = $container.children(),
			$current_selected = $container.find('.'+opts.slide_selected),
			$allSlides = $current_selected.parent().children(),
			index = $allSlides.index($current_selected),
			total = $allSlides.length,
			old_idx = $container.data('cur_index'),
			duration = $container.data('opts').duration,
			multiplier = 1;

		
		// -1 means not found.. just quit
		if (index == -1) return false;
		
		if (auto || $el.hasClass(opts.next))
			index = (index + 1 == total) ? 0 : index + 1;
		else if ($el.hasClass(opts.prev))
			index = (index == 0) ? total - 1 : index - 1;
			
		$container.data('cur_index', index);
		
		$allSlides.removeClass(opts.slide_selected);
		$allSlides.eq(index).addClass(opts.slide_selected);
		
		var $controller_target = $('[href=#'+ $allSlides.eq(index)[0].id + ']'),
			$controller_siblings = $('[target=' + $controller_target.attr('target') + ']');
		
		$controller_siblings.removeClass(opts.controller_selected);
		$controller_target.addClass(opts.controller_selected);
		
		$slider.addClass(opts.sliding);
		
		if((index == 0 && old_idx == total-1) || (index == total-1 && old_idx == 0)) {
			multiplier = total;
		}
		
		$slider.stop().animate({
			marginLeft: -1 * $current_selected.width() * index
		}, duration * multiplier, function(){
			$slider.removeClass(opts.sliding);	
		});
		
		return $controller_target[0];
	}

	for(var i=0; i < this.length; i++) {
		$(this[i]).find('.'+ opts.slides).each(function(){
			var $div = $('<div></div>');
			$div
			 .append(this.childNodes)
			 .appendTo(this)
			 .addClass(opts.slide_overflow)
			 .css('height', $(this).parent().parent().height());
		});
	}
	
	var isChildOf = function(el, className) {
		var cache = [];
		while(el) {
			cache.push(el);
			el = el.parentNode;
		}
		
		for (var i = 0; i < cache.length; i++)
			if ($(cache[i]).hasClass(className))
				return cache[i];
	
		return false;
	}
	
	// first time init, we want delegate all those controllers with different class name so they know their purpose
	// we do not want to delegate twice
	// 3rd, this is faster than live since we know what we are doing here
	var $doc = $();
	if (!$doc.data('karmic_flow_init')) {
		$doc.data('karmic_flow_init', 1);

		$doc.bind('click', function(e){
			var el = e.target,
				generic_controller = isChildOf(el, opts.controller),
				next_controller = isChildOf(el, opts.next),
				prev_controller = isChildOf(el, opts.prev),
				play_controller = isChildOf(el, opts.play);

			// slide controller
			if (generic_controller) {
				(function generic_controller_function(generic_controller, e) {
					var target_container = $(generic_controller).attr('target'),
						$container = $('#' + target_container), 
						$el = $(generic_controller);
						$found_slide = $container.find('#' + generic_controller.hash.substring(1, generic_controller.hash.length)),
						index = $found_slide.parent().children().index($found_slide[0]),
						$slider = $found_slide.parent(),
						old_index = $container.data('cur_index'),
						duration = $container.data('opts').duration,
						timer = $container.data('opts').timer;
	
					$('[target=' + target_container + ']').removeClass(opts.controller_selected);
					$el.addClass(opts.controller_selected);
					$slider.children().removeClass(opts.slide_selected);
					$found_slide.addClass(opts.slide_selected);
					$slider.addClass(opts.sliding);
					$container.data('cur_index', index);
					
					var marginLeft = -1 * $found_slide.width() * index;
					$slider.stop().animate({ marginLeft: -1 * $found_slide.width() * index }, duration * Math.abs(index-old_index), function(){
						$slider.removeClass(opts.sliding);
						
						if($container.data('interval') !== null) {
							$container.data('player', $('.'+opts.play).filter('[target=' + target_container + ']'));
							$container.data('interval', setInterval(function(){
								$container.data('player', playSlide($container.data('player'), true));
							}, $container.data('opts').timer));
						}
					});
					
					if($container.data('interval') !== null) {
						clearInterval($container.data('interval'));
					}
					
					// prevent default and stop propagation
					e.preventDefault();
					e.stopPropagation();
				})(generic_controller, e);
			}
			
			// next button, flawed, should use current selected or will be off
			else if (next_controller || prev_controller) {
				playSlide(next_controller || prev_controller);
				// prevent default and stop propagation
				e.preventDefault();
				e.stopPropagation();
			}
			
			// play button
			else if (play_controller) {
				(function play_controller_function(play_controller, e) {
					var curEl = play_controller,
						$el = $(play_controller),
						target_container = $(play_controller).attr('target');
						$container = $('#' + target_container),
						timer = $container.data('opts').timer;
					
					if($container.data('interval') !== null) {
						clearInterval($container.data('interval'));
						$container.data('interval', null);
						$el.removeClass(opts.pause);
					}
					else {
						$el.addClass(opts.pause);
						$container.data('player', curEl);
						$container.data('interval', setInterval(function(){
							$container.data('player', playSlide($container.data('player'), true));
						}, timer));
					}
					// prevent default and stop propagation
					e.preventDefault();
					e.stopPropagation();
				})(play_controller, e);
			}

			// other normal anchors should not be affected and behave normally so no return false, prevent default or stop propagation here
		});

	}
	
	for (var i=0; i < this.length; i++) {
		var $container = $(this[i]),
			$slider = $container.children(),
			$slides = $slider.height($container.height()).children(),
			timer = $container.data('opts').timer,
			$selected_slide = $slider.find('.' + opts.slide_selected),
			$player = $('.'+opts.controller).filter('[href=#'+ $selected_slide[0].id +']');
			$selected_slide_controller = $('.'+opts.controller).filter('[href=#'+ $selected_slide[0].id +']'),
			selected_index = $slides.index($selected_slide);
		
		$selected_slide_controller.addClass(opts.controller_selected);
		$slider.css({ marginLeft: -1 * $slides.eq(0).innerWidth() * selected_index });
		$slider.width($slides.length * $container.width());
		$slides.width($container.width());
		
		if (opts.auto) {
			// find the play button for current container
			var $play_button = $('.'+opts.play).filter('[target=' + this[i].id + ']');
			
			$play_button.addClass(opts.pause);
			// if not found, create one and hide it, we use fake play button to simulate a true button action
			if(!$play_button.length)
				$play_button = $('<a href="#" target="' + this[i].id + '" class="' + opts.next + '">&nbsp;</a>');
			
			$container.data('player', $play_button[0]);
			
			// loop the slides
			$container.data('interval', setInterval(function(){
				$container.data('player', playSlide($container.data('player'), true));
			}, timer));
		}
	}
	
	// make this plugin chainable
	return this; 

}})(this.jQuery||this.Karma);