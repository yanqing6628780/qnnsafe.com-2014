jQuery ($) ->
  loop_reset = (active) ->
    active.find('.link').hide()
    active.removeClass('active')
    if active.next().length > 0
      next = active.next()
    else
      next = $('#billboard .bb:first')
    next.addClass('active')
    next.find('.link').show()
    loopslider()
  loopslider = ->
    active = $('#billboard .bb.active')
    subtitle_left = $('.subtitle', active).css('left')
    image_right = $('.image', active).css('right')
    title_left = $('.title', active).css('left')
    if $(window).width() <= 480
      half = $('.title', active).width() / -2
      $('.title', active).css({ left: '50%', 'margin-left': half }).animate { opacity: 1 }, 200, ->
        half = $('.image', active).width() / -2
        $('.image', active).css({ right: '50%', 'margin-right': half }).animate { opacity: 1 }, 200, ->
          setTimeout ->
            $('.title', active).animate { opacity: 0  }, 200, ->
              $('.image', active).animate { opacity: 0  }, 200, ->
                $('.subtitle', active).animate { opacity: 0  }, 200, ->
                  $('.subtitle', active).css({ 'margin-left': 0, 'left': subtitle_left })
                  $('.image', active).css({ 'margin-right': 0, 'right': image_right })
                  $('.title', active).css({ 'margin-left': 0, 'left': title_left })
                  loop_reset active
          , 4000
    else
      $('.image', active).animate { right: "+=50", opacity: 1  }, 200, ->
        $('.title', active).animate { left: "-=50", opacity: 1  }, 200, ->
          $('.subtitle', active).animate({ left: "-=50", opacity: 1  })
          setTimeout ->
            $('.image', active).animate { right: "+=50", opacity: 0  }, 200, ->
              $('.title', active).animate { left: "-=50", opacity: 0  }, 200, ->
                $('.subtitle', active).animate { left: "-=50", opacity: 0  }, 200, ->
                  $('.subtitle', active).css('left', subtitle_left)
                  $('.image', active).css('right', image_right)
                  $('.title', active).css('left', title_left)
                  loop_reset active
          , 4000
  setTimeout loopslider, 500
