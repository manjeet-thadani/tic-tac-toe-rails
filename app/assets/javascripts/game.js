var gameBoard, cells, gameId;
var boardCells, boardSize, firstPlayerMarker;

var setup = function() {
    gameBoard = document.getElementById("gamebox");
    gameId = document.getElementById("game-id").innerHTML;
    cells = gameBoard.querySelectorAll(".grid-cell");

    firstPlayerMarker = document.getElementById("first-player").innerHTML;

    boardSize = parseInt(document.getElementById("grid-size").innerHTML);
    boardCells = Array(boardSize * boardSize).fill("");

    // set turn to player X
    document.getElementById("turn-message").innerHTML = `Player ${firstPlayerMarker} take your turn`;
    document.getElementById("results").style.visibility = "hidden";

    _setListeners();
}

var _setListeners = function() {
    for (var i = 0; i < cells.length; i++) {
        cells[i].addEventListener("click", _cellSelected);
    }
}

var _cellSelected = function(event) {
    var selectedPosition = this.id;
    if (boardCells[selectedPosition] !== "") {
        alert("Invalid Move!");
    }

    var request = {
        "id": gameId,
        "position": selectedPosition,
        "board": boardCells
    };

    var xhr = new XMLHttpRequest();
    xhr.open("POST", '/move', true);
    xhr.setRequestHeader("Content-Type", "application/json");

    xhr.onreadystatechange = function() {
        if (this.readyState === XMLHttpRequest.DONE && this.status === 200) {
            console.log(xhr.responseText);

            var response = JSON.parse(xhr.responseText);
            _updateBoard(response);

        } else if (this.readyState === XMLHttpRequest.DONE && this.status !== 200) {
            console.log("Error Occurred", xhr.responseText);
            alert("Ohhoo! Some Error Occurred");
        }
    }
    xhr.send(JSON.stringify(request));
}

var _updateBoard = function(response) {
    for (var i = 0; i < response.board.length; i++) {
        if (response.board[i] !== null) {
            boardCells[i] = response.board[i];
            var cell = document.getElementById(`${i}`)
            cell.className = "grid-cell " + boardCells[i];
        }
    }

    // TODO: check if game over OR win OR draw
    if (response.game_over) {
        document.getElementById("turn-message").innerHTML = "";

        var message = "Game Tied!";
        if (response.winner) {
            message = `Player ${response.winner.toUpperCase()} has won.`;
        }

        document.getElementById("result-message").innerHTML = message;
        document.getElementById("results").style.visibility = "visible";
        return;
    }

    if (response.next_turn) {
        document.getElementById("turn-message").innerHTML = `Player ${response.next_turn.toUpperCase()} take your turn `;
        document.getElementById('gamebox').className = response.next_turn;
    }
}

window.addEventListener("load", function(event) {
    setup();
});