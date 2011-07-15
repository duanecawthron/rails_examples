var highestClientCount = 0; // id of the most recent post displayed on the page
var highestServerCount = 0; // id of the most recent post available form the server
var lowestClientPage =  -1; // lowest page number of posts displayed on the page
var checkScrollTimeout = 250;
var checkCountTimeout = 1000;
var morePerPage = 5;

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
	if (lowestClientPage == 1) {
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

function gotCountFromServer(count) {
	if (count > highestServerCount) {
		highestServerCount = count;
	}
	if (highestServerCount > highestClientCount)
		$("#more_form").show();
	else {
		$("#more_form").hide();
		setTimeout("checkCount()", checkCountTimeout);
	}
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
	$.ajax({
		url: "http://localhost:3000/more.js?page=0&per_page=" + morePerPage + "&skip=" + highestClientCount,
		dataType: "script",
		type: "GET"
	});
	// http://localhost:3000/home.js will call gotMoreFromServer()
}
