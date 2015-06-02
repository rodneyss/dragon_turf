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
  addMarkerToMap(gon.nearby_monsters, lat, lng);

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




var image = '/assets/ogre.png';

// function addMarkerToMap(lat, lng, htmlMarkupForInfoWindow){

function addMarkerToMap(locations, lat, lng){
  var i = 0;

  var markDown = setInterval(function(){
      console.log(i);
    var mon = locations[i];


    var infowindow = new google.maps.InfoWindow();
    var myLatLng = new google.maps.LatLng(mon.latitude, mon.longitude);
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

    var travel = distance_between(lat, lng, mon.latitude, mon.longitude);



     
  var ogreLink = "Name: " + mon.name + "<br>"+
                 "lvl: " + mon.level + "<br>"+
                "Dmg: " + mon.damage +"<br>"+
                "Def: " + mon.defence + "<br>";


 if(travel <= 30){
  ogreLink += "<a href='attack/"+ mon.id +"'"+" class='ogrepop'>attack</button>";
 }else{
  ogreLink += "distance: " + travel + "m<br>";
  }
 
                


    google.maps.event.addListener(marker, 'click', (function(marker, i) {
        return function() {
            infowindow.setContent(ogreLink);
            infowindow.open(map, marker);
        }
    })(marker, markerCount)); 

    }, 1000);
  };

Math.radians = function(degrees) {
  return degrees * Math.PI / 180;
};

function distance_between(lat1, lng1, lat2, lng2){
  // convert degrees to radians

  lat1 = Math.radians(lat1);
  lat2 = Math.radians(lat2);
  lng1 = Math.radians(lng1);
  lng2 = Math.radians(lng2);

  // compute deltas
  dlat = lat2 - lat1;
  dlon = lng2 - lng1;

  a = Math.pow( (Math.sin(dlat / 2)),2) + Math.cos(lat1) *
      Math.pow( (Math.sin(dlon / 2)), 2) * Math.cos(lat2);
  c = 2 * Math.atan2( Math.sqrt(a), Math.sqrt(1-a));
  return Math.round(c * 6371000);
}


function blurMe(){
  $('#blur').toggleClass('blurred');
}

function closeInv(){

  var spell = $(this).data('spell');
  console.log(spell);
  blurMe();
  $('#inventory').hide();
}

function showInv(){
  blurMe();
  console.log($(this).attr('id'));

  $('#inventory').show();
}

 // google.maps.event.addDomListener(window, 'ready', showMeMap);

$('#inventory').hide();

$('button').click(getLocation);
$('#inventory').on('click', '.inventory', closeInv);
$('#yourSpells').on('click', 'div', showInv);
});


