using UnityEngine;
using UnityEngine.EventSystems;
using TMPro;
using UnityEngine.UI;
using System;

public class UIManager : MonoBehaviour
{
    public static bool UITouch;

    // Panels
    [SerializeField] GameObject uIPanels;
    [SerializeField] GameObject gameSelectPanel;
    [SerializeField] GameObject gamePanel;
    [SerializeField] GameObject playPanel;
    [SerializeField] GameObject specialPanel;
    [SerializeField] GameObject dialogBoxPanel;

    // Buttons
    [SerializeField] GameObject playerNameButtons;
    [SerializeField] GameObject infoButtons;
    [SerializeField] GameObject inviteButtons;
    [SerializeField] GameObject pickChessSideButtons;
    [SerializeField] GameObject selectLudoHouseButtons;
    [SerializeField] GameObject selectSnakeLadderHouseButtons;
    [SerializeField] GameObject selectHouseButtons;
    [SerializeField] GameObject quitGameButtons;
    [SerializeField] GameObject rollButton;
    [SerializeField] GameObject placeARGamesButton;

    // UI Object
    [SerializeField] GameObject carromScoreBoard;
    [SerializeField] GameObject carromStrikSlider;

    // Text
    [SerializeField] TMP_Text resultText;
    [SerializeField] TMP_Text dialogMessage;
    [SerializeField] TMP_Text placeARGamesText;

    TMP_Text playerScore;
    TMP_Text opponentScore;
    Slider strikSlider;

    void Awake()
    {
        EventManager.current.arGamesSpawn += OnARGamesSpawn;
        EventManager.current.gameSelect += OnGameSelect;
        EventManager.current.gameStart += OnGameStart;
        EventManager.current.gameWin += OnGameWin;
        EventManager.current.gameLoose += OnGameLoose;
        EventManager.current.gameQuit += OnGameQuit;
        EventManager.current.carromScoreUpdate += OnCarromScoreUpdate;
        EventManager.current.strikAlignToggle += OnStrikAlignToggle;
        EventManager.current.rollBtnToggle += OnRollBtnToggle;
        EventManager.current.dialogBox += OnDialogBox;
        EventManager.current.toastDisplay += OnToastDisplay;

        Invoke("EnableDialogBox", 1.2f);
    }

    void Update()
    {
        foreach (Touch touch in Input.touches)
        {
            int id = touch.fingerId;

            if (touch.phase == TouchPhase.Began && EventSystem.current.IsPointerOverGameObject(id) && EventSystem.current.currentSelectedGameObject != null) UITouch = true;
            if (touch.phase == TouchPhase.Ended) UITouch = false;
        }
    }

    void OnARGamesSpawn(Vector3 position)
    {
        placeARGamesButton.SetActive(true);
        placeARGamesText.text = "Align Games on the Surface and press \"Done\"";
    }

    void OnGameSelect(GameObject gamePrefab)
    {
        gameSelectPanel.SetActive(false);
        gamePanel.SetActive(true);
        return;
    }

    void OnGameStart()
    {
        gamePanel.SetActive(false);
        playPanel.SetActive(true);

        switch (GameManager.spawnedGame.name.Replace("(Clone)", ""))
        {
            case "Ludo":
                OnRollBtnToggle(true);
                return;
            case "Snake & Ladder":
                OnRollBtnToggle(true);
                return;
            case "Carrom":
                carromScoreBoard.SetActive(true);
                playerScore = carromScoreBoard.transform.Find(ConnectionManager.player.playerName == "Player 1" ? "P1 Score" : "P2 Score").gameObject.GetComponent<TMP_Text>();
                opponentScore = carromScoreBoard.transform.Find(ConnectionManager.opponent.playerName == "Player 1" ? "P1 Score" : "P2 Score").gameObject.GetComponent<TMP_Text>();
                playerScore.text = opponentScore.text = "0";

                carromStrikSlider.SetActive(true);
                strikSlider = carromStrikSlider.GetComponent<Slider>();
                strikSlider.onValueChanged.AddListener(delegate { EventManager.current.AlignStriker(strikSlider.value); });
                strikSlider.value = 0;
                return;
        }
    }

    void OnGameWin()
    {
        OnGameQuit();
        playPanel.SetActive(false);
        uIPanels.SetActive(false);
        resultText.text = "You Win !!";
        specialPanel.SetActive(true);
    }

    void OnGameLoose()
    {
        OnGameQuit();
        playPanel.SetActive(false);
        uIPanels.SetActive(false);
        resultText.text = "You Loose !!";
        specialPanel.SetActive(true);
    }

    void OnGameQuit()
    {
        switch (GameManager.spawnedGame.name.Replace("(Clone)", ""))
        {
            case "Ludo":
                rollButton.SetActive(false);
                return;
            case "Snake & Ladder":
                rollButton.SetActive(false);
                return;
            case "Carrom":
                carromScoreBoard.SetActive(false);

                strikSlider.onValueChanged.RemoveAllListeners();
                carromStrikSlider.SetActive(false);
                return;
        }
    }

    void OnCarromScoreUpdate(Tuple<bool, int> carromScore)
    {
        if (playerScore == null || opponentScore == null) return;

        if (carromScore.Item1) playerScore.text = carromScore.Item2.ToString();
        else opponentScore.text = carromScore.Item2.ToString();
    }

