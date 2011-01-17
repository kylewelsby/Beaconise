 google.load('search', '1');
 var currentid = 0;
 var counter;

 $(function() {
	searchControl= new google.search.SearchControl();
	localSearch = new google.search.LocalSearch();
	searchControl.addSearcher(localSearch);	
	counter = $('#counter');
    send_and_get_next(0, 0, 0)
  });

function send_and_get_next(id, lat, lng) {
	$.ajax({
      type: "GET",
      url: "geocode.php",
      data: "id="+id+"&lat="+lat+"&lng="+lng,
      success: function(response) {
           if (response == 'stop')
		   {
				$(counter).html('finished geocoding');
		   } else {
			   response = response.split(',');
			   currentid = response[0];
			   $(counter).html(currentid);
				getPointFromPostcode(response[1]);
			}
      }
   });
}

function getPointFromPostcode(postcode) {
    localSearch.setSearchCompleteCallback(null,
        function() {
            if (localSearch.results[0]) {
                  var resultLat = localSearch.results[0].lat;
                  var resultLng = localSearch.results[0].lng;
                  console.log(resultLng);
				  send_and_get_next(currentid, resultLat, resultLng);
           }else{
                 send_and_get_next(currentid, 'error', 'error');
           }
       });
     localSearch.execute(postcode+', uk');
}