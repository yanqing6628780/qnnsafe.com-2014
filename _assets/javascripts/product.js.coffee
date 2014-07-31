jQuery ($) ->
  if (window.screen && window.screen.width > 480)
    children = $('#product_menu > ul.ddmenu > li').length
    count = Math.ceil(children / 6)
    for page in [1..count]
      ul = $('<ul />').appendTo('#showcase')
      for item in [(page-1)*6..page*6-1]
        child = $('#product_menu > ul.ddmenu > li').eq(item)
        if child.length == 1
          ul.append(child.clone())
    if children <= 6
      $('#showcase').addClass('shorter')
    $('#showcase').append('<div class="nav"></div>')
    if count > 1
      for page in [1..count]
        $('#showcase .nav').append('<a href="#">'+page+'</a>')
    $('#showcase').catslider()

  $('.dropdownmenu a.btn').click (e) ->
    e.preventDefault()
    e.stopPropagation()
    menu = $(this).closest('.dropdownmenu')
    if menu.hasClass('open')
      menu.removeClass('open')
    else
      menu.addClass('open')

  $(document).click (e) ->
    $('.dropdownmenu').removeClass('open')

  $('.page_nav.is_pager').find('li:not(.dropdown)').find('a').click (e) ->
    e.preventDefault()
    $(this).parent().siblings('li').removeClass('active')
    $(this).parent().addClass('active')
    index = $(this).parent().index()
    children = $('.pages').children()
    children.filter(':visible').fadeOut 'fast', ->
      children.eq(index).fadeIn 'fast'

  $('#product_details .cc .image').delay(500).animate { right: "+=50", opacity: 1  }, 200, ->
    $('#product_details .cc .title').animate { left: "-=50", opacity: 1  }, 200
  $('#product_details .cc').hover ->
    $(this).find('.hover').removeClass('hidden')
  , ->
    $(this).find('.hover').addClass('hidden')

  $("#features").panzoom()
