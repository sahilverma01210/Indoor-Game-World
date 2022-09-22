const WebSocket = require('ws')

const wss = new WebSocket.Server({ port: 8080 },()=>{
    console.log('server started')
})

var player1Online = false;
var player2Online = false;

var player1player2Online = false;
var player2player1Online = false;

var player1 = null
var player2 = null

var player = {
	"playerName" : "",
	"playerCharNo" : -1,
	"playerOnline" : false,
	"playerPlaying" : false,
	"playerMessageType" : "Status",
	"playerMessage" : "Offline",
	"playerWorld" : "",
	"playerReady" : false,
	"playerChoice" : "",
	"playerTurn" : false,
	"playerVectors" : null
}

wss.on('connection', function connection(client) {
   
	client.on('message', (data) => {
		var player = JSON.parse(data);
		console.log(player);
		
		if (player["playerName"] == "Player 1") {
			if(!player1Online){
				client.id = player["playerName"];
				console.log(`Client ${client.id} Connected!`)

				player1 = client
				player1Online = true;
			}
			
			if(player2Online){
				player2.send(JSON.stringify(player));
				if(!player1player2Online){
					player["playerName"] = "Player 2";
					player["playerCharNo"] = -1;
					player["playerOnline"] = true;
					player["playerPlaying"] = false;
					player["playerMessageType"] = "Status";
					player["playerMessage"] = "Online";
					player["playerWorld"] = "";
					player["playerReady"] = false;
					player["playerChoice"] = "";
					player["playerTurn"] = false;
					player["playerVectors"] = null;
					player1.send(JSON.stringify(player));
					player1player2Online = true;
				}
			}
			else{
				player["playerName"] = "Player 2";
				player["playerCharNo"] = -1;
				player["playerOnline"] = false;
				player["playerPlaying"] = false;
				player["playerMessageType"] = "Status";
				player["playerMessage"] = "Offline";
				player["playerWorld"] = "";
				player["playerReady"] = false;
				player["playerChoice"] = "";
				player["playerTurn"] = false;
				player["playerVectors"] = null;
				player1.send(JSON.stringify(player));
			}
		}
		else {

			if(!player2Online){
				client.id = player["playerName"];
				console.log(`Client ${client.id} Connected!`)

				player2 = client
				player2Online = true;
			}

			if(player1Online){
				player1.send(JSON.stringify(player));	
				if(player2player1Online){
					player["playerName"] = "Player 1";
					player["playerCharNo"] = -1;
					player["playerOnline"] = true;
					player["playerPlaying"] = false;
					player["playerMessageType"] = "Status";
					player["playerMessage"] = "Online";
					player["playerWorld"] = "";
					player["playerReady"] = false;
					player["playerChoice"] = "";
					player["playerTurn"] = false;
					player["playerVectors"] = null;
					player2.send(JSON.stringify(player));	
					player2player1Online = true;
				}
			}
			else{
				player["playerName"] = "Player 1";
				player["playerCharNo"] = -1;
				player["playerOnline"] = false;
				player["playerPlaying"] = false;
				player["playerMessageType"] = "Status";
				player["playerMessage"] = "Offline";
				player["playerWorld"] = "";
				player["playerReady"] = false;
				player["playerChoice"] = "";
				player["playerTurn"] = false;
				player["playerVectors"] = null;
				player2.send(JSON.stringify(player));
			}
		}

	})
	
	client.on('close', () => {

		if(client.id == "Player 1"){
			player1Online = false;
			if(player2Online){
				player["playerName"] = "Player 1";
				player["playerCharNo"] = -1;
				player["playerOnline"] = false;
				player["playerPlaying"] = false;
				player["playerMessageType"] = "Status";
				player["playerMessage"] = "Offline";
				player["playerWorld"] = "";
				player["playerReady"] = false;
				player["playerChoice"] = "";
				player["playerTurn"] = false;
				player["playerVectors"] = null;
				player2.send(JSON.stringify(player))
			}
		}
		else
		{
			player2Online = false;
			if(player1Online){
				player["playerName"] = "Player 2";
				player["playerCharNo"] = -1;
				player["playerOnline"] = false;
				player["playerPlaying"] = false;
				player["playerMessageType"] = "Status";
				player["playerMessage"] = "Offline";
				player["playerWorld"] = "";
				player["playerReady"] = false;
				player["playerChoice"] = "";
				player["playerTurn"] = false;
				player["playerVectors"] = null;
				player1.send(JSON.stringify(player))
			}
		}
		
		console.log("Removing Client: " + client.id)
	})
})
wss.on('listening',()=>{
   console.log('listening on 8080')
})