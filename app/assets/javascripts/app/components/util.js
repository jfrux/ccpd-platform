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
function querystring(key) {
   var re=new RegExp('(?:\\?|&)'+key+'=(.*?)(?=&|$)','gi');
   var r=[], m;
   while ((m=re.exec(document.location.search)) != null) r.push(m[1]);
   return r;
}