jQuery ->
	today = new Date()
	dd = today.getDate()
	$('.datepicker').datepicker
  	'startDate' : "dd"
  	'format' : 'yyyy-mm-dd'