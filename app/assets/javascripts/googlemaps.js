var map;
function initialize() {
  var map_element = document.getElementById('map-canvas');

  if (map_element) {
    geocoder = new google.maps.Geocoder();
    var latlng = new google.maps.LatLng(0, 0);
    var mapOptions = {
      zoom: 12,
      center: latlng,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    }

    map = new google.maps.Map(map_element, mapOptions);
    codeAddress();
  }
}

function codeAddress() {
  var address = $('#address').val();
  geocoder.geocode( { 'address': address}, function(results, status) {
    console.log(results);
    if (status == google.maps.GeocoderStatus.OK) {
      map.setCenter(results[0].geometry.location);
      var marker = new google.maps.Marker({
        map: map,
        position: results[0].geometry.location
      });
    } else {
      alert('Geocode was not successful for the following reason: ' + status);
    }
  });
}

$(document).ready(function() {
  initialize();
});
