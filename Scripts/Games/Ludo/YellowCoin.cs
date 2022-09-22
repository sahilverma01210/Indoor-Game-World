using UnityEngine;
using UnityEngine.EventSystems;

public class YellowCoin : LudoCoin, IPointerDownHandler
{
    Vector3 originalPos;

    void OnEnable()
    {
        EventManager.current.opponentUpdate += UpdateOpponent;
        LudoManager.coinMovableToggle += OnToggleYellowMovement;
        LudoManager.threeSixes += OnYellowThreeSixes;

        originalPos = gameObject.transform.position;
    }

    public void OnPointerDown(PointerEventData eventData)
    {
        SelectCoin(originalPos);
    }

    void UpdateOpponent()
    {
        UpdateOpponentCoin();
    }

    void OnToggleYellowMovement(bool isMovable)
    {
        ToggleMovement(isMovable, originalPos);
    }

    void OnYellowThreeSixes()
    {
        ReverseSix();
    }

    void OnDisable()
    {
        EventManager.current.opponentUpdate -= UpdateOpponent;
        LudoManager.coinMovableToggle -= OnToggleYellowMovement;
        LudoManager.threeSixes -= OnYellowThreeSixes;
    }
}
