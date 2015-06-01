$(document).ready( function (){
var markerCount = 0;
var map;


function getLocation() {
 


    if (navigator.geolocation) {

        // clearWatch() - Stops the watchPosition() method.
         // navigator.geolocation.watchPosition(showPosition, showError);

        navigator.geolocation.getCurrentPosition(showPosition, showError);
         
        x = document.getElementById("look");

    } else {
        x.innerHTML = "Geolocation is not supported by this browser.";
    }

}


function showPosition(position) {

    lat = position.coords.latitude;
    lng = position.coords.longitude

    sendData(lat, lng);

    x.innerHTML = "Latitude: " + lat + 
    "<br>Longitude: " + lng; 

}


function sendData(lat, lng){

numbers = lat.toString()+ "," + lng.toString();

  $.ajax({
        type: "POST",/*method type*/
        contentType: "application/json; charset=utf-8",
        url: "/search",
        data: '{"my_data":"' + numbers + '"}',
        dataType: "json"
  });

  showMeMap(lat, lng);
  addMarkerToMap(gon.nearby_monsters);

}

function showError(error) {
    switch(error.code) {
        case error.PERMISSION_DENIED:
            x.innerHTML = "User denied the request for Geolocation."
            break;
        case error.POSITION_UNAVAILABLE:
            x.innerHTML = "Location information is unavailable."
            break;
        case error.TIMEOUT:
            x.innerHTML = "The request to get user location timed out."
            break;
        case error.UNKNOWN_ERROR:
            x.innerHTML = "An unknown error occurred."
            break;
    }
}



  function showMeMap(lat, lng) {
    var cat = new google.maps.LatLng(lat, lng);

    var mapOptions = {
      center: { lat: lat, lng: lng},
      zoom: 15
    };
    map = new google.maps.Map(document.getElementById('map-canvas'),
        mapOptions);
    map.setOptions({styles: styles});
    var marker = createMarker(cat, map, "me");

  }
     




function createMarker(coords, map, title){
  marker = new google.maps.Marker({
    position: coords,
    map: map,
    title: title
  });
}




var styles = [
  {
    stylers: [
      { hue: "#00ffe6" },
      { saturation: -20 }
    ]
  },{
    featureType: "road",
    elementType: "geometry",
    stylers: [
      { lightness: 100 },
      { visibility: "simplified" }
    ]
  },{
    featureType: "road",
    elementType: "labels",
    stylers: [
      { visibility: "off" }
    ]
  },{
    featureType: "poi.business",
    elementType: "labels",
    stylers: [
      { visibility: "off" }
    ]
  },{
    featureType: "parks",
    elementType: "labels",
    stylers: [
      { visibility: "off" }
    ]
  }
];

  // var image = {
  //   url: '/assets/ogre.png',

  //   size: new google.maps.Size(200, 240)
   
  //   origin: new google.maps.Point(0,0),
 
  //   anchor: new google.maps.Point(0, 32)
  // };

var beaches = [
  ['Bondi Beach', -33.890542, 151.274856, 4],
  ['Coogee Beach', -33.923036, 151.259052, 5],
  ['Cronulla Beach', -34.028249, 151.157507, 3],
  ['Manly Beach', -33.80010128657071, 151.28747820854187, 2],
  ['Maroubra Beach', -33.950198, 151.259302, 1]
];




var image = '/assets/ogre.png';

// function addMarkerToMap(lat, lng, htmlMarkupForInfoWindow){

function addMarkerToMap(locations){
  var i = 0;

  var markDown = setInterval(function(){
      console.log(i);
    var mon = locations[i];



    var infowindow = new google.maps.InfoWindow();
    var myLatLng = new google.maps.LatLng(mon.lng, mon.lat);
    var marker = new google.maps.Marker({
        position: myLatLng,
        map: map,
        icon: image,
        animation: google.maps.Animation.DROP,
    });

    i++;
    if(i == locations.length){
      clearInterval(markDown);
    };
     
    //Gives each marker an Id for the on click
    // markerCount++;
 
    //Creates the event listener for clicking the marker
    //and places the marker on the 


    google.maps.event.addListener(marker, 'click', (function(marker, i) {
        return function() {
            infowindow.setContent("im an ogre!!! rawr");
            infowindow.open(map, marker);
        }
    })(marker, markerCount)); 

    }, 1000);
    }






function markme() {
  var lat = -33.8010375;
  var lng = 151.1575510;
}


 // google.maps.event.addDomListener(window, 'ready', showMeMap);

$('button').click(getLocation);

});


