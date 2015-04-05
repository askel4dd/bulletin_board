$(document).ready ->
  $('.btn-success').click ->
    $('#new_comment').toggle('slow')
  $(document).ajaxSuccess ->
    $('.row').hide()
