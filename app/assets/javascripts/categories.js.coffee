jQuery ->
	$("input.check_boxes").on "change", (evt) ->
		if $("input.check_boxes:checked").length == 4
			$("input.check_boxes:not(:checked)").attr('disabled', true).parent().fadeTo(100, .3)
		else if $("input.check_boxes:checked").length < 4
			$("input.check_boxes:not(:checked)").attr('disabled', false).parent().fadeTo(100, 1)
		
		if $("input.check_boxes:checked").length == 0
			$('input.user_submit').attr('disabled', true)
			$('#category_warning').removeClass('hidden')
		else if $("input.check_boxes:checked").length > 0
			$('input.user_submit').attr('disabled', false)
			$('#category_warning').addClass('hidden')