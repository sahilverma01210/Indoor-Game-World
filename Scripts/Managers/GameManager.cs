using UnityEngine;
using UnityEngine.SceneManagement;

public class GameManager : MonoBehaviour
{
    public static bool gameSelected;
    public static bool gameRunning;
    public static bool gamePaused;
    public static string requestedGame;
    public static Scene worldScene;
    public static GameObject games;
    public static GameObject spawnedGame;

    [SerializeField] Transform charTrans;
    [SerializeField] Transform arCameraTrans;
    [SerializeField] GameObject playerCamera;
    [SerializeField] GameObject gamesPrefab;
    [SerializeField] GameObject chessPrefab;
    [SerializeField] GameObject carromPrefab;
    [SerializeField] GameObject ludoPrefab;
    [SerializeField] GameObject snakeAndLadderPrefab;
    [SerializeField] AudioSource clickAudio;

    void Awake()
    {
        EventManager.current.arGamesSpawn += OnARGamesSpawn;
        EventManager.current.characterSelect += OnCharcterSelect;
        EventManager.current.gameSelect += OnGameSelect;
        EventManager.current.gameUnselect += OnGameUnselect;
        EventManager.current.gameInvite += OnGameInvite;
        EventManager.current.inviteAccept += OnGameAccept;
        EventManager.current.inviteDecline += OnGameDecline;
        EventManager.current.gameStart += OnGameStart;
        EventManager.current.gameWin += OnGameWin;
        EventManager.current.gameLoose += OnGameLoose;
        EventManager.current.gameQuit += OnGameQuit;
        EventManager.current.clickSound += OnClickSound;

        worldScene = SceneManager.GetActiveScene();
    }

    void OnARGamesSpawn(Vector3 position)
    {
        games = Instantiate(gamesPrefab, position, new Quaternion());
    }

    void OnCharcterSelect()
    {
        if (games == null)
        {
            games = Instantiate(gamesPrefab, new Vector3(0, 1.35f, 0), charTrans.rotation);
            games.transform.eulerAngles = ConnectionManager.player.playerName == "Player 1" ? new Vector3(0, 90, 0) : new Vector3(0, -90, 0);
        }
    }

    void OnGameSelect(GameObject gamePrefab)
    {
        if (spawnedGame != null) Destroy(spawnedGame);

        spawnedGame = Instantiate(gamePrefab, worldScene.name == "Real World Scene" ? games.transform.position : new Vector3(0, 1.35f, 0), worldScene.name == "Real World Scene" ? games.transform.rotation : charTrans.transform.rotation);
        gameSelected = true;
        Destroy(games);
    }

    void OnGameUnselect()
    {
        gameSelected = false;
        Destroy(spawnedGame);

        if (worldScene.name == "Real World Scene") games = Instantiate(gamesPrefab, spawnedGame.transform.position, spawnedGame.transform.rotation);
        else
        {
            if (games == null)
            {
                games = Instantiate(gamesPrefab, new Vector3(0, 1.35f, 0), charTrans.transform.rotation);
                games.transform.eulerAngles = ConnectionManager.player.playerName == "Player 1" ? new Vector3(0, 90, 0) : new Vector3(0, -90, 0);
            }
        }
    }

    void OnGameInvite(string gameName)
    {
        requestedGame = gameName;
    }

    void OnGameAccept()
    {
        if (!gameSelected) SelectStartGame(requestedGame);
        else
        {
            if (requestedGame == spawnedGame.name.Replace("(Clone)", ""))
            {
                if (requestedGame == "Ludo" || requestedGame == "Snake & Ladder") EventManager.current.DialogBox("Choose House");
                else EventManager.current.StartQuitGame(true);
            }
            else
            {
                EventManager.current.SelectUnselectGame(null);
                SelectStartGame(requestedGame);
            }
        }
    }

    void OnGameDecline()
    {
        ConnectionManager.opponent.playerTurn = false;
        EventManager.current.SendData("Play Response", "Declined");
    }

    void OnGameStart()
    {
        gameRunning = true;
    }

    void OnGameWin()
    {
        OnGameQuit();
    }

    void OnGameLoose()
    {
        OnGameQuit();
    }

    void OnGameQuit()
    {
        if (worldScene.name == "Real World Scene") ARManager.placed = false;
        gameRunning = false;
    }

    void OnClickSound()
    {
        clickAudio.Play();
    }

    void SelectStartGame(string requestedGame)
    {
        if (requestedGame == chessPrefab.name)
        {
            EventManager.current.SelectUnselectGame(chessPrefab);
            EventManager.current.StartQuitGame(true);
        }
        else if (requestedGame == carromPrefab.name)
        {
            EventManager.current.SelectUnselectGame(carromPrefab);
            EventManager.current.StartQuitGame(true);
        }
        else if (requestedGame == ludoPrefab.name)
        {
            EventManager.current.SelectUnselectGame(ludoPrefab);
            EventManager.current.DialogBox("Choose House");
        }
        else if (requestedGame == snakeAndLadderPrefab.name)
        {
            EventManager.current.SelectUnselectGame(snakeAndLadderPrefab);
            EventManager.current.DialogBox("Choose House");
        }
    }

    void OnDisable()
    {
        EventManager.current.arGamesSpawn -= OnARGamesSpawn;
        EventManager.current.characterSelect -= OnCharcterSelect;
        EventManager.current.gameSelect -= OnGameSelect;
        EventManager.current.gameUnselect -= OnGameUnselect;
        EventManager.current.gameInvite -= OnGameInvite;
        EventManager.current.inviteAccept -= OnGameAccept;
        EventManager.current.inviteDecline -= OnGameDecline;
        EventManager.current.gameStart -= OnGameStart;
        EventManager.current.gameWin -= OnGameWin;
        EventManager.current.gameLoose -= OnGameLoose;
        EventManager.current.gameQuit -= OnGameQuit;
        EventManager.current.clickSound -= OnClickSound;
    }
}