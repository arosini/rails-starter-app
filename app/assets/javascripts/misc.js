/* Misc app wide javascript goes here.*/

/* These functions are called on every page. */
$(document).ready(function() {
  setUpPageLoadSpinner();
  highlightNavbarLink();
});

// Highlights the navbar link with the current href. So if you are not viewing the exact link, it will not be highlighted.
function highlightNavbarLink() {
  $('.navbar a[href="' + this.location.pathname + '"]').parent().addClass('active');
}

// Sets up the loading spinner to show between pages
function setUpPageLoadSpinner() {
  createSpinner('page-load');
  var spinner = $("#page-load").hide();
  var content = $("#content-wrap").show(); 

  $(window).bind('beforeunload',function(){
    showHide(spinner, content);
  }).bind('load',function(){
    showHide(content,spinner);
  });
}

// Sets up a loading spinner to show on all ajax events for a page.
function setUpLoadingSpinner(id, resultID) {
  createSpinner(id);
  var $loading = $("#" + id).hide();
  var $result = $("#" + resultID);
  
  $(document)
    .ajaxStart(function () {
      showHide($loading, $result);
    })
    .ajaxStop(function () {
      showHide($result, $loading);
    });
}

// Visual options for loading spinner
function createSpinner(id) {
  var opts = {
    lines: 13, // The number of lines to draw
    length: 15, // The length of each line
    width: 7, // The line thickness
    radius: 20, // The radius of the inner circle
    corners: 1, // Corner roundness (0..1)
    rotate: 0, // The rotation offset
    direction: 1, // 1: clockwise, -1: counterclockwise
    color: '#000', // #rgb or #rrggbb or array of colors
    speed: 1, // Rounds per second
    trail: 60, // Afterglow percentage
    shadow: false, // Whether to render a shadow
    hwaccel: false, // Whether to use hardware acceleration
    className: 'spinner', // The CSS class to assign to the spinner
    zIndex: 2e9, // The z-index (defaults to 2000000000)
    top: '50%', // Top position relative to parent
    left: '50%' // Left position relative to parent
  };
  
  var target = document.getElementById(id);
  var spinner = new Spinner(opts).spin(target);
}

// Calls 'doneTyping', 'doneTypingInterval' milliseconds after the user stops typing on 'selector'. Accepts optional arg for startTyping method.
function setUpTypingTimer(selector, doneTyping, doneTypingInterval, startTyping) {
  var typingTimer;

  $(selector).each(function() {
    // Save last value to see if value changed
    var lastVal = $(this).val(); 
      // on input, start the countdown
    $(this).on('input', function(e) {
      // If value didn't change, ignore keypress (didn't type due to some restriction on field like numbers only).
      if($(this).val() == lastVal) { return; }
      lastVal = $(this).val();
      clearTimeout(typingTimer);
      typingTimer = setTimeout(doneTyping, doneTypingInterval);
      if(startTyping) { startTyping(); }
    });
    //on keydown, clear the countdown 
    $(this).keydown(function(){
      clearTimeout(typingTimer);
    });
  });
}

// Accepts two jQuery objects (one to show, one to hide believe it or not).
function showHide(show, hide) {
  show.show();
  hide.hide();
}

/* Cookies!! */
function createCookie(name,value,days) {
	if (days) {
		var date = new Date();
		date.setTime(date.getTime()+(days*24*60*60*1000));
		var expires = "; expires="+date.toGMTString();
	}
	else var expires = "";
	document.cookie = name+"="+value+expires+"; path=/";
}

function readCookie(name) {
	var nameEQ = name + "=";
	var ca = document.cookie.split(';');
	for(var i=0;i < ca.length;i++) {
		var c = ca[i];
		while (c.charAt(0)==' ') c = c.substring(1,c.length);
		if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
	}
	return null;
}

function eraseCookie(name) {
	createCookie(name,"",-1);
}