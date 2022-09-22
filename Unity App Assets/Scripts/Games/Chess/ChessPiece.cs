using UnityEngine;

public class ChessPiece : MonoBehaviour
{
    int gridX;
    int gridY;
    bool moveUpRight = true;
    bool moveDownRight = true;
    bool moveUpLeft = true;
    bool moveDownLeft = true;
    bool moveMidRight = true;
    bool moveMidLeft = true;
    bool moveMidUp = true;
    bool moveMidDown = true;
    string blockName; 
    string blockColor;
    Vector3 initialPos;
    ChessGridBlock pieceBlock;
    Vector2Int upRight;
    Vector2Int downRight;
    Vector2Int upLeft;
    Vector2Int downLeft;
    Vector2Int midRight;
    Vector2Int midLeft;
    Vector2Int midUp;
    Vector2Int midDown;

    void Awake()
    {
        ChessManager.pieceMove += OnMovePiece;
        EventManager.current.opponentUpdate += OnUpdateOpponentPiece;
        initialPos = gameObject.transform.position;
    }

    protected bool CancelPiece(bool isKing)
    {
        if (ChessManager.grid[gridX, gridY, 1] != ConnectionManager.player.playerChoice[0])
        {
            if (ChessManager.optionsGrid[gridX, gridY] && ChessManager.selectedPiece != null)
            {
                ChessManager.pieceMove?.Invoke(new Vector2(gameObject.transform.position.x, gameObject.transform.position.z));
                ChessManager.pieceCancel?.Invoke(gameObject.name);
                gameObject.transform.position = initialPos;
                gameObject.SetActive(false);
                if (isKing) EventManager.current.WinLooseGame(true);
            }
            return true;
        }
        return false;
    }

    protected void MovePawn()
    {
        ChessManager.optionsGrid[gridX, gridY] = true;

        if (ChessManager.grid[gridX, gridY, 1] == 'W')
        {
            if (gridY + 1 < 8 && ChessManager.grid[gridX, gridY + 1, 0] == 'x') ChessManager.optionsGrid[gridX, gridY + 1] = true;
            if (gridX + 1 < 8 && gridY + 1 < 8 && ChessManager.grid[gridX + 1, gridY + 1, 0] != 'x') ChessManager.optionsGrid[gridX + 1, gridY + 1] = true;
            if (gridX - 1 > -1 && gridY + 1 < 8 && ChessManager.grid[gridX - 1, gridY + 1, 0] != 'x') ChessManager.optionsGrid[gridX - 1, gridY + 1] = true;
        }
        else
        {
            if (gridY - 1 > -1 && ChessManager.grid[gridX, gridY - 1, 0] == 'x') ChessManager.optionsGrid[gridX, gridY - 1] = true;
            if (gridX - 1 > -1 && gridY - 1 > -1 && ChessManager.grid[gridX - 1, gridY - 1, 0] != 'x') ChessManager.optionsGrid[gridX - 1, gridY - 1] = true;
            if (gridX + 1 < 8 && gridY - 1 > -1 && ChessManager.grid[gridX + 1, gridY - 1, 0] != 'x') ChessManager.optionsGrid[gridX + 1, gridY - 1] = true;
        }
    }

    protected void MoveHorse()
    {
        ChessManager.optionsGrid[gridX, gridY] = true;

        if (gridX + 1 < 8 && gridY + 2 < 8) ChessManager.optionsGrid[gridX + 1, gridY + 2] = true;
        if (gridX + 1 < 8 && gridY - 2 > -1) ChessManager.optionsGrid[gridX + 1, gridY - 2] = true;
        if (gridX + 2 < 8 && gridY + 1 < 8) ChessManager.optionsGrid[gridX + 2, gridY + 1] = true;
        if (gridX + 2 < 8 && gridY - 1 > -1) ChessManager.optionsGrid[gridX + 2, gridY - 1] = true;
        if (gridX - 1 > -1 && gridY + 2 < 8) ChessManager.optionsGrid[gridX - 1, gridY + 2] = true;
        if (gridX - 1 > -1 && gridY - 2 > -1) ChessManager.optionsGrid[gridX - 1, gridY - 2] = true;
        if (gridX - 2 > -1 && gridY + 1 < 8) ChessManager.optionsGrid[gridX - 2, gridY + 1] = true;
        if (gridX - 2 > -1 && gridY - 1 > -1) ChessManager.optionsGrid[gridX - 2, gridY - 1] = true;
    }

