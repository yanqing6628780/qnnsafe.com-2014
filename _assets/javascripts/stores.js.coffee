jQuery ($) ->
  if Object.prototype.hasOwnProperty.call(window, 'STORES_SRC') and !Object.prototype.hasOwnProperty.call(window, 'STORES') and $('#stores').length > 0
    ifnone = $('#ifnone').clone();
    isdesktop = ->
      $(window).width() > 480
    return_none = ->
      $('#stores-list tbody').empty().append(ifnone)
      $('#stores_count').html(window.STORES_COUNT)
    $.getScript STORES_SRC, ->
      $('#stores_count').html(window.STORES_COUNT)
      $.each window.STORES, (a,b) ->
        $('#province').append('<option value="'+a+'">'+a+'</option>')
      $('#province').change ->
        $('#city option:not(:first)').remove()
        province = $('#province').val()
        if province.length > 0 and window.STORES.hasOwnProperty(province)
          keys = []
          $.each window.STORES[province], (a,b) ->
            $('#city').append('<option value="'+a+'">'+a+'</option>')
            keys.push a
          city_triggered = false
          if keys.length == 1
            $('#city').val(keys[0])
            unless isdesktop() # do not show all records in province if using mobile browsers
              $('#city').trigger('change')
              city_triggered = true
          if isdesktop() # show all records in province if using desktop browser
            $('#city').trigger('change')
          else if city_triggered == false
            return_none()
        else
          return_none()
      $('#city').change ->
        $('#stores-list tbody').empty()
        province = $('#province').val()
        city = $('#city').val()
        if city == '' and !isdesktop()
          return_none()
          return

        append = (a,b) ->
          tr = $('<tr />')
          store_info = b.slice()
          store_info.splice(1, 0, city)
          store_info.splice(1, 0, province)
          link = store_info.splice(-2,1)[0]
          if store_info.splice(-1,1)[0] == true
            tr.addClass('highlight')
          $.each store_info, (c, d) ->
            if c == 0 and link.length > 0
              d = '<a href="http://www.' + link + '" target="_blank">' + d + '</a>'
            $('<td />', html: d).appendTo tr
          $('#stores-list tbody').append tr

        if city == ''
          $.each window.STORES[province], (x,y) ->
            city = x
            $.each y, append
        else
          $.each window.STORES[province][city], append
        $('#stores_count').html($('#stores-list tbody tr').length)
