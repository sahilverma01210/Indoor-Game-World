using UnityEngine;
using System;

public class LudoManager : MonoBehaviour
{
    public static int diceVal;
    public static int numOfSixes;
    public static int numMovableCoins;
    public static bool ludoRunning;
    public static Action<bool> coinMovableToggle;
    public static Action threeSixes;

    [SerializeField] GameObject dice;
    [SerializeField] GameObject redCoins;
    [SerializeField] GameObject blueCoins;
    [SerializeField] GameObject yellowCoins;
    [SerializeField] GameObject greenCoins;

    bool diceRolled;
    bool firstSix;
    int scaleFactor = 3;
    Rigidbody diceRb;

    void Awake()
    {
        EventManager.current.gameStart += OnStartLudo;
        EventManager.current.gameWin += OnWinLudo;
        EventManager.current.gameLoose += OnLooseLudo;
        EventManager.current.gameQuit += OnQuitLudo;
        EventManager.current.diceRoll += OnRollDice;
        EventManager.current.playerTurnToggle += OnTogglePlayerTurn;
        gameObject.transform.localScale *= scaleFactor;

        ConnectionManager.player.playerVectors.Clear();
        ConnectionManager.player.playerVectors.Add(Vector3.zero);
        ConnectionManager.player.playerVectors.Add(Vector3.zero);
        ConnectionManager.player.playerVectors.Add(Vector3.zero);
        ConnectionManager.player.playerVectors.Add(Vector3.zero);
        diceRb = dice.GetComponent<Rigidbody>();
    }

    void FixedUpdate()
    {
        if (ludoRunning && ConnectionManager.player.playerTurn && diceRolled && diceRb.IsSleeping())
        {
            diceRolled = false;
            numMovableCoins = 0;

            if (!firstSix && diceVal != 6)
            {
                EventManager.current.TogglePlayerTurn(false);
                return;
            }
            else firstSix = true;

            EventManager.current.ToggleRollBtn(false);
            coinMovableToggle?.Invoke(true);

            numOfSixes = diceVal == 6 && numMovableCoins != 0 ? +1 : 0;

            if (numOfSixes == 3)
            {
                threeSixes?.Invoke();
                coinMovableToggle?.Invoke(false);
            }

            if (numMovableCoins == 0) EventManager.current.TogglePlayerTurn(false);
        }
    }

    public void OnInviteLudo()
    {
        EventManager.current.SoundClick();
        EventManager.current.DialogBox("Player Choice");
    }

    void OnRollDice()
    {
        diceVal = 0;
        dice.transform.localPosition = new Vector3(0, 0.1f, 0);
        diceRb.AddTorque(UnityEngine.Random.Range(250,500), UnityEngine.Random.Range(250, 500), UnityEngine.Random.Range(250, 500));
        diceRolled = true;
    }

    void OnTogglePlayerTurn(bool isTurn)
    {
        EventManager.current.ToggleRollBtn(isTurn);
    }

    void OnStartLudo()
    {
        if (ConnectionManager.player.playerChoice == "Blue" || ConnectionManager.player.playerChoice == "Yellow") gameObject.transform.eulerAngles += new Vector3(0, 180, 0);

        gameObject.transform.GetChild(6).gameObject.SetActive(false);

        redCoins.SetActive(false);
        blueCoins.SetActive(false);
        greenCoins.SetActive(false);
        yellowCoins.SetActive(false);

        switch (ConnectionManager.player.playerChoice)
        {
            case "Red":
                redCoins.SetActive(true);
                break;
            case "Blue":
                blueCoins.SetActive(true);
                break;
            case "Green":
                greenCoins.SetActive(true);
                break;
            case "Yellow":
                yellowCoins.SetActive(true);
                break;
        }

        switch (ConnectionManager.opponent.playerChoice)
        {
            case "Red":
                redCoins.SetActive(true);
                break;
            case "Blue":
                blueCoins.SetActive(true);
                break;
            case "Green":
                greenCoins.SetActive(true);
                break;
            case "Yellow":
                yellowCoins.SetActive(true);
                break;
        }

        ludoRunning = true;
        ConnectionManager.player.playerPlaying = true;

        EventManager.current.ToggleRollBtn(ConnectionManager.player.playerTurn);

        EventManager.current.SendData("Play Response", "Accepted");
    }

    void OnWinLudo()
    {
        OnQuitLudo();
    }

    void OnLooseLudo()
    {
        OnQuitLudo();
    }

    void OnQuitLudo()
    {
        ludoRunning = false;
        GameManager.gameSelected = false;
        ConnectionManager.player.playerPlaying = false;
        Destroy(gameObject);
    }

    void OnDisable()
    {
        EventManager.current.gameStart -= OnStartLudo;
        EventManager.current.gameWin -= OnWinLudo;
        EventManager.current.gameLoose -= OnLooseLudo;
        EventManager.current.gameQuit -= OnQuitLudo;
        EventManager.current.diceRoll -= OnRollDice;
        EventManager.current.playerTurnToggle -= OnTogglePlayerTurn;
    }
}