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
    
    
    if mapLatLng['latitude'] == undefined
      str = document.cookie
      tempArray = str.split(' ')
      mapLatLng['latitude'] = parseFloat(tempArray[0])
      mapLatLng['longitude'] = parseFloat(tempArray[1])
        
    
    $.ajax
      method: "POST"
      data: {
        latitude: mapLatLng['latitude'],
        longitude: mapLatLng['longitude'],        
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

mapLatLng = {}
position = (watchPosition) ->
  mapLatLng = watchPosition.coords
  mapLatLng = {
    latitude: watchPosition.coords.latitude,
    longitude: watchPosition.coords.longitude
  }

error = (err) ->
  console.warn("Error")
  
options =  {
  enableHighAccuracy: false,
  timeout: 10000,
  maximumAge: 0

}    

navigator.geolocation.getCurrentPosition(position, error, options)

$ ->

  $('.homepage_container').on "click", ".floating_filter_box", ->
    $('.floating_filter_box').toggle()
    
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


  $("#form-user_preference").on "click",('.button-submit'),(event) ->

    event.preventDefault()

    user_preference = {}

    user_preference.location = $('.form-user-location').val()

    user_preference.sort_by = $('.form-user-sortby').val()

    user_preference.distance = $('.form-user-distance').val()

    user_preference.price = $('.form-user-price').val()

    $.ajax
      method: 'POST'
      url: '/results/index'
      data: user_preference
      success: (data) ->
        $('.showcase-result').html(data)

    $.ajax
      method: "POST"
      data: {
        latitude: mapLatLng['latitude'],
        longitude: mapLatLng['longitude'],
      }
      url: "/results/index"
      success: (data) ->
        $('#googleMap').html(data)
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




 
    









