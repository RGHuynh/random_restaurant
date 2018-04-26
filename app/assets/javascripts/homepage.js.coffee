# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/





filter_box = (element)->
  $.ajax
    method: "POST"
    url: "/filter/index"
    success: (data) ->
      $(element).html(data)

result_box = (element, test) ->
    price = $("input[name='price[]']:checked").map ->
      $(this).val()
    LatLong = "This is nothing"
        

    $.ajax
      method: "POST"
      data: {
        sort_by: $("input[name='sort_by']").val(),
        price: price.get()
      }
      url: "/results/index"
      success: (data) ->
        $(element).html(data)
        $(element).css('display','block')
        $("#gmap").hide()
        $("#lmap").hide()
        lat = parseFloat($("#gmap").html())
        lng = parseFloat($("#lmap").html())
        location = {lat: lat, lng: lng}
        map = new google.maps.Map(document.getElementById("googleMap"), {
          center:location,
          zoom:18

        })
        marker = new google.maps.Marker({
          position:location,
          map:map
        })


position = (watchPosition) ->
  console.log(watchPosition)

error = (err) ->
  console.warn("Error")

options =  {
  enableHighAccuracy: false,
  timeout: 10000,
  maximumAge: 0

}    

navigator.geolocation.watchPosition(position, error, options)
$ ->

  

  $('.homepage_container').on "click", ".floating_filter_box", ->
    ('.floating_filter_box').toggle()
    
  $('button').find(".result_filter").on "click", (event)->
    event.preventDefault()
    alert("success")

  filter_box(".filter_box")

  $(".roll_btn").on "click", (event) ->
    event.preventDefault()
    result_box(".result_floating_box")
    
  

  $(".result_floating_box").on "click",('.result_filter'), ->
    filter_box('.floating_filter_box')
    $('.floating_filter_box').toggle()










