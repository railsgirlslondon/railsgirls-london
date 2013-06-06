(function($, google) {
  var googleMaps = (function googleMaps() {

    var $map = $('#location-map'),
        address = $map.data('address'),
        latitude = $map.data('coordinatesLat'),
        longitude = $map.data('coordinatesLng')

    console.log($map.data())
    var latLng = new google.maps.LatLng(latitude, longitude)

    var mapOptions = {
      zoom: 14,
      mapTypeId: google.maps.MapTypeId.ROAD_MAP,
      center: latLng 
    }

    return (function createMarkedMap(ele, opts) {
      var map = new google.maps.Map(ele, opts)
      
      new google.maps.Marker({
        map: map,
        position: opts.center,
        title: address
      })
    })($map[0], mapOptions)

  })

  $(googleMaps)
})(jQuery, google)
