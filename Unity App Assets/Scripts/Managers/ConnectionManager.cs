using System;
using UnityEngine;
using UnityEngine.UI;
using WebSocketSharp;
using Newtonsoft.Json;

public class ConnectionManager : MonoBehaviour
{
    public static bool opponentPresent;
    public static Player player;
    public static Player opponent;
    public static WebSocket webSocket;

    [SerializeField] string ServerIP; // 192.168.43.137  or 192.168.37.137
    [SerializeField] Button gameQuit;
    
    bool showMessage;

    void Awake()
    {
        DontDestroyOnLoad(gameObject);

        EventManager.current.dataSend += OnSendData;
        EventManager.current.playerSelect += OnSelectPlayerName;
        EventManager.current.characterSelect += OnCharcterSelect;
        EventManager.current.characterUnselect += OnCharacterUnselect;
        EventManager.current.opponentEnter += OnOpponentEnter;
        EventManager.current.opponentExit += OnOpponentExit;
        EventManager.current.gameInvite += OnGameInvite;
        EventManager.current.sideChoose += OnChoosePlayerSide;
        EventManager.current.gameWin += OnGameWin;
        EventManager.current.gameLoose += OnGameLoose;
        EventManager.current.gameQuit += OnGameQuit;
        EventManager.current.gameInvite += OnGameInvite;
        EventManager.current.playerTurnToggle += OnTogglePlayerTurn;

        player = new Player();
        opponent = new Player();

        ConnectServer();
    }

    void Update()
    {
        // Virtual World Opponent Animation Trigger
        if (GameManager.worldScene.name == "Virtual World Scene")
        {
            if (opponent.playerOnline && player.playerReady && opponent.playerReady)
            {
                if (!opponentPresent) EventManager.current.EnterExitOpponent(true);
            }
            else
            {
                if (opponentPresent) EventManager.current.EnterExitOpponent(false);
            }
        }

        if (!opponent.playerOnline && GameManager.gameRunning) gameQuit.onClick.Invoke();

        if (showMessage && opponent.playerMessage != null)
        {
            Debug.Log(opponent.playerName + " : " + opponent.playerMessage);

            switch (opponent.playerMessageType)
            {
                case "Play Request":
                    if (player.playerReady)
                    {
                        GameManager.requestedGame = opponent.playerMessage;
                        EventManager.current.DialogBox("Play Request");
                    }
                    showMessage = false;
                    return;
                case "Play Response":
                    if (opponent.playerMessage == "Accepted" && !player.playerPlaying) EventManager.current.StartQuitGame(true);
                    else player.playerTurn = false;
                    EventManager.current.DialogBox("Close Dialog");
                    showMessage = false;
                    return;
                case "Turn Complete":
                    EventManager.current.OpponentUpdate();
                    EventManager.current.TogglePlayerTurn(true);
                    if (CarromManager.carromRunning) EventManager.current.UpdateCarromScore(new Tuple<bool, int>(false, (int)opponent.playerVectors[2].x));
                    showMessage = false;
                    return;
                case "Carrom Sync":
                    EventManager.current.SyncCarrom();
                    showMessage = false;
                    return;
                case "Game State":
                    if (player.playerPlaying)
                    {
                        switch (opponent.playerMessage)
                        {
                            case "Win":
                                EventManager.current.WinLooseGame(false);
                                break;
                            case "Loose":
                                EventManager.current.WinLooseGame(true);
                                break;
                            case "Quit":
                                gameQuit.onClick.Invoke();
                                break;
                        }
                    }
                    showMessage = false;
                    return;
                default:
                    showMessage = false;
                    return;
            }
        }
    }

    void OnSendData(Tuple<string, string> data)
    {
        if (player.playerOnline)
        {
            player.playerMessageType = data.Item1;
            player.playerMessage = data.Item2;

            string jsonData = JsonUtility.ToJson(player);
            webSocket.Send(jsonData);
        }
        else EventManager.current.DisplayToast("Unable to Connect to Server");
    }

