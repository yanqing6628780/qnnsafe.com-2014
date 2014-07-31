jQuery ($) ->
  if $('#pano').length == 1
    embedpano
      swf: '/assets/swf/qnnpano.swf'
      xml: '/assets/xml/virtual_tour.xml'
      target: 'pano'
      html5: 'auto'
      passQueryParameters: true
