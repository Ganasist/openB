jQuery ->
	# For mobile devices which will use a multi-select dropdown menu
	$("select#category_select").on "change", (evt) ->
		if $("select#category_select option:selected").length >= 4
			$('select#category_select option:not(:selected)').attr('disabled', true).fadeTo(100, .3)
		else if $("select#category_select option:selected").length < 4
			$('select#category_select option:not(:selected)').attr('disabled', false).fadeTo(100, 1)
		
		if $("select#category_select option:selected").length > 0 and
			 $("select#category_select option:selected").length >= 5
			$('input.user_submit').attr('disabled', true)
			$('#category_warning').removeClass('hidden')
		else if $("select#category_select option:selected").length >= 1 or
						$("select#category_select option:selected").length >= 4
			$('input.user_submit').attr('disabled', false)
			$('#category_warning').addClass('hidden')

	# For non-mobile devices which will use a checkbox list
	$("input.check_boxes").on "change", (evt) ->
		if $("input.check_boxes:checked").length == 4
			$("input.check_boxes:not(:checked)").attr('disabled', true).parent().fadeTo(100, .3)
		else if $("input.check_boxes:checked").length < 4
			$("input.check_boxes:not(:checked)").attr('disabled', false).parent().fadeTo(100, 1)

		if $("input.check_boxes:checked").length == 0
			$('input.user_submit').attr('disabled', true)
			$('#category_warning').removeClass('hidden')
		else if 0 < $("input.check_boxes:checked").length < 5
 			$('input.user_submit').attr('disabled', false)
 			$('#category_warning').addClass('hidden')