jQuery ->
	description_max = 2000
	$("label#description_feedback").html "Job Description (" + description_max + " characters remaining)"
	$("#job_description").keyup ->
		text_remaining = description_max - $("#job_description").val().length
		$("label#description_feedback").html "Job Description (" + text_remaining + " characters remaining)"

		$('label#description_feedback').addClass("overlimit") &&
			$('input.user_submit').attr("disabled", true) if text_remaining < 0

		$('label#description_feedback').removeClass("overlimit") &&
			$('input.user_submit').attr("disabled", false) if text_remaining  >= 0

	$("input.check_boxes").on "change", (evt) ->
		if $("input.check_boxes:checked").length == 3
			$("input.check_boxes:not(:checked)").attr('disabled', true).parent().fadeTo(100, .3)
		else if $("input.check_boxes:checked").length < 3
			$("input.check_boxes:not(:checked)").attr('disabled', false).parent().fadeTo(100, 1)
		
		if $("input.check_boxes:checked").length == 0
			$('input.user_submit').attr('disabled', true)
			$('#category_warning').removeClass('hidden')
		else if $("input.check_boxes:checked").length > 0
			$('input.user_submit').attr('disabled', false)
			$('#category_warning').addClass('hidden')