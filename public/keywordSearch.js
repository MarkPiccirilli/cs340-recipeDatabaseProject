function keywordSearch() {
    var keyword = document.getElementById('keyword').value
    window.location = '/keyword_search/' + encodeURI(keyword);
}
