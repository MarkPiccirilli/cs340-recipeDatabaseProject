function viewRecipe() {
    var recipe = document.getElementsByClassName('recipe').value
    window.location = '/recipes/' + encodeURI(recipe);
}
