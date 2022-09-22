using UnityEngine.EventSystems;

public class Horse : ChessPiece, IPointerDownHandler
{
    public void OnPointerDown(PointerEventData eventData)
    {
        if (ChessManager.chessRunning && ConnectionManager.player.playerTurn)
        {
            if (CancelPiece(false)) return;

            ChessManager.selectedPiece = gameObject.name;
            ChessManager.blockReset?.Invoke();
            MoveHorse();
            ChessManager.pieceSelect?.Invoke(gameObject.name);
        }

        if (!ConnectionManager.player.playerTurn) EventManager.current.DisplayToast("Please Wait for Your Turn");
    }
}