$(document).ready( function (){
var markerCount = 0;
var map;
var image = '/assets/ogre.png';


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

   var lat = position.coords.latitude;
   var lng = position.coords.longitude

    

    x.innerHTML = "Latitude: " + lat + 
    "<br>Longitude: " + lng; 

  sendData(lat, lng);
  showMeMap(lat, lng);
  addMarkerToMap(lat, lng);
}


function sendData(lat, lng){

var numbers = lat.toString()+ "," + lng.toString();

  $.ajax({
        type: "POST",/*method type*/
        contentType: "application/json; charset=utf-8",
        url: "/search",
        data: '{"my_data":"' + numbers + '"}',
        dataType: "json"
  });
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



// function addMarkerToMap(lat, lng, htmlMarkupForInfoWindow){

function addMarkerToMap(lat, lng){
  var i = 0;
  var locations = gon.nearby_monsters;

  if(locations.length != 0){
      var markDown = setInterval(function(){

          var mon = locations[i];
          var infowindow = new google.maps.InfoWindow();
          var myLatLng = new google.maps.LatLng(mon.latitude, mon.longitude);
          var marker = new google.maps.Marker({
              position: myLatLng,
              map: map,
              icon: image,
              animation: google.maps.Animation.DROP,
          });


        var travel = distance_between(lat, lng, mon.latitude, mon.longitude);

      
      var ogreLink = "<div class='informant'>Name: " + mon.name + "<br>"+
                     "lvl: " + mon.level + "<br>"+
                    "Dmg: " + mon.damage +"<br>"+
                    "Def: " + mon.defence + "<br>";


     if(travel <= 30){
      ogreLink += "<a href='attack/"+ mon.id +"'"+" class='ogrepop'>attack</a></div>";
     }else{
      ogreLink += "distance: " + travel + "m</div>";
      }
     


        google.maps.event.addListener(marker, 'click', (function(marker, i) {
            return function() {
                infowindow.setContent(ogreLink);
                infowindow.open(map, marker);
            }
        })(marker, markerCount)); 

        i++;
        if(i == locations.length){
          clearInterval(markDown);
        };

        }, 1000);

  };

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


///////////////////////////////// attacking monsters//////////////////////////

function blurMe(){
  $('#blur').toggleClass('blurred');
}

var slot;   //which slot was clicked on

var player = {atk:0 ,dmg: 0, def:0, spd:0 };

function playerCombinedStats(){

  spellStat = spellStat.split(",");
}

function closeInv(){
  var spell = $(this).data('spell');
  var spellid = $(this).data('spellid');
  var spellStat = $(this).data('stats');
  var eleIndex  = $(this).index();

  console.log(eleIndex);

  var slotPicked = document.getElementById(slot).getAttribute('data-eleid');
  
  slotPicked = parseInt(slotPicked);

  if( slotPicked != $(this).index() &&  slotPicked != 'n'  ){
    var oldSpell = $( $("#inventory .inventory").get( slotPicked ) );
    oldSpell.toggleClass('grayMe');
  }


  $(this).toggleClass('grayMe');

  $("#"+slot).removeClass();

   
  $("#"+slot).addClass(spell);
  $("#"+slot).attr('data-spell', spellid);
  $("#"+slot).attr('data-stats', spellStat);
  $("#"+slot).attr('data-eleid', eleIndex);
 

  $("#yourSpells div").text("");

  blurMe();
  $('#inventory').hide();




}

function showInv(){
  blurMe();
  

  slot = ( $(this).attr('id') );

  $('#inventory').show();

};

function calcHealth(currHealth, maxHealth){
  var diff = currHealth / maxHealth;
  diff = 100* diff;
  return diff;
};

function togAnim(whoHealth, diff){
  $(whoHealth).toggleClass('animHealth');
  $(whoHealth).css("width", diff+"%");
  setTimeout( function() { $(whoHealth).toggleClass('animHealth') }, 2000 );
};



function combatSetup(){

  var diff = calcHealth(gon.p_health, gon.p_max_health);
  $('.yourHealth').css("width", diff+"%");

  diff = calcHealth(gon.m_health, gon.m_max_health);
  $('.monsterHealth').css("width", diff+"%");


  if(gon.p_move === true){

        if(gon.m_injury > 0){
          setTimeout( monsterDamage, 1000);
          }
        if(gon.p_injury > 0){
          setTimeout( playerDamage, 3000);
          }

  }else{
        if(gon.p_injury > 0){
          setTimeout( playerDamage, 1000);
        }

        if(gon.m_injury > 0){
          setTimeout( monsterDamage, 3000);
        }

  };


  combatResult

};

function playerDamage(){
     var diff = calcHealth( (gon.p_health-gon.p_injury), gon.p_max_health );
      togAnim('.yourHealth', diff);
}

function monsterDamage(){
      var diff = calcHealth( (gon.m_health-gon.m_injury), gon.m_max_health );
      togAnim('.monsterHealth', diff);
}


function combatResult(){
  // if()
}



$('#inventory').hide();

function gofind(){
 document.location.reload();
};

if( $('#scanMonsters').length === 1) {
  getLocation();
};

if( $('#yourSpells').length ===1){
  combatSetup();
};


$('#scanMonsters').click(gofind);
$('#inventory').on('click', '.inventory', closeInv);
$('#yourSpells').on('click', 'div', showInv);
});


