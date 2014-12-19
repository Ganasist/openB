jQuery ->
  $('div.slider-horizontal').attr('style', "width:''") if $('div.slider-horizontal').length
  options =
    value: $(@).val() or 0
    min: 0
    max: 10
    step: 1

  $('#review_quality').slider(options) if $('#review_quality').length
  $('#review_cost').slider(options) if $('#review_cost').length
  $('#review_timeliness').slider(options) if $('#review_timeliness').length
  $('#review_professionalism').slider(options) if $('#review_professionalism').length
  $('#review_recommendability').slider(options) if $('#review_recommendability').length
