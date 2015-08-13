/* Javascript related to forms goes here */

// Call the following on every page:
setUpParsleyConfig();
$(document).ready(function() {
  if( $("form").length > 0 ) {
    $("form").each(function() {
      makeSelectorSameWidth("#" + this.id + " .input-group-addon");
    });

    restrictNumbersToNumericInput('input[type="number"], input[type="tel"]');

    // Add custom parsley validators here
    setUpUserEmailUniqueValidator();
    setUpRoleNameUniqueValidator();
    setUpUserCurrentPasswordValidator();
    setUpUserEmailInUseValidator();
  }
});

// Add any global parsley configuartion options here
function setUpParsleyConfig() {
  // Set errors display markup/styles
  window.ParsleyConfig = {
    errorsWrapper: '<div></div>',
    errorTemplate: '<div class="alert alert-danger parsley-alert"></div>'
  };

  // Change default required message
  window.ParsleyValidator.addMessage('en', 'required', "Can't be blank.");
}

// Only allow digits (0-9) to be typed in selector.
function restrictNumbersToNumericInput(selector) {
  $(selector).on('input', function(e) {
    $(this).val($(this).val().replace(/\D/g,''));
  });
}

// Create a new typeahead!
function setUpTypeAhead(list, attr, selector, name) {
    var instances = new Bloodhound({
      datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
      queryTokenizer: Bloodhound.tokenizers.whitespace,
      local: $.map(list, function(obj) { return { value: obj[attr] }; })
    });

    instances.initialize();

    $(selector).typeahead({
      hint: true,
      highlight: true,
      minLength: 1
    },
    {
      name: name,
      displayKey: 'value',
      source: instances.ttAdapter()
    });
  }

// After autofill from a typeahead, doneTyping is called.
function setUpTypeaheadSelectCallback(typeahead, doneTyping) {
  $(typeahead).on('typeahead:selected', function (e, datum) {
    doneTyping();
  }).on('typeahead:autocompleted', function (e, datum) {
    doneTyping();
  });
}

// Runs parsley validations for the password confirmation field when password validates successfully and field isn't blank.
function validatePasswordConfirmationOnPasswordValidate(){
  $("#password-field").parsley().subscribe('parsley:field:success', function() {
    if($("#password-confirmation-field").val() != "") {
      $("#password-confirmation-field").parsley().validate();
    }
  });
}

// Make selectors the same width and min-width
function makeSelectorSameWidth(selector, scale){
  if(scale == undefined) { scale = 1; }
  var maxWidth = 0;

  var hiddenParent = $(selector).first().parents(".modal:hidden").first();
  if(hiddenParent) { hiddenParent.css('display', 'block'); }

  // Get max width
  $(selector).each(function(obj) {
    var thisWidth = $(this).outerWidth();
    if( thisWidth > maxWidth) { maxWidth = thisWidth * scale; }
  });

  console.log("Making all " + selector + " same length of " + maxWidth +" (scale is " + scale + ")");

  // Set max width
  $(selector).each(function() {
    console.log("Setting width for a " + this.id + " to " + maxWidth);

    $(this).css({"width"    : maxWidth + "px"});
    $(this).css({"min-width": maxWidth + "px"});
  });

  if(hiddenParent) { hiddenParent.css('display', 'none'); }
}

// Adds a success message (perhaps after some AJAX) with an optional callback.
function addSuccess(message, afterAddSuccess) {
  html = '<div id="alert"><p id="dynamic-alert" class="alert alert-dismissible alert-success" role="alert">'
         + message
         + '<button class="close" data-dismiss="alert" type="button"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button></p></div>';
  $("#alert").html(html);
  if(afterAddSuccess) { afterAddSuccess(); }
}

// Adds error messages (perhaps after some AJAX) with an optional callback.
function addErrors(errors, selector, afterAddErrors) {
  html = '<div id="alert"><p id="dynamic-alert" class="alert alert-dismissible alert-danger" role="alert"><button class="close" data-dismiss="alert" type="button"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>';

  for (var i = 0; i < errors.length; i++) {
    html = html + "- " + errors[i];
    if(i < errors.length - 1) {
      html = html + "<br />";
    }
  }

  html = html + '</p></div>';
  $(selector).html(html);
  if(afterAddErrors) { afterAddErrors(); }
}

/* PARSLEY VALIDATORS */
function setUpUserEmailUniqueValidator() {
  // If edit form, allow user to input their own email!
  var formID = $("form").length ? $("form").first().attr('id') : "";
  window.ParsleyValidator.addValidator('emailunique', function (value, requirement) {
    var unique = true;
    $.ajax({
      url: "/check_user_email_unique",
      async: false,
      dataType: "json",
      data: { email: value, form_id: formID },
      success:  function(result) { unique = result; }
    });
    return unique;
  }, 32).addMessage('en', 'emailunique', 'Email has already been taken.');
}

function setUpUserEmailInUseValidator() {
  // If edit form, allow user to input their own email!
  var formID = $("form").length ? $("form").first().attr('id') : '';
  window.ParsleyValidator.addValidator('emailinuse', function (value, requirement) {
    var unique = true;
    $.ajax({
      url: "/check_user_email_unique",
      async: false,
      dataType: "json",
      data: { email: value, form_id: formID },
      success:  function(result) { unique = result; }
    });
    return !unique;
  }, 32).addMessage('en', 'emailinuse', 'Could not find a user with that email address.');
}

function setUpRoleNameUniqueValidator() {
  window.ParsleyValidator.addValidator('rolenameunique', function (value, requirement) {
    var unique = true;
    $.ajax({
      url: "/check_role_name_unique",
      async: false,
      dataType: "json",
      data: { name: value },
      success:  function(result) { unique = result; }
    });
    return unique;
  }, 32).addMessage('en', 'rolenameunique', 'Role name is already in use.');
}

function setUpUserCurrentPasswordValidator() {
  window.ParsleyValidator.addValidator('checkuserpassword', function (value, requirement) {
    var match = false;
    $.ajax({
      url: "/check_user_password_match",
      async: false,
      dataType: "json",
      data: { password: value, id: $("form#change-password").data('user') },
      success:  function(result) { match = result; }
    });
    return match;
  }, 32).addMessage('en', 'checkuserpassword', 'Incorrect current password.');
}

function removeParsleyValidationClasses() {
  $('.parsley-success').each(function() {
    $(this).removeClass('parsley-success');
  });
}