$(document).on 'ready page:load', ->
  $('#new-comment').click ->
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
      $(xhr.responseText).hide().insertAfter($(".well > div").last()).show('slow')
      $(document).trigger('page:load')
  $(document)
    .on "ajax:beforeSend", ".comment", ->
      $(@).fadeTo('fast', 0.5)
    .on "ajax:success", ".comment", ->
      $(@).hide('fast')
    .on "ajax:error", ".comment", ->
      $(@).fadeTo('fast', 1)
