using UnityEngine;
using System;

public class EventManager : MonoBehaviour
{
    public static EventManager current;

    // Multi-Player Events
    public event Action<Tuple<string, string>> dataSend;
    public event Action<string> playerSelect;
    public event Action<bool> playerTurnToggle;
    public event Action<string> gameInvite;
    public event Action inviteAccept;
    public event Action inviteDecline;
    public event Action opponentUpdate;

    // Real World Events
    public event Action<Vector3> arGamesSpawn;
    public event Action arGamesAnchor;
    public event Action arGamesLoose;

    // Virtual World Events
    public event Action characterPrev;
    public event Action characterNext;
    public event Action characterSelect;
    public event Action characterUnselect;
    public event Action opponentEnter;
    public event Action opponentExit;

    // Game State Events
    public event Action<GameObject> gameSelect;
    public event Action gameUnselect;
    public event Action<string> sideChoose;
    public event Action gameStart;
    public event Action gameWin;
    public event Action gameLoose;
    public event Action gameQuit;

    // Carrom Events
    public event Action carromSync;
    public event Action<float> strikerAlign;
    public event Action<Tuple<bool, int>> carromScoreUpdate;

    // Ludo and Snake & Ladder Events
    public event Action diceRoll;

    // UI Events
    public event Action<bool> strikAlignToggle;
    public event Action<bool> rollBtnToggle;
    public event Action<string> dialogBox;
    public event Action<string> toastDisplay;

    // Audio Events
    public event Action clickSound;

    float firstTapTime;

    void Awake()
    {
        if (current == null) current = this;
        else Destroy(gameObject);

        DontDestroyOnLoad(gameObject);
    }

    // Multi-Player Event Methods //
    
    public void SendData(string type, string msg)
    {
        dataSend?.Invoke(new Tuple<string, string>(type, msg));
    }

    public void SelectPlayer(string name)
    {
        if (name != ConnectionManager.opponent.playerName) playerSelect?.Invoke(name);
        else
        {
            DisplayToast(name + " already in Use");
            dialogBox?.Invoke("Player Name");
        }
    }

    public void TogglePlayerTurn(bool isTurn)
    {
        playerTurnToggle?.Invoke(isTurn);
    }

    public void InviteGame(string gameName)
    {
        if (ConnectionManager.opponent.playerOnline)
        {
            if (ConnectionManager.opponent.playerReady) gameInvite?.Invoke(gameName.Replace("(Clone)", ""));
            else dialogBox?.Invoke("Opponent Not Ready");
        }
        else
        {
            dialogBox?.Invoke("Close Dialog");
            DisplayToast("Opponent Offline");
        }
    }

    public void AcceptDeclineInvite(bool accept)
    {
        if (accept) inviteAccept?.Invoke();
        else inviteDecline?.Invoke();
    }

    public void OpponentUpdate()
    {
        opponentUpdate?.Invoke();
    }

    // Real World Event Methods //

    public void SpawnARGames(Vector3 position)
    {
        arGamesSpawn?.Invoke(position);
    }

    public void AnchorLooseARGames(bool anchor)
    {
        if (anchor) arGamesAnchor?.Invoke();
        else arGamesLoose?.Invoke();
    }

    // Virtual World Event Methods //

    public void NextPrevCharacter(bool next)
    {
        if (next) characterNext?.Invoke();
        else characterPrev?.Invoke();
    }

    public void SelectUnselectCharacter(bool select)
    {
        if (select) characterSelect?.Invoke();
        else characterUnselect?.Invoke();
    }

    public void EnterExitOpponent(bool enter)
    {
        if (enter) opponentEnter?.Invoke();
        else opponentExit?.Invoke();
    }

    // Game State Event Methods //

    public void SelectUnselectGame(GameObject gamePrefab)
    {
        if (gamePrefab != null) gameSelect?.Invoke(gamePrefab);
        else gameUnselect?.Invoke();
    }

    public void ChooseGameSide(string side)
    {
        sideChoose?.Invoke(side);
    }

    public void StartQuitGame(bool start)
    {
        if (start)
        {
            if (ConnectionManager.opponent.playerOnline) gameStart?.Invoke();
            else DisplayToast("Opponent Offline");
        }
        else gameQuit?.Invoke();
    }

    public void WinLooseGame(bool win)
    {
        if (win) gameWin?.Invoke();
        else gameLoose?.Invoke();
    }

    // Carrom Event Methods //

    public void SyncCarrom()
    {
        carromSync?.Invoke();
    }

    public void AlignStriker(float value)
    {
        strikerAlign?.Invoke(value);
    }

    public void UpdateCarromScore(Tuple<bool, int> score)
    {
        carromScoreUpdate?.Invoke(score);
    }

    // Ludo and Snake & Ladder Event Methods //

    public void RollDice()
    {
        diceRoll?.Invoke();
    }

    // UI Event Methods //

    public void ToggleStrikAlign(bool isActive)
    {
        strikAlignToggle?.Invoke(isActive);
    }

    public void ToggleRollBtn(bool isActive)
    {
        rollBtnToggle?.Invoke(isActive);
    }

    public void DialogBox(string messageType)
    {
        dialogBox?.Invoke(messageType);
    }

    public void DisplayToast(string message)
    {
        toastDisplay?.Invoke(message);
    }

    // Audio Event Methods //

    public void SoundClick()
    {
        clickSound?.Invoke();
    }

    // App Methods //

    public void OnAppExit()
    {
        float secondTapTime = Time.time;

        if (secondTapTime > firstTapTime && secondTapTime - firstTapTime < 2) Application.Quit();
        else
        {
            firstTapTime = secondTapTime;
            DisplayToast("Press Again to Exit");
        }
    }
}
