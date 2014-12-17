$ ->
	if $('.latitude').length
		setFormLocation = if !!$('.latitude').val() then [$('.latitude').val(), $('.longitude').val()] else ""
		setPanelLocation = if !!$('.latitude').html() then [$('.latitude').html(), $('.longitude').html()] else ""

	if $("input.geocomplete").length
		$("input.geocomplete").geocomplete
			details: "form.geocoder_form"
			detailsAttribute: "data-geo"
			blur: true
			location: setFormLocation
			map: "div.map_canvas_form"
			componentRestrictions:
				country: "US"
			mapOptions:
				backgroundColor: 'white'
			markerOptions:
				draggable: true
				title: 'Your location'
		.bind "geocode:result", (event, result) ->
			console.log event
			console.log result
		.bind "geocode:dragged", (event, latLng) ->
			console.log event
			console.log latLng
			$("input.geocomplete").geocomplete "find", latLng.lat() + "," + latLng.lng()
		.bind "geocode:error", (event, status) ->
	  	console.log event
			console.log status

	if $("div.map_canvas").length
		$("div.map_canvas").geocomplete
			location: setPanelLocation
			map: "div.map_canvas"
			mapOptions:
				backgroundColor: 'white'
			markerOptions:
				title: 'Your location'
