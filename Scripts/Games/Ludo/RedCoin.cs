using UnityEngine;
using UnityEngine.EventSystems;

public class RedCoin : LudoCoin, IPointerDownHandler
{
    Vector3 originalPos;

    void OnEnable()
    {
        EventManager.current.opponentUpdate += UpdateOpponent;
        LudoManager.coinMovableToggle += OnToggleRedMovement;
        LudoManager.threeSixes += OnRedThreeSixes;

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

    void OnToggleRedMovement(bool isMovable)
    {
        ToggleMovement(isMovable, originalPos);
    }

    void OnRedThreeSixes()
    {
        ReverseSix();
    }

    void OnDisable()
    {
        EventManager.current.opponentUpdate -= UpdateOpponent;
        LudoManager.coinMovableToggle -= OnToggleRedMovement;
        LudoManager.threeSixes -= OnRedThreeSixes;
    }
}
