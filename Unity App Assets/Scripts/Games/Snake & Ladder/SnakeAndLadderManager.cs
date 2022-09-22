using System.Collections.Generic;
using UnityEngine;

public class SnakeAndLadderManager : MonoBehaviour
{
    public static int diceVal;
    public static bool snakeLadderRunning;

    [SerializeField] GameObject dice;
    [SerializeField] GameObject redCoin;
    [SerializeField] GameObject blueCoin;
    [SerializeField] GameObject greenCoin;
    [SerializeField] GameObject yellowCoin;

    bool diceRolled;
    bool playerOut;
    int ladderIdx;
    int deltaVal;
    int numOfSixes;
    int currentIndex;
    int scaleFactor = 3;
    Dictionary<int, int> snakeLadder = new Dictionary<int, int>();
    Vector3 startPoint = new Vector3(-0.135f, 0.01f, -0.135f);
    Rigidbody diceRb;
    GameObject playerCoin, opponentCoin;

    void Awake()
    {
        EventManager.current.gameStart += OnStartSnakeLadder;
        EventManager.current.gameWin += OnWinSnakeLadder;
        EventManager.current.gameLoose += OnLooseSnakeLadder;
        EventManager.current.gameQuit += OnQuitSnakeLadder;
        EventManager.current.opponentUpdate += OnUpdateOpponent;
        EventManager.current.diceRoll += OnRollDice;
        EventManager.current.playerTurnToggle += OnTogglePlayerTurn;
        gameObject.transform.localScale *= scaleFactor;

        snakeLadder[4] = 25;
        snakeLadder[13] = 46;
        snakeLadder[27] = 5;
        snakeLadder[33] = 49;
        snakeLadder[40] = 3;
        snakeLadder[42] = 63;
        snakeLadder[43] = 18;
        snakeLadder[50] = 69;
        snakeLadder[54] = 31;
        snakeLadder[62] = 81;
        snakeLadder[66] = 45;
        snakeLadder[74] = 92;
        snakeLadder[76] = 58;
        snakeLadder[89] = 53;
        snakeLadder[99] = 41;

        ConnectionManager.player.playerVectors.Clear();
        ConnectionManager.player.playerVectors.Add(Vector3.zero);
        diceRb = dice.GetComponent<Rigidbody>();
    }

    void FixedUpdate()
    {
        if (snakeLadderRunning && ConnectionManager.player.playerTurn && diceRolled && diceRb.IsSleeping())
        {
            diceRolled = false;

            if (!playerOut)
            {
                if (diceVal == 1 || diceVal == 6)
                {
                    ConnectionManager.player.playerVectors[0] = playerCoin.transform.localPosition = startPoint;
                    currentIndex = 1;
                    playerOut = true;
                    return;
                }

                EventManager.current.TogglePlayerTurn(false);
                return;
            }

            if (diceVal == 6)
            {
                if (numOfSixes == 3)
                {
                    diceVal = 0;
                    numOfSixes = 0;
                }
                else
                {
                    numOfSixes++;
                    deltaVal += diceVal;
                }
                return;
            }

            deltaVal += diceVal;
            MoveCoin(deltaVal);
            deltaVal = 0;
            numOfSixes = 0;

            if (snakeLadder.ContainsKey(ladderIdx) && snakeLadder[ladderIdx] == currentIndex && currentIndex > ladderIdx) return;

            EventManager.current.TogglePlayerTurn(false);
        }           
    }

    public void OnInviteSnakeLadder()
    {
        EventManager.current.SoundClick();
        EventManager.current.DialogBox("Player Choice");
    }

    void OnStartSnakeLadder()
    {
        redCoin.SetActive(false);
        blueCoin.SetActive(false);
        greenCoin.SetActive(false);
        yellowCoin.SetActive(false);

        switch (ConnectionManager.player.playerChoice)
        {
            case "Red":
                redCoin.SetActive(true);
                playerCoin = redCoin;
                break;
            case "Blue":
                blueCoin.SetActive(true);
                playerCoin = blueCoin;
                break;
            case "Green":
                greenCoin.SetActive(true);
                playerCoin = greenCoin;
                break;
            case "Yellow":
                yellowCoin.SetActive(true);
                playerCoin = yellowCoin;
                break;
        }

        switch (ConnectionManager.opponent.playerChoice)
        {
            case "Red":
                redCoin.SetActive(true);
                opponentCoin = redCoin;
                break;
            case "Blue":
                blueCoin.SetActive(true);
                opponentCoin = blueCoin;
                break;
            case "Green":
                greenCoin.SetActive(true);
                opponentCoin = greenCoin;
                break;
            case "Yellow":
                yellowCoin.SetActive(true);
                opponentCoin = yellowCoin;
                break;
        }

        gameObject.transform.GetChild(6).gameObject.SetActive(false);

        snakeLadderRunning = true;
        ConnectionManager.player.playerPlaying = true;

        EventManager.current.ToggleRollBtn(ConnectionManager.player.playerTurn);

        EventManager.current.SendData("Play Response", "Accepted");
    }

    void OnWinSnakeLadder()
    {
        OnQuitSnakeLadder();
    }

    void OnLooseSnakeLadder()
    {
        OnQuitSnakeLadder();
    }

    void OnQuitSnakeLadder()
    {
        snakeLadderRunning = false;
        GameManager.gameSelected = false;
        ConnectionManager.player.playerPlaying = false;
        Destroy(gameObject);
    }

    void OnRollDice()
    {
        diceVal = 0;
        dice.transform.localPosition = new Vector3(0.2f, 0.1f, -0.1f);
        diceRb.AddTorque(Random.Range(250, 500), Random.Range(250, 500), Random.Range(250, 500));
        diceRolled = true;
    }

    void OnUpdateOpponent()
    {
        if (ConnectionManager.opponent.playerVectors[0] != Vector3.zero) opponentCoin.transform.localPosition = ConnectionManager.opponent.playerVectors[0];
    }

    void OnTogglePlayerTurn(bool isTurn)
    {
        EventManager.current.ToggleRollBtn(isTurn);
    }

    void MoveCoin(int delta)
    {
        if (currentIndex + delta > 100) return;
        currentIndex += delta;
        ladderIdx = currentIndex;
        ConnectionManager.player.playerVectors[0] = playerCoin.transform.localPosition = snakeLadder.ContainsKey(currentIndex) ? ConvertIndexToCoord(currentIndex = snakeLadder[currentIndex]) : ConvertIndexToCoord(currentIndex);
        if (currentIndex == 100) EventManager.current.WinLooseGame(true);
    }

    Vector3 ConvertIndexToCoord(int index)
    {
        int z = (index - 1) / 10;
        int x = z % 2 == 0 ? (index - 1) % 10 : 9 - (index - 1) % 10;
        Vector3 newCoord = startPoint + new Vector3(x * 0.03f, 0f, z * 0.03f);
        return newCoord;
    }

    void OnDisable()
    {
        EventManager.current.gameStart -= OnStartSnakeLadder;
        EventManager.current.gameWin -= OnWinSnakeLadder;
        EventManager.current.gameLoose -= OnLooseSnakeLadder;
        EventManager.current.gameQuit -= OnQuitSnakeLadder;
        EventManager.current.opponentUpdate -= OnUpdateOpponent;
        EventManager.current.diceRoll -= OnRollDice;
        EventManager.current.playerTurnToggle -= OnTogglePlayerTurn;
    }
}