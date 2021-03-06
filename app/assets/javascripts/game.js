var ttt =
    function() {
        var cells, gameId, overlay;
        var boardCells, boardSize, computerMode, firstPlayerMarker, currentPlayerMarker, reqInProgress = false,
            gameOver = false;

        var setup = function() {
            gameId = document.getElementById("game-id").innerHTML;
            computerMode = document.getElementById("computer-mode").innerHTML;
            cells = document.querySelectorAll(".cell");
            overlay = document.querySelector(".overlay");

            firstPlayerMarker = document.getElementById("first-player").innerHTML;
            currentPlayerMarker = firstPlayerMarker;

            boardSize = parseInt(document.getElementById("grid-size").innerHTML);
            boardCells = Array(boardSize * boardSize).fill("");

            // set turn to player X
            document.getElementById("message").innerHTML = "Player " + firstPlayerMarker.toUpperCase() + " take your turn";

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
                return;
            }

            if (gameOver || reqInProgress) return;

            var request = {
                "id": gameId,
                "position": selectedPosition,
            };

            // update cell to show selected position till API response is obtained
            var cell = document.getElementById("" + selectedPosition);
            cell.className = "cell " + currentPlayerMarker;

            // remove listener once cell is clicked
            cell.removeEventListener("click", _cellSelected);

            var message = "Processing! Please wait..."
            if (computerMode == "true") {
                message = "Computer's Turn. It's thinking..."
            }

            document.getElementById("message").innerHTML = message;

            var xhr = new XMLHttpRequest();
            xhr.open("POST", '/move', true);
            xhr.setRequestHeader("Content-Type", "application/json");

            xhr.onreadystatechange = function() {
                if (this.readyState === XMLHttpRequest.DONE && this.status === 200) {
                    var response = JSON.parse(xhr.responseText);
                    _updateBoard(response);

                } else if (this.readyState === XMLHttpRequest.DONE && this.status !== 200) {
                    console.error("Error Occurred", xhr.responseText);
                    alert("Ohhoo! Some Error Occurred");
                }

                _hideOverlay();
                reqInProgress = false
            }

            _showOverlay();
            reqInProgress = true

            xhr.send(JSON.stringify(request));
        }

        var _updateBoard = function(response) {
            for (var i = 0; i < response.board.length; i++) {
                if (response.board[i] !== null) {
                    boardCells[i] = response.board[i];
                    var cell = document.getElementById("" + i)
                    cell.className = "cell " + boardCells[i];
                }
            }

            if (response.game_over) {
                gameOver = true;
                document.getElementById("message").innerHTML = "";

                var message = "Game Tied!";
                if (response.winner) {
                    message = "Player " + response.winner.toUpperCase() + " won!Play Again?";
                }

                document.getElementById("message").innerHTML = message;
                document.getElementById("reset").style.visibility = "visible";
                return;
            }

            if (response.next_turn) {
                document.getElementById("message").innerHTML = "Player " + response.next_turn.toUpperCase() + " take your turn";
            }

            currentPlayerMarker = response.next_turn;
        }

        var _showOverlay = function() {
            overlay.classList.remove("hide");
            overlay.classList.add("show");
        }

        var _hideOverlay = function() {
            overlay.classList.remove("show");
            overlay.classList.add("hide");
        }

        return {
            setup
        }
    }();

window.addEventListener("load", function(event) {
    ttt.setup();
});