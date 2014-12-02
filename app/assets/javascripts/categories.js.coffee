$ ->
	warning_check = ->
		if $("select#category_select option:selected").length in [1..4] or 
			$("input.check_boxes:checked").length in [1..4] or 
			$("input:radio:checked").val()?

 			$('input.user_submit').attr('disabled', false) and $('#category_warning').addClass('hidden')
		else
			$('input.user_submit').attr('disabled', true) and $('#category_warning').removeClass('hidden')
	
	checkbox_check = ->
		console.log ('running checkbox_check')
		if $("input.check_boxes:checked").length in [0..3]
			$("input.check_boxes:not(:checked)").attr('disabled', false).parent().fadeTo(100, 1)
		else
			$("input.check_boxes:not(:checked)").attr('disabled', true).parent().fadeTo(100, .3)
		warning_check()

	warning_check()
	checkbox_check()

	$("input.check_boxes").on "change", (evt) ->
		checkbox_check()