    void OnSelectPlayerName(string playerName)
    {
        player.playerName = playerName;
        opponent.playerName = playerName == "Player 1" ? "Player 2" : "Player 1";
        EventManager.current.SendData("Ping", "Online");
    }

    void OnCharcterSelect()
    {
        player.playerReady = true;
    }

    void OnCharacterUnselect()
    {
        player.playerCharNo = -1;
        player.playerReady = false;
    }

    void OnOpponentEnter()
    {
        opponentPresent = true;
    }

    void OnOpponentExit()
    {
        opponentPresent = false;
    }

    void OnGameInvite(string gameName)
    {
        GameManager.requestedGame = gameName;
        player.playerTurn = true;

        EventManager.current.SendData("Play Request", gameName);
        EventManager.current.DialogBox("Waiting");
    }

    void OnGameWin()
    {
        player.playerPlaying = player.playerReady = player.playerTurn = opponent.playerTurn = false;
        player.playerCharNo = -1;
        if (showMessage)
        {
            showMessage = false;
            EventManager.current.SendData("State Update", "Win");
        }
        else EventManager.current.SendData("Game State", "Win");
    }

    void OnGameLoose()
    {
        player.playerPlaying = player.playerReady = player.playerTurn = opponent.playerTurn = false;
        player.playerCharNo = -1;
        if (showMessage)
        {
            showMessage = false;
            EventManager.current.SendData("State Update", "Loose");
        }
        else EventManager.current.SendData("Game State", "Loose");
    }

    void OnGameQuit()
    {
        player.playerPlaying = player.playerReady = player.playerTurn = opponent.playerTurn = false;
        player.playerCharNo = -1;
        EventManager.current.SendData("Game State", "Quit");
    }

    void OnChoosePlayerSide(string playerSide)
    {
        player.playerChoice = playerSide;
    }

    void OnTogglePlayerTurn(bool isTurn)
    {
        player.playerTurn = isTurn;
        EventManager.current.SendData(isTurn ? "Turn Start" : "Turn Complete", player.playerMessage);
    }

    void ConnectServer()
    {
        webSocket = new WebSocket("ws://" + ServerIP + ":8080");
        webSocket.Compression = CompressionMethod.Deflate;

        webSocket.OnOpen += new EventHandler(OnSocketOpen);
        webSocket.OnMessage += new EventHandler<MessageEventArgs>(OnSocketMessage);
        webSocket.OnClose += new EventHandler<CloseEventArgs>(OnSocketClose);

        webSocket.Connect();
    }

    void DisconnectServer()
    {
        if (webSocket.IsAlive) webSocket.Close();
    }

    void OnSocketOpen(object sender, EventArgs e)
    {
        player.playerOnline = true;
    }

    void OnSocketMessage(object sender, MessageEventArgs e)
    {
        opponent = JsonConvert.DeserializeObject<Player>(e.Data);
        showMessage = true;
    }

    void OnSocketClose(object sender, CloseEventArgs e)
    {
        player.playerOnline = false;
    }

    void OnDisable()
    {
        EventManager.current.dataSend -= OnSendData;
        EventManager.current.playerSelect -= OnSelectPlayerName;
        EventManager.current.characterSelect -= OnCharcterSelect;
        EventManager.current.characterUnselect -= OnCharacterUnselect;
        EventManager.current.opponentEnter -= OnOpponentEnter;
        EventManager.current.opponentExit -= OnOpponentExit;
        EventManager.current.gameInvite -= OnGameInvite;
        EventManager.current.sideChoose -= OnChoosePlayerSide;
        EventManager.current.gameWin -= OnGameWin;
        EventManager.current.gameLoose -= OnGameLoose;
        EventManager.current.gameQuit -= OnGameQuit;
        EventManager.current.gameInvite -= OnGameInvite;
        EventManager.current.playerTurnToggle -= OnTogglePlayerTurn;
    }

    void OnApplicationQuit()
    {
        DisconnectServer();
    }
}