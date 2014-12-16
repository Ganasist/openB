jQuery ->
  $('div.slider-horizontal').attr('style', "width:''") if $('div.slider-horizontal').length
  options =
    value: $(this).val() or 0
    min: 0
    max: 100
    step: 5

  $('#review_quality').slider(options) if $('#review_quality').length
  $('#review_cost').slider(options) if $('#review_cost').length
  $('#review_timeliness').slider(options) if $('#review_timeliness').length
  $('#review_professionalism').slider(options) if $('#review_professionalism').length
  $('#review_recommendation').slider(options) if $('#review_recommendation').length
