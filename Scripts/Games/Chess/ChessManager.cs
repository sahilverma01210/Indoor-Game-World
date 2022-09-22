using UnityEngine;
using System;

public class ChessManager : MonoBehaviour
{
    public static char[,,] grid = new char[8, 8, 3];
    public static bool[,] optionsGrid = new bool[8, 8];
    public static bool chessRunning;
    public static string selectedPiece;
    public static Action<string> pieceSelect;
    public static Action<string> pieceCancel;
    public static Action<Vector2> pieceMove;
    public static Action blockReset;

    [SerializeField] GameObject cancelledPieces;

    int scaleFactor = 2;

    void Awake()
    {
        EventManager.current.gameStart += OnStartChess;
        EventManager.current.gameWin += OnWinChess;
        EventManager.current.gameLoose += OnLooseChess;
        EventManager.current.gameQuit += OnQuitChess;
        pieceCancel += OnCancelPiece;
        gameObject.transform.localScale *= scaleFactor;

        ConnectionManager.player.playerVectors.Clear();
        ConnectionManager.player.playerVectors.Add(Vector3.zero);
        for (int i = 0; i <= grid.GetUpperBound(0); i++)
            for (int j = 0; j <= grid.GetUpperBound(1); j++)
                grid[i, j, 0] = grid[i, j, 1] = grid[i, j, 2] = 'x';
    }

    public void OnInviteChess()
    {
        EventManager.current.SoundClick();
        EventManager.current.DialogBox("Player Choice");
    }

    void OnStartChess()
    {
        gameObject.transform.GetChild(4).gameObject.SetActive(false);
        chessRunning = true;
        ConnectionManager.player.playerPlaying = true;

        ConnectionManager.player.playerChoice = ConnectionManager.opponent.playerChoice == "White" ? "Black" : "White";

        if (ConnectionManager.player.playerChoice == "Black") gameObject.transform.localEulerAngles += new Vector3(0, 180, 0);

        EventManager.current.SendData("Play Response", "Accepted");
    }

    void OnWinChess()
    {
        OnQuitChess();
    }

    void OnLooseChess()
    {
        OnQuitChess();
    }

    void OnQuitChess()
    {
        chessRunning = false;
        GameManager.gameSelected = false;
        ConnectionManager.player.playerPlaying = false;
        Destroy(gameObject);
    }

    void OnCancelPiece(string pieceName)
    {
        GameObject cancelledPiece = cancelledPieces.transform.Find(pieceName + "C").gameObject;
        cancelledPiece.SetActive(true);
    }

    void OnDisable()
    {
        EventManager.current.gameStart -= OnStartChess;
        EventManager.current.gameWin -= OnWinChess;
        EventManager.current.gameLoose -= OnLooseChess;
        EventManager.current.gameQuit -= OnQuitChess;
        pieceCancel -= OnCancelPiece;
    }

    void OnDestroy()
    {
        for (int i = 0; i <= grid.GetUpperBound(0); i++)
            for (int j = 0; j <= grid.GetUpperBound(1); j++)
                optionsGrid[i, j] = false;

        for (int i = 0; i <= grid.GetUpperBound(0); i++)
            for (int j = 0; j <= grid.GetUpperBound(1); j++)
                grid[i, j, 0] = grid[i, j, 1] = grid[i, j, 2] = 'x';
    }
}