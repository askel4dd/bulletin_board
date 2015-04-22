$(document).ready ->
  $('.best_in_place').best_in_place()
  map = new GMaps({
    div: '#map',
    lat: $("table").attr("data-data_lat") || 0,
    lng: $("table").attr("data-data_lng") || 0
  }) if typeof google == 'object' && typeof google.maps == 'object'
  proceedGeo = ()->
    GMaps.geocode({
      address: $("[data-behaviour~=address-field]").map (index, element)->
        element.value if element.value
      .get().join(", ")
      callback: (results, status)->
        if status=='OK'
          latlng = results[0].geometry.location
          map.setCenter(latlng.lat(), latlng.lng())
          map.addMarker({
            lat: latlng.lat(),
            lng: latlng.lng()
          })
    })
  $('[data-behaviour~=address-field]').change ->
    proceedGeo()
