using UnityEngine;

public class CharacterControl : MonoBehaviour
{
    public static int charNo = 11;
    public static bool touchCharacter;
    public static GameObject opponentCharacter;

    [SerializeField] float rotatespeed;
    [SerializeField] GameObject nextButton;
    [SerializeField] GameObject prevButton;

    float touchPos;

    void Awake()
    {
        EventManager.current.characterPrev += OnCharcterPrev;
        EventManager.current.characterNext += OnCharcterNext;
        EventManager.current.opponentEnter += OnOpponentEnter;
        EventManager.current.opponentExit += OnOpponentExit;
    }

    void Update()
    {
        if (!ConnectionManager.player.playerReady && !UIManager.UITouch && Input.touchCount > 0)
        {
            Touch touch = Input.GetTouch(0);

            switch (touch.phase)
            {
                case TouchPhase.Began:
                    Ray raycast = Camera.main.ScreenPointToRay(Input.GetTouch(0).position);
                    RaycastHit raycastHit;
                    if (Physics.Raycast(raycast, out raycastHit) && raycastHit.collider.name == "Character") touchCharacter = true;
                    break;
                case TouchPhase.Moved:
                    if (touchCharacter && touchPos > touch.position.x) transform.Rotate(Vector3.up, rotatespeed); 
                    else if (touchCharacter && touchPos < touch.position.x) transform.Rotate(Vector3.up, -rotatespeed);
                    touchPos = touch.position.x;
                    break;
                case TouchPhase.Ended:
                    if (touchCharacter) touchCharacter = false;
                    break;
            }
        }
    }

    void OnCharcterPrev()
    {
        if (charNo == 23) nextButton.SetActive(true);

        gameObject.transform.GetChild(charNo).gameObject.SetActive(false);
        charNo--;
        gameObject.transform.GetChild(charNo).gameObject.SetActive(true);

        if (charNo == 0) prevButton.SetActive(false);
    }

    void OnCharcterNext()
    {
        if (charNo == 0) prevButton.SetActive(true);

        gameObject.transform.GetChild(charNo).gameObject.SetActive(false);
        charNo++;
        gameObject.transform.GetChild(charNo).gameObject.SetActive(true);

        if (charNo == 23) nextButton.SetActive(false);
    }

    void OnOpponentEnter()
    {
        if (ConnectionManager.player.playerCharNo == ConnectionManager.opponent.playerCharNo)
        {
            opponentCharacter = Instantiate(gameObject.transform.GetChild(charNo).gameObject);

            opponentCharacter.transform.localPosition += ConnectionManager.opponent.playerName == "Player 1" ? new Vector3(-1, 0.9f, 0) : new Vector3(1, 0.9f, 0);
            opponentCharacter.transform.eulerAngles += ConnectionManager.opponent.playerName == "Player 1" ? new Vector3(0, 90, 0) : new Vector3(0, -90, 0);
        }
        else
        {
            opponentCharacter = gameObject.transform.GetChild(ConnectionManager.opponent.playerCharNo).gameObject;

            opponentCharacter.SetActive(true);
            opponentCharacter.transform.localPosition += new Vector3(0, 0, 2);
            opponentCharacter.transform.eulerAngles += new Vector3(0, 180, 0);
        }
    }

    void OnOpponentExit()
    {
        if (ConnectionManager.player.playerCharNo == ConnectionManager.opponent.playerCharNo)
        {
            Destroy(opponentCharacter);
        }
        else
        {
            opponentCharacter.transform.eulerAngles -= new Vector3(0, 180, 0);
            opponentCharacter.transform.localPosition -= new Vector3(0, 0, 2);
            opponentCharacter.SetActive(false);
        }
    }

    void OnDisable()
    {
        EventManager.current.characterPrev -= OnCharcterPrev;
        EventManager.current.characterNext -= OnCharcterNext;
        EventManager.current.opponentEnter -= OnOpponentEnter;
        EventManager.current.opponentExit -= OnOpponentExit;
    }
}
