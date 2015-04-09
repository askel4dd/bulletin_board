$(document).ready ->
  $('#add-comment').click ->
    $(@).toggleClass('active')
    $('#new_comment').toggle('slow')
  $('#new_comment')
    .on "ajax:beforeSend", ->
      $(@).find('textarea')
        .addClass('uneditable-input')
        .attr('disabled', 'disabled');
    .on "ajax:success", (evt, data, status, xhr)->
      $(@).find('textarea')
        .removeClass('uneditable-input')
        .removeAttr('disabled', 'disabled')
        .val('');
      $(xhr.responseText)
        .hide()
        .insertAfter($(".well").children().last())
        .show('slow')
        .find(".best_in_place").trigger("click")
  $(document)
    .on "ajax:beforeSend", ".comment", ->
      $(@).fadeTo('fast', 0.5)
    .on "ajax:success", ".comment", (evt, data, status)->
      $(@).hide('fast') if status == 'success'
    .on "ajax:error", ".comment", ->
      $(@).fadeTo('fast', 1)
