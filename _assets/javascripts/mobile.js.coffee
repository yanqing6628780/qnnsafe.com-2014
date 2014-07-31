jQuery ($) ->
  $('.page_nav li.active a').bind 'click', (e) ->
    dropdown = $(this).closest('.page_nav').find('.dropdown')
    if dropdown.is(':visible')
      e.preventDefault()
      dropdown.find('a').trigger('click')
  $('.page_nav li.dropdown a').bind 'click', (e) ->
    e.preventDefault()
    that = $(this)
    if that.find('.triangle').hasClass('down')
      that.parent('li').siblings().andSelf().addClass('dropshow')
      that.find('.triangle').removeClass('down').addClass('up')
      $('html, body').animate({ scrollTop: 100 }, 200)
    else
      that.parent('li').siblings().andSelf().removeClass('dropshow')
      that.find('.triangle').removeClass('up').addClass('down')
