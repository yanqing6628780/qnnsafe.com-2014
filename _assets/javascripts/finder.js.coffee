jQuery ($) ->
  $('#finder').isotope
    itemSelector: '.item'
  update_filter = ->
    filter = ''
    $('#finder-filter .panel').each (a,b) ->
      active = $(b).find('a.active:first')
      filter += active.data('filter')
      $(b).find('span.value').text(active.text())
    $('#finder').isotope({ filter: filter })
  $('#finder-filter a').click (e) ->
    e.preventDefault()
    $(this).siblings().removeClass('active')
    $(this).addClass('active')
    update_filter()
