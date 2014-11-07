jQuery ->
	fadeTime = 250
	current_email = $('#current_email').val()

	$('#current_email').focus ->
  		$('#new_password_confirmation, #current_password').fadeIn(fadeTime)

  $('#current_email').blur ->
  	if $('#current_email').val() == current_email
  		$('#new_password_confirmation, #current_password').fadeOut(fadeTime)

  $('#new_password').focus ->
  		$('#new_password_confirmation, #current_password').fadeIn(fadeTime)

  $('#new_password').blur ->
  	if $('#new_password').val() == ''
  		$('#new_password_confirmation, #current_password').fadeOut(fadeTime)