# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $.ajax
    method: "GET"
    url: "/filter/index"
    success: (data) ->
      $(".filter_box").html(data)

  $(".roll_btn").on "click", (event)->

    price = $("input[name='price[]']:checked").map ->
      $(this).val()

    event.preventDefault()
    $.ajax
      method: "GET"
      data: {
        sort_by: $("input[name='sort_by']").val(),
        price: price.get()
      }
      url: "/results/index"
      success: (data) ->
        $(".homepage_container").html(data)

