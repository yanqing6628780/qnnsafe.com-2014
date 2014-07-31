jQuery ($) ->
  $('#case_container').isotope
    itemSelector: '.case_item'

  $('#filters a').click (e) ->
    if $(this).data('filter')
      e.preventDefault()
      li = $(this).parent()
      li.siblings('li').removeClass('active')
      li.addClass('active')
      $('#case_container').isotope({ filter: $(this).data('filter') })
  $(".case_item").magnificPopup
    delegate: "a"
    type: "image"
    closeOnContentClick: false
    closeBtnInside: false
    mainClass: "mfp-with-zoom mfp-img-mobile"
    image:
      verticalFit: true
      titleSrc: (item) ->
        item.el.attr('title')
    gallery:
      enabled: true
    zoom:
      enabled: true
      duration: 300
      opener: (element) ->
        element.find "img"

  $('.social-media').magnificPopup
    type: "image"
    zoom:
      enabled: true
      duration: 300
      opener: (element) ->
        element
