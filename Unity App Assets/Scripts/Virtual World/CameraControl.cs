using UnityEngine;

public class CameraControl : MonoBehaviour
{
    [SerializeField] Vector3 min;
    [SerializeField] Vector3 max;
    [SerializeField] Joystick joystick;

    float initialDistance;
    Vector3 initialPosition;

    void Awake()
    {
        EventManager.current.gameStart += OnGameStart;
    }

    void LateUpdate()
    {
        Vector3 direction = Vector3.left * joystick.Vertical + Vector3.up * joystick.Horizontal;
        Vector3 rotation = gameObject.transform.eulerAngles + direction;
        if (rotation.x < 90 || rotation.x > 270) gameObject.transform.eulerAngles = new Vector3(rotation.x, rotation.y, 0);
    }

    void OnGameStart()
    {
        string gameSelected = GameManager.spawnedGame.name.Replace("(Clone)", "");

        if (gameSelected != "Snake & Ladder")
        {
            gameObject.transform.position = new Vector3(ConnectionManager.player.playerName == "Player 1" ? -0.5f : 0.5f, 1.8f, 0);
            gameObject.transform.Rotate(5, 0, 0);
        }
    }

    void OnDisable()
    {
        EventManager.current.gameStart -= OnGameStart;
    }
}