// HELPER SCRIPT

var uuid = require('uuid-random');
const WebSocket = require('ws')

const wss1 = new WebSocket.WebSocketServer({port:8081}, ()=> {
	console.log('server started 8081')
})

var clients = []

//Websocket function that managages connection with clients
wss1.on('connection', function connection(client){

	//Create Unique User ID for player
	client.id = uuid();

	console.log(`Client ${client.id} Connected!`)

	clients.push(client)
	
	//Method retrieves message from client
	client.on('message', (data) => {
		var dataJSON = JSON.parse(data)
		console.log("Player Message")
		var point = {
			"vertices": dataJSON[0]["Items"],
			"indices": dataJSON[1]["Items"],
			"normals": dataJSON[2]["Items"],
			"uvs": dataJSON[3]["Items"],
			"rotation": dataJSON[4]["Items"]
		}
		console.log(point["rotation"][0])
		//console.log(dataJSON[0]["Items"])		
		for (var i = 0; i < clients.length; i++) {
			//if (clients[i].id!=client.id) {
				clients[i].send(JSON.stringify(point))
				console.log("sent")		
			//}	
		}
		//console.log(data.toString())
	})
	
	//Method notifies when client disconnects
	client.on('close', () => {
		console.log('8081 This Connection Closed!')
		console.log("Removing Client: " + client.id)
	})

})

wss1.on('listening', () => {
	console.log('listening on 8081')
})
