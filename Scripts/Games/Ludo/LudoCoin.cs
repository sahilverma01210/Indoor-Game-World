using UnityEngine;

public class LudoCoin : MonoBehaviour
{
    static int numBlueCoinsScored;

    [SerializeField] int index;
    [SerializeField] Transform startPoint;

    int initIdx;
    int sixInitIdx;
    int currentIdx;
    bool movable;
    bool initSix;
    string moveDir = "Fwd";
    Vector3 initPos;
    Vector3 sixInitPos;
    Vector3 fwdStep = new Vector3(0, 0, 0.02f);
    Vector3 bwdStep = new Vector3(0, 0, -0.02f);
    Vector3 leftStep = new Vector3(-0.02f, 0, 0);
    Vector3 rightStep = new Vector3(0.02f, 0, 0);

    protected void SelectCoin(Vector3 originalPos)
    {
        if (movable)
        {
            if (LudoManager.numOfSixes == 1)
            {
                sixInitPos = gameObject.transform.position;
                sixInitIdx = currentIdx;
                initSix = true;
            }

            if (gameObject.transform.position.Equals(originalPos)) gameObject.transform.position = startPoint.position;
            else
            {
                initPos = gameObject.transform.localPosition;
                initIdx = currentIdx;

                for (int step = 0; step < LudoManager.diceVal; step++)
                {
                    MoveCoin();
                    if (currentIdx == 5 || currentIdx == 19 || currentIdx == 33 || currentIdx == 47) MoveCoin();
                }

                if (currentIdx == 60)
                {
                    numBlueCoinsScored++;
                    LudoManager.numMovableCoins--;
                    if (numBlueCoinsScored == 4) EventManager.current.WinLooseGame(true);
                    gameObject.SetActive(false);
                }
                else if (currentIdx > 60)
                {
                    gameObject.transform.localPosition = initPos;
                    currentIdx = initIdx;
                }
            }

            LudoManager.coinMovableToggle?.Invoke(false);

            if (LudoManager.diceVal == 6 || currentIdx == 60)
            {
                EventManager.current.ToggleRollBtn(true);
                return;
            }

            ConnectionManager.player.playerVectors[index] = gameObject.transform.localPosition;
            EventManager.current.TogglePlayerTurn(false);
        }
    }

    protected void UpdateOpponentCoin()
    {
        if (gameObject.name[5] == ConnectionManager.opponent.playerChoice[0] && ConnectionManager.opponent.playerVectors[index] != Vector3.zero) gameObject.transform.localPosition = ConnectionManager.opponent.playerVectors[index];
    }

    protected void ToggleMovement(bool isMovable, Vector3 originalPos)
    {
        if (gameObject.name[5] == ConnectionManager.player.playerChoice[0] && !(gameObject.transform.position.Equals(originalPos) && LudoManager.diceVal != 6))
        {
            if (isMovable && currentIdx + LudoManager.diceVal > 60) return;

            movable = isMovable;
            gameObject.transform.GetChild(0).gameObject.SetActive(isMovable);
            LudoManager.numMovableCoins = isMovable ? +1 : -1;
        }
    }

    protected void ReverseSix()
    {
        if (initSix)
        {
            gameObject.transform.position = sixInitPos;
            currentIdx = sixInitIdx;
            initSix = false;
        }
    }

    void MoveCoin()
    {
        currentIdx++;

        moveDir = (currentIdx == 6 || currentIdx == 42 || currentIdx == 54) ? "Left" : moveDir;
        moveDir = (currentIdx == 12 || currentIdx == 20 || currentIdx == 55) ? "Fwd" : moveDir;
        moveDir = (currentIdx == 14 || currentIdx == 26 || currentIdx == 34) ? "Right" : moveDir;
        moveDir = (currentIdx == 28 || currentIdx == 40 || currentIdx == 48) ? "Bwd" : moveDir;

        switch (moveDir)
        {
            case "Fwd":
                gameObject.transform.localPosition += fwdStep;
                break;
            case "Bwd":
                gameObject.transform.localPosition += bwdStep;
                break;
            case "Left":
                gameObject.transform.localPosition += leftStep;
                break;
            case "Right":
                gameObject.transform.localPosition += rightStep;
                break;
        }
    }
}
