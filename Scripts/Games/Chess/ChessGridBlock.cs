using UnityEngine;
using UnityEngine.EventSystems;

public class ChessGridBlock : MonoBehaviour, IPointerDownHandler
{
    [SerializeField] Material selectBlockMat;
    [SerializeField] Material optionBlockMat;
    [SerializeField] Material opponentBlockMat;

    int gridX;
    int gridY;
    string blockName;
    string blockColor;
    string pieceName;
    Material initialMat;
    MeshRenderer blockRenderer;
    ChessPiece piece;

    void Awake()
    {
        ChessManager.pieceSelect += OnPieceSelect;
        ChessManager.blockReset += OnResetBlock;

        blockName = gameObject.name;
        gridX = int.Parse(blockName[1].ToString());
        gridY = int.Parse(blockName[0].ToString());
        blockColor = blockName[2] == 'W' ? "White" : "Black";
        blockRenderer = gameObject.GetComponent<MeshRenderer>();
        initialMat = blockRenderer.material;

    }

    public void OnPointerDown(PointerEventData eventData)
    {
        if (!ChessManager.chessRunning) return;
        if (ChessManager.optionsGrid[gridX, gridY]) ChessManager.pieceMove?.Invoke(new Vector2(gameObject.transform.position.x, gameObject.transform.position.z));
    }

    void OnPieceSelect(string selectedPiece)
    {
        if (ChessManager.optionsGrid[gridX, gridY])
        {
            // No Chess Piece on Block
            if (pieceName == null)
            {
                blockRenderer.material = optionBlockMat;
                return;
            }

            // Same Color Chess Pieces
            if (pieceName[1] == selectedPiece[1])
            {
                ChessManager.optionsGrid[gridX, gridY] = false;
                blockRenderer.material = pieceName == selectedPiece ? selectBlockMat : initialMat;
                return;
            }

            // Different Color Chess Pieces
            blockRenderer.material = opponentBlockMat;
            return;
        }

        blockRenderer.material = initialMat;
    }

    void OnResetBlock()
    {
        ChessManager.optionsGrid[gridX, gridY] = false;
        blockRenderer.material = initialMat;
    }

    void OnTriggerEnter(Collider collider)
    {
        piece = collider.gameObject.GetComponent<ChessPiece>();
        pieceName = collider.gameObject.name;

        ChessManager.grid[gridX, gridY, 0] = pieceName[0];
        ChessManager.grid[gridX, gridY, 1] = pieceName[1];
        ChessManager.grid[gridX, gridY, 2] = pieceName[2];

        //Debug.Log(gridX.ToString() + gridY.ToString() + " " + blockColor + " : " + ChessManager.grid[gridX, gridY, 0] + " " + ChessManager.grid[gridX, gridY, 1] + " " + ChessManager.grid[gridX, gridY, 2]);
    }

    void OnTriggerExit(Collider other)
    {
        pieceName = null;
        piece = null;

        ChessManager.grid[gridX, gridY, 0] = ChessManager.grid[gridX, gridY, 1] = ChessManager.grid[gridX, gridY, 2] = 'x';
    }

    void OnDisable()
    {
        ChessManager.pieceSelect -= OnPieceSelect;
        ChessManager.blockReset -= OnResetBlock;
    }
}