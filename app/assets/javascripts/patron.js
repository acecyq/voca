window.onload = function() {	
	var url = new URL(window.location.href);
	var store = url.searchParams.get("store");
	if (store) {
		setTimeout(function() {
			location.reload();
		}, 3000);
	}
}