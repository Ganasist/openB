jQuery ->
  $('div.slider-horizontal').removeAttr('style')
  options =
    value: 0
    min: 0
    max: 100
    step: 5

  $('#review_quality').slider(options)
  $('#review_cost').slider(options)
  $('#review_timeliness').slider(options)
  $('#review_professionalism').slider(options)
  $('#review_recommendation').slider(options)
