using UnityEngine;
using UnityEngine.EventSystems;

public class BlueCoin : LudoCoin, IPointerDownHandler
{
    Vector3 originalPos;

    void OnEnable()
    {
        EventManager.current.opponentUpdate += UpdateOpponent;
        LudoManager.coinMovableToggle += OnToggleBlueMovement;
        LudoManager.threeSixes += OnBlueThreeSixes;

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

    void OnToggleBlueMovement(bool isMovable)
    {
        ToggleMovement(isMovable, originalPos);
    }

    void OnBlueThreeSixes()
    {
        ReverseSix();
    }

    void OnDisable()
    {
        EventManager.current.opponentUpdate -= UpdateOpponent;
        LudoManager.coinMovableToggle -= OnToggleBlueMovement;
        LudoManager.threeSixes -= OnBlueThreeSixes;
    }
}