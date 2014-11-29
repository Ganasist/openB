$ ->
	warning_check = ->
		# console.log $("input[name='job[categories]']:radio:checked").val()
		if $("select#category_select option:selected").length in [1..4] or 
			$("input.check_boxes:checked").length in [1..4] or 
			$("input:radio:checked").val()?

 			$('input.user_submit').attr('disabled', false) and $('#category_warning').addClass('hidden')
		else
			$('input.user_submit').attr('disabled', true) and $('#category_warning').removeClass('hidden')
	
	# For non-mobile devices which will use a checkbox list
	checkbox_check = ->
		console.log ('running checkbox_check')
		if $("input.check_boxes:checked").length in [0..3]
			$("input.check_boxes:not(:checked)").attr('disabled', false).parent().fadeTo(100, 1)
		else
			$("input.check_boxes:not(:checked)").attr('disabled', true).parent().fadeTo(100, .3)
		warning_check()

	# For non-mobile devices which will use a checkbox list
	checkbox_check = ->
		console.log ('running checkbox_check')
		if $("input.check_boxes:checked").length in [0..3]
			$("input.check_boxes:not(:checked)").attr('disabled', false).parent().fadeTo(100, 1)
		else
			$("input.check_boxes:not(:checked)").attr('disabled', true).parent().fadeTo(100, .3)
		warning_check()

	# For job posts which will use a radio button list
	radio_check = ->
		console.log ('running radio_check')
		warning_check()

	# For mobile devices which will use a multi-select dropdown menu
	# dropdown_check = ->
	# 	if $("select#category_select option:selected").length in [0..3]
	# 		$('select#category_select option:not(:selected)').attr('disabled', false).fadeTo(100, 1)
	# 	else
	# 		$('select#category_select option:not(:selected)').attr('disabled', true).fadeTo(100, .3)
	# 	warning_check()
	
	warning_check()
	checkbox_check()
	radio_check()

	$("input.check_boxes").on "change", (evt) ->
		checkbox_check()

	$("select#category_select").on "change", (evt) ->
		warning_check()

	$("input:radio").on "click", (evt) ->
		warning_check()