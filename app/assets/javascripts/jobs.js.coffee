jQuery ->
	description_max = 2000
	description_min = 10
	title_max = 50
	title_min = 5
	description_remaining = description_max - $("#job_description").val().length

	$("label#description_feedback").html "* Job Description (" + description_max + " characters remaining)"

	description_check = ->
		$('#description_feedback').parent().addClass("has-error") unless $("#job_description").val().length in [description_min..description_max]
		$('#description_feedback').parent().removeClass("has-error") if $("#job_description").val().length in [description_min..description_max]

	title_check = ->
		$('#job_title').parent().addClass("has-error") unless $("#job_title").val().length in [title_min..title_max]
		$('#job_title').parent().removeClass("has-error") if $("#job_title").val().length in [title_min..title_max]

	description_check()
	title_check()

	$("#job_description").keyup ->
		text_remaining = description_max - $("#job_description").val().length
		$("label#description_feedback").html "* Job Description (" + text_remaining + " characters remaining)"
		description_check()

	$("#job_title").keyup ->
		title_check()

	today = new Date()
	dd = today.getDate()
	$(".datepicker").datepicker(
  	'startDate' : "dd",
  	'format' : 'yyyy-mm-dd'
  	)