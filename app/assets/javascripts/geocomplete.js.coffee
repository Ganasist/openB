$ ->
	$("input.geocomplete").geocomplete
		details: "form.geocoder_form"
		detailsAttribute: "data-geo"
		blur: true
		map: "div.map_canvas"
		componentRestrictions: 
			country: "US"
		mapOptions:
			backgroundColor: 'white'
		markerOptions:
			draggable: true
			title: 'Your location'
	.bind "geocode:result", (event, result) ->
		console.log result
	.bind "geocode:dragged", (event, latLng) ->
		$("input.geocomplete").geocomplete("find", latLng.lat() + "," + latLng.lng());
	.bind "geocode:error", (event, status) ->
  	console.log "Error: " + status
  