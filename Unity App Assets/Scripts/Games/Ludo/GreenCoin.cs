using UnityEngine;
using UnityEngine.EventSystems;

public class GreenCoin : LudoCoin, IPointerDownHandler
{
    Vector3 originalPos;

    void OnEnable()
    {
        EventManager.current.opponentUpdate += UpdateOpponent;
        LudoManager.coinMovableToggle += OnToggleGreenMovement;
        LudoManager.threeSixes += OnGreenThreeSixes;

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

    void OnToggleGreenMovement(bool isMovable)
    {
        ToggleMovement(isMovable, originalPos);
    }

    void OnGreenThreeSixes()
    {
        ReverseSix();
    }

    void OnDisable()
    {
        EventManager.current.opponentUpdate -= UpdateOpponent;
        LudoManager.coinMovableToggle -= OnToggleGreenMovement;
        LudoManager.threeSixes -= OnGreenThreeSixes;
    }
}
