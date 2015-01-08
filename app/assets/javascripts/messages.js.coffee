jQuery ->
  $('tr[data-link]').click ->
    window.location = this.dataset.link