    void OnStrikAlignToggle(bool isActive)
    {
        carromStrikSlider.SetActive(isActive);
    }

    void OnRollBtnToggle(bool isActive)
    {
        rollButton.SetActive(isActive);
    }

    void OnDialogBox(string messageType)
    {
        UITouch = true;
        uIPanels.SetActive(false);
        dialogBoxPanel.SetActive(true);

        switch (messageType)
        {
            case "Close Dialog":
                UITouch = false;
                uIPanels.SetActive(true);
                dialogBoxPanel.SetActive(false);
                return;
            case "Player Name":
                playerNameButtons.SetActive(true);
                dialogMessage.text = "Choose Player Name";
                return;
            case "Choose House":
                selectHouseButtons.SetActive(true);
                dialogMessage.text = "Choose House";
                switch (ConnectionManager.opponent.playerChoice)
                {
                    case "Red":
                        selectHouseButtons.transform.GetChild(0).gameObject.SetActive(false);
                        selectHouseButtons.transform.GetChild(1).gameObject.SetActive(true);
                        selectHouseButtons.transform.GetChild(2).gameObject.SetActive(true);
                        selectHouseButtons.transform.GetChild(3).gameObject.SetActive(true);
                        return;
                    case "Blue":
                        selectHouseButtons.transform.GetChild(0).gameObject.SetActive(true);
                        selectHouseButtons.transform.GetChild(1).gameObject.SetActive(false);
                        selectHouseButtons.transform.GetChild(2).gameObject.SetActive(true);
                        selectHouseButtons.transform.GetChild(3).gameObject.SetActive(true);
                        return;
                    case "Yellow":
                        selectHouseButtons.transform.GetChild(0).gameObject.SetActive(true);
                        selectHouseButtons.transform.GetChild(1).gameObject.SetActive(true);
                        selectHouseButtons.transform.GetChild(2).gameObject.SetActive(false);
                        selectHouseButtons.transform.GetChild(3).gameObject.SetActive(true);
                        return;
                    case "Green":
                        selectHouseButtons.transform.GetChild(0).gameObject.SetActive(true);
                        selectHouseButtons.transform.GetChild(1).gameObject.SetActive(true);
                        selectHouseButtons.transform.GetChild(2).gameObject.SetActive(true);
                        selectHouseButtons.transform.GetChild(3).gameObject.SetActive(false);
                        return;
                }
                return;
            case "Player Choice":
                switch (GameManager.spawnedGame.name.Replace("(Clone)", ""))
                {
                    case "Chess":
                        pickChessSideButtons.SetActive(true);
                        dialogMessage.text = "Pick a Side";
                        return;
                    case "Ludo":
                        selectLudoHouseButtons.SetActive(true);
                        dialogMessage.text = "Choose House";
                        return;
                    case "Snake & Ladder":
                        selectSnakeLadderHouseButtons.SetActive(true);
                        dialogMessage.text = "Choose House";
                        return;
                }
                return;
            case "Waiting":
                dialogMessage.text = "Request Sent \n Waiting for " + ConnectionManager.opponent.playerName + " to Join";
                return;
            case "Opponent Not Ready":
                infoButtons.SetActive(true);
                dialogMessage.text = "Opponent Not Ready";
                return;
            case "Play Request":
                inviteButtons.SetActive(true);
                dialogMessage.text = ConnectionManager.opponent.playerName + " wants to Play " + GameManager.requestedGame + " with You";
                return;
            case "Quit Game":
                quitGameButtons.SetActive(true);
                dialogMessage.text = "Are you Sure you want to Quit ?";
                return;
        }
    }

    void OnToastDisplay(string message)
    {
        AndroidJavaClass unityPlayer = new AndroidJavaClass("com.unity3d.player.UnityPlayer");
        AndroidJavaObject unityActivity = unityPlayer.GetStatic<AndroidJavaObject>("currentActivity");

        if (unityActivity != null)
        {
            AndroidJavaClass toastClass = new AndroidJavaClass("android.widget.Toast");
            unityActivity.Call("runOnUiThread", new AndroidJavaRunnable(() =>
            {
                AndroidJavaObject toastObject = toastClass.CallStatic<AndroidJavaObject>("makeText", unityActivity, message, 0);
                toastObject.Call("show");
            }));
        }
    }

    void EnableDialogBox()
    {
        dialogBoxPanel.SetActive(true);
    }

    void OnDisable()
    {
        EventManager.current.arGamesSpawn -= OnARGamesSpawn;
        EventManager.current.gameSelect -= OnGameSelect;
        EventManager.current.gameStart -= OnGameStart;
        EventManager.current.gameWin -= OnGameWin;
        EventManager.current.gameLoose -= OnGameLoose;
        EventManager.current.gameQuit -= OnGameQuit;
        EventManager.current.carromScoreUpdate -= OnCarromScoreUpdate;
        EventManager.current.strikAlignToggle -= OnStrikAlignToggle;
        EventManager.current.rollBtnToggle -= OnRollBtnToggle;
        EventManager.current.dialogBox -= OnDialogBox;
        EventManager.current.toastDisplay -= OnToastDisplay;
    }
}