// Wrap this in a closure because L is both global AND non-descriptive.
(function(leaflet) {
  $(function() {
    leaflet('location-map')
  });
})(L);
