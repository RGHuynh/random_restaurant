# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

filter_box = (element)->
  $.ajax
    method: "POST"
    url: "/filter/index"
    success: (data) ->
      $(element).html(data)

result_box = (element) ->
    price = $("input[name='price[]']:checked").map ->
      $(this).val()

    $.ajax
      method: "POST"
      data: {
        sort_by: $("input[name='sort_by']").val(),
        price: price.get()
      }
      url: "/results/index"
      success: (data) ->
        $(element).html(data)


$ ->

  filter_box(".filter_box")

  $(".roll_btn").on "click", (event) ->
    event.preventDefault()
    result_box(".result_floating_box")

  