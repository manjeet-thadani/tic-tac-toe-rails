var board, cells, gameId;

var setup = function() {
    board = document.getElementById("gamebox");
    cells = board.querySelectorAll(".grid-cell");
    gameId = board.getAttribute("game-id");

    _setListeners();
}

var _setListeners = function() {
    for (var i = 0; i < cells.length; i++) {
        cells[i].addEventListener("click", _cellSelected);
    }
}

var _cellSelected = function(event) {
    alert("Selected Position " + this.id);
}

window.addEventListener("load", function(event) {
    setup();
});