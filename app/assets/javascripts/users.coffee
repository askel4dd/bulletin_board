$(document).ready ->
  $('.best_in_place').best_in_place()
  map = new GMaps({
    div: '#map',
    lat: $("table").attr("data-data_lat") || 0,
    lng: $("table").attr("data-data_lng") || 0
  })
  proceedGeo = ()->
    GMaps.geocode({
      address: $('#user_address').val().trim(),
      callback: (results, status)->
        if status=='OK'
          latlng = results[0].geometry.location
          map.setCenter(latlng.lat(), latlng.lng())
          map.addMarker({
            lat: latlng.lat(),
            lng: latlng.lng()
          });
    })
  $('#user_address').change ->
    proceedGeo()
  $('#user_city').change ->
    proceedGeo()
  $('#user_state').change ->
    proceedGeo()
  $('#user_zip').change ->
    proceedGeo()
