(function($, google) {
  var googleMaps = (function googleMaps() {

    var $map = $('#location-map'),
        name = $map.data('name'),
        address = $map.data('address')

    var tmpCoords = new google.maps.LatLng('51.52572', '-0.110048')

    var tmpMarker = function(map) {
      return new google.maps.Marker({
        map: map,
        position: new google.maps.LatLng('51.52572', '-0.110048'),
        title: 'Rails Girls'
      });
    };


    var mapOptions = {
      zoom: 14,
      mapTypeId: google.maps.MapTypeId.ROAD_MAP,
      center: new google.maps.LatLng('51.52572', '-0.110048') 
    }

    var map = new google.maps.Map($map[0], mapOptions)
    tmpMarker(map)

  })

  $(googleMaps)
})(jQuery, google)
