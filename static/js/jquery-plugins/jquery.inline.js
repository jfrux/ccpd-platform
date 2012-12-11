/*!
 * jQuery Inline Form Plugin
 * version: 1.0 (02-FEB-2011)
 * @built using jQuery 1.4.4
 *
 * Dual licensed under the MIT and GPL licenses:
 *   http://www.opensource.org/licenses/mit-license.php
 *   http://www.gnu.org/licenses/gpl.html
 */

;(function( $ ){
/*
 * inlineForm() provides a toggling mechanism for creating inline editing
 * of list data.  It does not provide saving functionality.  
 */

/*
EXAMPLE CODE:

1) HOW TO INITIALIZE FUNCTIONALITY
	// HTML LIST EMENTS = the element DISPLAYING data
	A) If you plan to use ul,li elements
		- $(HTML LIST ELEMENT).inlineForm();
		  EX: $('ul.inline-elements li').inlineForm();
	B) if you are not using ul,li elements
		// HTML ELEMENT = <div/>, <td/>, <tr/>, <dl/>, etc...
		- $(HTML LIST ELEMENT).inlineForm('init','HTML ELEMENT');
		  EX: $('div.inline-elements div').inlineForm('init','<div/>');

2) HOW TO SHOW EDIT FORM
	- $(HTML ELEMENT).inlineForm('show', EDIT FORM DATA);
	  EX: $(".inline-edit").click(function() {
				var nId = this.id.split("-")[2];
				var data = $.ajax({
					url: SOME URL, 
					data: { dataPoint1: dtData1, dataPoint2: dtData2, display: 'plain' },
					async: false,
					dataType: 'html'
				}).responseText;
				
				$(this).inlineForm('show', $.trim(data));
				
				return false; 
			});
	
3) HOW TO HIDE EDIT FORM
	- $(HTML ELEMENT).inlineForm('hide');
	EX: $(".inline-edit-cancel").click(function() {
			$(this).inlineForm('hide');
			
			return false;
		});
	
	
*/
	var currentObj = 0;
	
	$.fn.inlineForm = function(method, data) {
		var output = '';
		var currCount = 0;
		var elementCount = 0;
		var deepestElement;
		var list_element = '<li/>';
		var methods = {
			init: function() {
				// CHECK IF HTML_ELEMENT WILL BE OVERWRITTEN
				if(typeof(arguments[1]) != 'undefined' && arguments[1] != '') {
					list_element = arguments[1];
				}
				
				elementCount = list_element.split('<').length-1;
				
				return this.each(function(i) {
					// ADD DISPLAY CLASS
					$(this).addClass('display-container display-' + i);
					
					// CREATE EDIT CONTAINERS
					output = $(list_element).addClass('curr-container');
					$($('.display-container')[i]).after(output);
					
					// CHECK IF THE ELEMENTS ARE NESTED (SUCH AS <TR/><TD/>
					if(elementCount > 1) {
						// LOOP THROUGH CHILD ELEMENTS
						$(".curr-container").find('*').each(function() {
							// SET CURRENT ELEMENT DEPTH FROM PARENT
							var elementDepth = $(this).parentsUntil('.curr-container').length;
							// SET deepestElement AT THIS POINT TO MAKE SURE IT HAS A VALUE IF elementDepth IS NOT GREATER THAN
							deepestElement = this;
							
							if(elementDepth > currCount) {
								currCount = elementDepth;
								deepestElement = this;
							}
						});
						
						$('.curr-container').addClass('dn');
						$(deepestElement).addClass('edit-container edit-' + i + ' dn');
					} else {
						// NOT A NESTED ELEMENT --> GO AHEAD AND DO THE OUTPUT
						$('.curr-container').removeClass('curr-container').addClass('edit-container edit-' + i + ' dn');
					}
					/* THIS IS THE ORIGINAL CODE IF NEEDING TO REVERT */
					//.addClass('edit-container edit-' + i + ' dn');
					/*output = $(list_element).addClass('edit-container edit-' + i + ' dn');
					$($('.display-container')[i]).after(output);
					output = '';*/
				});
			},
			hide: function() {
				// HIDE AND CLEAR HTML OF ALL EDIT CONTAINERS
				$('.curr-container').addClass('dn')
				$($('.edit-container')[currentObj]).addClass('dn').html('');
				
				// SHOW THE CORRESPONDING DISPLAY CONTAINER
				$($('.display-container')[currentObj]).removeClass('dn');
			},
			show: function() {
				// SET THE CURRENT OBJECT ID
				var regEx = /display-[\d]+/;
				var htmlElement = $(this).closest('.display-container').attr('class');
				currentObj = regEx.exec(htmlElement)[0].split('-')[1];
				
				// // HIDE AND CLEAR HTML OF ALL EDIT CONTAINERS
				$('.edit-container').addClass('dn').html('');
				
				// SHOW ALL DISPLAY CONTAINERS
				$('.display-container').removeClass('dn');
				
				// HIDE THE DISPLAY CONTAINER THAT INITIALIZED FUNCTION
				$($('.display-container')[currentObj]).addClass('dn');
				$('.curr-container').addClass('dn');	// HIDES PARENT ELEMENT IF USING NESTED ELEMENTS
				
				// SHOW THE CORRESPONDING EDIT CONTAINER
				$($('.edit-container')[currentObj]).html(data).removeClass('dn');
				$($('.edit-container')[currentObj]).closest('.curr-container').removeClass('dn');	// REVEALS PARENT ELEMENT IF USING NESTED ELEMENTS
			}
		};
		
		if (typeof(method) != 'undefined' && methods[method] ) {
			return methods[method].apply(this, Array.prototype.slice.call(arguments, arguments));
		} else if (typeof (method) === 'undefined' || ! method) {
			return methods.init.apply(this, arguments);
		} 
	};
})( jQuery );