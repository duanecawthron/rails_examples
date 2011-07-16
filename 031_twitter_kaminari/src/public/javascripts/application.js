var highestClientCount = 0; // id of the most recent post displayed on the page
var highestServerCount = 0; // id of the most recent post available form the server
var lowestClientPage =  -1; // lowest page number of posts displayed on the page
var checkScrollTimeout = 250;
var checkCountTimeout = 5000;
var handleMoreButtonPerPage = 5;
var handleMoreButtonRunning = false;

function gotPageFromServer(count, pageNumber) {
	if (count > highestClientCount) {
		highestClientCount = count;
	}
	if (count > highestServerCount) {
		highestServerCount = count;
	}
	if (pageNumber < lowestClientPage || lowestClientPage == -1) {
		lowestClientPage = pageNumber;
	}
	if (lowestClientPage > 1) {
		$("#loading").show();
	} else {
		$("#loading").hide();
	}
	if (lowestClientPage > 1) {
		setTimeout("checkScroll()", checkScrollTimeout);
	}
}

function gotMoreFromServer(count) {
	if (count > highestClientCount) {
		highestClientCount = count;
	}
	checkCount();
}

function showOrHideMoreButton() {
	if (handleMoreButtonRunning) {
		$("#more_form").hide();
	}
	else if (highestServerCount > highestClientCount)
		$("#more_form").show();
	else {
		$("#more_form").hide();
		setTimeout("checkCount()", checkCountTimeout);
	}
}

function gotCountFromServer(count) {
	if (count > highestServerCount) {
		highestServerCount = count;
	}
	showOrHideMoreButton();
}

function checkCount() {
	$.ajax({
		url: "http://localhost:3000/count.js",
		dataType: "script",
		type: "GET"
	});
	// http://localhost:3000/count.js calls gotCountFromServer()
}

function checkScroll() {
	if (lowestClientPage > 1) {
		if (nearBottomOfPage()) {
			lowestClientPage--;
			$.ajax({
				url: "http://localhost:3000/home.js?page=" + lowestClientPage,
				dataType: "script",
				type: "GET"
			});
			// http://localhost:3000/home.js will call gotPageFromServer()
		}
		else {
			setTimeout("checkScroll()", checkScrollTimeout);
		}
	}
}

function nearBottomOfPage() {
  return scrollDistanceFromBottom() < 150;
}

function scrollDistanceFromBottom(argument) {
  return pageHeight() - (window.pageYOffset + self.innerHeight);
}

function pageHeight() {
  return Math.max(document.body.scrollHeight, document.body.offsetHeight);
}

function handleMoreButton() {
	if (handleMoreButtonRunning) return;
	handleMoreButtonRunning = true;
	showOrHideMoreButton();
	$.ajax({
		url: "http://localhost:3000/more.js?page=1&per_page=" + handleMoreButtonPerPage + "&skip=" + highestClientCount,
		dataType: "script",
		type: "GET",
		complete: function(){
			handleMoreButtonRunning = false;
			showOrHideMoreButton();
			checkCount();
		}
	});
	// http://localhost:3000/home.js will call gotMoreFromServer()
}

function start_ublog() {
	$("#more_form").hide();
	$("#more_btn").click(function(event){
		handleMoreButton();
		event.preventDefault();
	});
	checkCount();
}
