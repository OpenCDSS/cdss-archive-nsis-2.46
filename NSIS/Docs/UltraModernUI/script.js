var image_open = new Image();
image_open.src = "images/open.gif";
var image_closed = new Image();
image_closed.src = "images/closed.gif";

function toggle(image, section) {
	if(document.all) {
		if(document.all[section].style.display == "block") {
			document.all[section].style.display = "none";
			document.all[image].src = image_closed.src;
		} else {
			document.all[section].style.display = "block";
			document.all[image].src = image_open.src;
		}
	} else {
		if(document.getElementById(section).style.display == "block") {
			document.getElementById(section).style.display = "none";
			document.getElementById(image).src = image_closed.src;
		} else {
			document.getElementById(section).style.display = "block";
			document.getElementById(image).src = image_open.src;
		}
	}
}

function expandall() {
	var divNodeList = document.getElementsByTagName('div');
	for (i = 0; i < divNodeList.length; i++) {
		if(divNodeList[i].id) {
			divNodeList[i].style.display = "block";
			document.getElementById('trigger_' + divNodeList[i].id.substr(7)).src = "images/open.gif";
		}
	}
}

function collapseall() {
	var divNodeList = document.getElementsByTagName('div');
	for (i = 0; i < divNodeList.length; i++) {
		if(divNodeList[i].id) {
			divNodeList[i].style.display = "none";
			document.getElementById('trigger_' + divNodeList[i].id.substr(7)).src = "images/closed.gif";
		}
	}
}