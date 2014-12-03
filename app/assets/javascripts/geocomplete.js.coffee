$ ->
	$("input#geocomplete").geocomplete(
	  details: "form.geocoder_form"
	  detailsAttribute: "geo"
	).bind("geocode:result", (event, result) ->
    console.log(result.geometry.location)
  )