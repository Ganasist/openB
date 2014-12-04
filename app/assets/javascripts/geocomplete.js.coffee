$ ->
	$("input.geocomplete").geocomplete
		details: "form.geocoder_form"
		detailsAttribute: "data-geo"
		blur: true
		map: "div.map_canvas"
		mapOptions:
			backgroundColor: 'white'
		markerOptions:
			draggable: true
			title: 'Your location'
	.bind "geocode:result", (event, result) ->
		# $('div.map_canvas').removeClass('hidden')
		console.log result
	.bind "geocode:dragged", (event, latLng) ->
		$("input.geocomplete").geocomplete("find", latLng.lat() + "," + latLng.lng());
	.bind "geocode:error", (event, status) ->
  	console.log "Error: " + status
  