    protected void MoveDiagonally(int step, bool isKing)
    {
        if(!ChessManager.optionsGrid[gridX, gridY]) ChessManager.optionsGrid[gridX, gridY] = true;

        upRight = new Vector2Int(gridX + step, gridY + step);
        downRight = new Vector2Int(gridX + step, gridY - step);
        upLeft = new Vector2Int(gridX - step, gridY + step);
        downLeft = new Vector2Int(gridX - step, gridY - step);

        if ((moveUpRight || isKing) && upRight.x < 8 && upRight.y < 8)
        {
            ChessManager.optionsGrid[upRight.x, upRight.y] = true;
            moveUpRight = ChessManager.grid[upRight.x, upRight.y, 0] == 'x';
        }
        if ((moveDownRight || isKing) && downRight.x < 8 && downRight.y > -1)
        {
            ChessManager.optionsGrid[downRight.x, downRight.y] = true;
            moveDownRight = ChessManager.grid[downRight.x, downRight.y, 0] == 'x';
        }
        if ((moveUpLeft || isKing) && upLeft.x > -1 && upLeft.y < 8)
        {
            ChessManager.optionsGrid[upLeft.x, upLeft.y] = true;
            moveUpLeft = ChessManager.grid[upLeft.x, upLeft.y, 0] == 'x';
        }
        if ((moveDownLeft || isKing) && downLeft.x > -1 && downLeft.y > -1)
        {
            ChessManager.optionsGrid[downLeft.x, downLeft.y] = true;
            moveDownLeft = ChessManager.grid[downLeft.x, downLeft.y, 0] == 'x';
        }
    }

    protected void MoveAntiDiagonally(int step, bool isKing)
    {
        if (!ChessManager.optionsGrid[gridX, gridY]) ChessManager.optionsGrid[gridX, gridY] = true;

        midRight = new Vector2Int(gridX + step, gridY);
        midLeft = new Vector2Int(gridX - step, gridY);
        midUp = new Vector2Int(gridX, gridY + step);
        midDown = new Vector2Int(gridX, gridY - step);

        if ((moveMidRight || isKing) && midRight.x < 8)
        {
            ChessManager.optionsGrid[midRight.x, midRight.y] = true;
            moveMidRight = ChessManager.grid[midRight.x, midRight.y, 0] == 'x';
        }
        if ((moveMidLeft || isKing) && midLeft.x > -1)
        {
            ChessManager.optionsGrid[midLeft.x, midLeft.y] = true;
            moveMidLeft = ChessManager.grid[midLeft.x, midLeft.y, 0] == 'x';
        }
        if ((moveMidUp || isKing) && midUp.y < 8)
        {
            ChessManager.optionsGrid[midUp.x, midUp.y] = true;
            moveMidUp = ChessManager.grid[midUp.x, midUp.y, 0] == 'x';
        }
        if ((moveMidDown || isKing) && midDown.y > -1)
        {
            ChessManager.optionsGrid[midDown.x, midDown.y] = true;
            moveMidDown = ChessManager.grid[midDown.x, midDown.y, 0] == 'x';
        }
    }

    protected void ResetDiagonally()
    {
        moveUpRight = moveDownRight = moveUpLeft = moveDownLeft = true;
    }

    protected void ResetAntiDiagonally()
    {
        moveMidRight = moveMidLeft = moveMidUp = moveMidDown = true;
    }

    void OnMovePiece(Vector2 blockPosXZ)
    {
        if (gameObject.name == ChessManager.selectedPiece)
        {
            gameObject.transform.position = new Vector3(blockPosXZ.x, gameObject.transform.position.y, blockPosXZ.y);
            ChessManager.blockReset?.Invoke();
            ChessManager.selectedPiece = null;
            ConnectionManager.player.playerVectors[0] = gameObject.transform.position;
            ConnectionManager.player.playerMessage = gameObject.name;
            EventManager.current.TogglePlayerTurn(false);
        }
    }

    void OnUpdateOpponentPiece()
    {
        if (gameObject.name == ConnectionManager.opponent.playerMessage && ConnectionManager.opponent.playerVectors[0] != Vector3.zero) gameObject.transform.position = ConnectionManager.opponent.playerVectors[0];
    }

    void OnTriggerEnter(Collider collider)
    {
        pieceBlock = collider.gameObject.GetComponent<ChessGridBlock>();
        blockName = collider.gameObject.name;
        gridX = int.Parse(blockName[1].ToString());
        gridY = int.Parse(blockName[0].ToString());
        blockColor = blockName[2] == 'W' ? "White" : "Black";
    }

    void OnTriggerExit(Collider other)
    {
        pieceBlock = null;
        blockName = null;
        gridX = 0;
        gridY = 0;
        blockColor = null;
    }

    void OnDisable()
    {
        ChessManager.pieceMove -= OnMovePiece;
        EventManager.current.opponentUpdate -= OnUpdateOpponentPiece;
    }
}
