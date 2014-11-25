jQuery ->
	$("select#category_select").on "change", (evt) ->
		if $("select#category_select option:selected").length >= 4
			console.log $('select#category_select option:not(:selected)').length
			$('select#category_select option:not(:selected)').attr('disabled', true).fadeTo(100, .3)
		else if $("select#category_select option:selected").length < 4
			$('select#category_select option:not(:selected)').attr('disabled', false).fadeTo(100, 1)
		
		if $("select#category_select option:selected").length > 0 and
			 $("select#category_select option:selected").length >= 5
			console.log $("select#category_select option:selected").length
			$('input.user_submit').attr('disabled', true)
			$('#category_warning').removeClass('hidden')
		else if $("select#category_select option:selected").length >= 1 or
						$("select#category_select option:selected").length >= 4
			$('input.user_submit').attr('disabled', false)
			$('#category_warning').addClass('hidden')