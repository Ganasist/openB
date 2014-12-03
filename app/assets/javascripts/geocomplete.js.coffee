$ ->
	$("input#geocomplete").geocomplete(
	  details: "form.registration_edit"
	  detailsAttribute: "geo"
	).bind("geocode:result", (event, result) ->
    console.log(result.geometry.location)
  )