import "bootstrap";
import "jquery";
import range from "rangeslider.js";
import places from 'places.js';
import swal from 'sweetalert';
// import L from 'leaflet';

$(document).ready(function(){

	var inputs = document.querySelectorAll('.algolia');

[].forEach.call(inputs, function(item) {
      var placesAutocomplete = places({
        appId: 'plC8UYAMHK2J',
        apiKey: '1269f51d6f6aceff6a532f29caa6fdb0',
        container: item
      })
});


$("#add-extra-field").click(function () {
  $(".destination:hidden").first().show();
});

$("#remove-extra-field").click(function () {
  if( $(".destination:visible").length > 1 ){
    $(".destination:visible").last().hide();
  }
});

$("#add-extra-field").click(function () {
  $(".friends:hidden").first().show();
});

$("#remove-extra-field").click(function () {
  if( $(".friends:visible").length > 1 ){
    $(".friends:visible").last().hide();
  }
});

console.log($('input[type="range"]'))
$('input[type="range"]').each(function (index, input) {
 $(input).rangeslider();

  $(input).on("change", function (element) {
    $(input).parents(".slidecontainer").find(".counterRating").text($(this).val())
  })

  $(input).trigger("change")
})


});



export { bindSweetAlertButtonDemo };



//############### ALGOLIA LEAFLET MAP ############################

  // var placesAutocomplete = places({
  //   appId: 'plC8UYAMHK2J',
  //   apiKey: '1269f51d6f6aceff6a532f29caa6fdb0',
  //   container: document.querySelector('#input-map')
  // });

  // var map = L.map('map-example-container', {
  //   scrollWheelZoom: false,
  //   zoomControl: false
  // });

  // var osmLayer = new L.TileLayer(
  //   'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
  //     minZoom: 1,
  //     maxZoom: 13,
  //     attribution: 'Map data © <a href="https://openstreetmap.org">OpenStreetMap</a> contributors'
  //   }
  // );

  // var markers = [];

  // map.setView(new L.LatLng(0, 0), 1);
  // map.addLayer(osmLayer);

  // placesAutocomplete.on('suggestions', handleOnSuggestions);
  // placesAutocomplete.on('cursorchanged', handleOnCursorchanged);
  // placesAutocomplete.on('change', handleOnChange);
  // placesAutocomplete.on('clear', handleOnClear);

  // function handleOnSuggestions(e) {
  //   markers.forEach(removeMarker);
  //   markers = [];

  //   if (e.suggestions.length === 0) {
  //     map.setView(new L.LatLng(0, 0), 1);
  //     return;
  //   }

  //   e.suggestions.forEach(addMarker);
  //   findBestZoom();
  // }

  // function handleOnChange(e) {
  //   markers
  //     .forEach(function(marker, markerIndex) {
  //       if (markerIndex === e.suggestionIndex) {
  //         markers = [marker];
  //         marker.setOpacity(1);
  //         findBestZoom();
  //       } else {
  //         removeMarker(marker);
  //       }
  //     });
  // }

  // function handleOnClear() {
  //   map.setView(new L.LatLng(0, 0), 1);
  //   markers.forEach(removeMarker);
  // }

  // function handleOnCursorchanged(e) {
  //   markers
  //     .forEach(function(marker, markerIndex) {
  //       if (markerIndex === e.suggestionIndex) {
  //         marker.setOpacity(1);
  //         marker.setZIndexOffset(1000);
  //       } else {
  //         marker.setZIndexOffset(0);
  //         marker.setOpacity(0.5);
  //       }
  //     });
  // }

  // function addMarker(suggestion) {
  //   var marker = L.marker(suggestion.latlng, {opacity: .4});
  //   marker.addTo(map);
  //   markers.push(marker);
  // }

  // function removeMarker(marker) {
  //   map.removeLayer(marker);
  // }

  // function findBestZoom() {
  //   var featureGroup = L.featureGroup(markers);
  //   map.fitBounds(featureGroup.getBounds().pad(0.5), {animate: false});
  // }
