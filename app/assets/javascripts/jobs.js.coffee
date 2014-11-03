jQuery ->
	description_max = 2000
	$("label#description_feedback").html "* Job Description (" + description_max + " characters remaining)"
	$("#job_description").keyup ->
		text_remaining = description_max - $("#job_description").val().length
		$("label#description_feedback").html "* Job Description (" + text_remaining + " characters remaining)"

		$('label#description_feedback').addClass("overlimit") &&
			$('input.user_submit').attr("disabled", true) if text_remaining < 0

		$('label#description_feedback').removeClass("overlimit") &&
			$('input.user_submit').attr("disabled", false) if text_remaining  >= 0

	today = new Date()
	dd = today.getDate()
	$(".datepicker").datepicker(
  	'startDate' : "dd",
  	'format' : 'yyyy-mm-dd'
  	)