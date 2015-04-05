$(document).ready ->
  $('.btn-success').click ->
    $('#new_comment').toggle('slow')
  $(document)
    .on "ajax:beforeSend", ".comment", ->
      $(@).fadeTo('fast', 0.5)
    .on "ajax:success", ".comment", ->
      $(@).hide('fast')
    .on "ajax:error", ".comment", ->
      $(@).fadeTo('fast', 1)
