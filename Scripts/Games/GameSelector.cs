using UnityEngine;

/**
 * Class <c>GameSelector</c> component in Games Prefab is used to select one of the games which user wants to play.
 */
public class GameSelector : MonoBehaviour
{
    [SerializeField] GameObject chessPrefab;
    [SerializeField] GameObject carromPrefab;
    [SerializeField] GameObject ludoPrefab;
    [SerializeField] GameObject snakeAndLadderPrefab;

    /**
     * This method uses @param gameName to select and spawn desired game prefab.
     */
    public void TriggerSelect(string gameName)
    {
        if (GameManager.worldScene.name == "Real World Scene" && !ARManager.placed) return; // Return without selection if Games Prefab not Aligned.

        EventManager.current.SoundClick(); // Play Select Audio (Click Sound)

        //
        // Trigger gameSelect event using SelectUnselectGame() method in <c>EventManager</c> class to select desired game set using Switch statement.
        //
        switch (gameName)
        {
            case "Chess":
                EventManager.current.SelectUnselectGame(chessPrefab);
                return;
            case "Carrom":
                EventManager.current.SelectUnselectGame(carromPrefab);
                return;
            case "Ludo":
                EventManager.current.SelectUnselectGame(ludoPrefab);
                return;
            case "Snake & Ladder":
                EventManager.current.SelectUnselectGame(snakeAndLadderPrefab);
                return;
        }
    }
}
