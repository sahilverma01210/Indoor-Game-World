using UnityEngine;
using System;

public class CarromManager : MonoBehaviour
{
    public static bool queenScore;
    public static bool strikerFoul;
    public static bool playerScored;
    public static bool coinsInMotion;
    public static bool carromRunning;
    public static int playerScore;
    public static int opponentScore;
    public static Action strikerReset;

    [SerializeField] float forceMagnitude = 3000;
    [SerializeField] GameObject striker;
    [SerializeField] GameObject opponentStriker;
    [SerializeField] GameObject strikPlate;
    [SerializeField] GameObject strikRange;
    [SerializeField] GameObject strikArrow;
    [SerializeField] GameObject strikAim;
    [SerializeField] GameObject strikPose;
    [SerializeField] GameObject queenCoin;

    int scaleFactor = 1;
    float strikRadius;
    float prevStrikAngle;
    float currentStrikAngle;
    bool strikerInMotion;
    bool oppStrikInMotion;
    Vector3 startPoint;
    Vector3 endPoint;
    Vector3 movingPoint;
    Vector3 targetPoint;
    Vector3 oppStartPos ;
    Vector3 strikerForce;
    Rigidbody strikerRig;
    Rigidbody oppStrikRig;
    LineRenderer strikerLine;
    Quaternion startRotation;
    BoxCollider strikPlateCollider;
    RaycastHit[] raycastHit = new RaycastHit[2];
    Ray[] ray = new Ray[2];

    void Awake()
    {
        EventManager.current.gameStart += OnStartCarrom;
        EventManager.current.gameWin += OnWinCarrom;
        EventManager.current.gameLoose += OnLooseCarrom;
        EventManager.current.gameQuit += OnQuitCarrom;
        EventManager.current.strikerAlign += OnAlignStriker;
        EventManager.current.carromSync += OnFireOpponentStriker;
        strikerReset += OnResetStriker;

        gameObject.transform.localScale *= scaleFactor;
        startPoint = striker.transform.position;
        startRotation = striker.transform.rotation;

        ConnectionManager.player.playerVectors.Clear();
        ConnectionManager.player.playerVectors.Add(Vector3.zero);
        ConnectionManager.player.playerVectors.Add(Vector3.zero);
        ConnectionManager.player.playerVectors.Add(Vector3.zero);

        strikerRig = striker.GetComponent<Rigidbody>();
        oppStrikRig = opponentStriker.GetComponent<Rigidbody>();
        strikerLine = strikAim.GetComponent<LineRenderer>();
        strikPlateCollider = strikPlate.GetComponent<BoxCollider>();
    }

    void FixedUpdate()
    {
        if (playerScore + opponentScore == 320)
        {
            if (playerScore > opponentScore) EventManager.current.WinLooseGame(true);
            else EventManager.current.WinLooseGame(false);
        }

        if (carromRunning && ConnectionManager.player.playerTurn)
        {
            if (strikerInMotion && strikerRig.velocity == new Vector3(0, 0, 0))
            {
                OnResetStriker();
                ToggleStrikerSetup(playerScored);
                EventManager.current.TogglePlayerTurn(playerScored);
                if (queenScore && (!playerScored || strikerFoul))
                {
                    queenCoin.SetActive(true);
                    queenScore = false;
                }
                strikerInMotion = playerScored = strikerFoul = false;
            }

            if (oppStrikInMotion && oppStrikRig.velocity == new Vector3(0, 0, 0))
            {
                opponentStriker.transform.localPosition = new Vector3(-oppStartPos.x, oppStartPos.y, -oppStartPos.z);
                ToggleStrikerSetup(true);
            }
        }
    }

    public void OnInviteCarrom()
    {
        EventManager.current.SoundClick();
        EventManager.current.InviteGame(gameObject.name);
    }

    public void OnStrikBegin()
    {
        EventManager.current.ToggleStrikAlign(false);
        strikRange.SetActive(true);
        strikArrow.SetActive(true);
        strikAim.SetActive(true);
        strikPose.SetActive(true);

        strikPose.transform.position = startPoint;
        strikerLine.positionCount = 2;
    }

    public void OnStrikAim()
    {
        ray[0] = Camera.main.ScreenPointToRay(Input.GetTouch(0).position);

        Physics.Raycast(ray[0], out raycastHit[0]);

        if (raycastHit[0].collider.name == "Strik Plate")
            movingPoint = new Vector3(raycastHit[0].point.x, startPoint.y, raycastHit[0].point.z);

        ray[1] = new Ray(startPoint, startPoint - movingPoint);

        Physics.Raycast(ray[1], out raycastHit[1]);

        GameObject raycastObj = raycastHit[1].collider.gameObject;

        if (raycastObj.CompareTag("CarromCoin") || raycastObj.CompareTag("CarromBorder") || raycastObj.CompareTag("CarromNet"))
            targetPoint = new Vector3(raycastHit[1].point.x, startPoint.y, raycastHit[1].point.z);

        strikerLine.SetPosition(0, movingPoint);
        strikerLine.SetPosition(1, targetPoint);

        strikPose.transform.position = movingPoint;

        strikRadius = Mathf.Sqrt((startPoint - movingPoint).sqrMagnitude) * 2;
        currentStrikAngle = Vector3.SignedAngle(transform.forward, targetPoint - startPoint, transform.up);

        strikRange.transform.localScale = new Vector3(strikRadius, strikRadius, strikRange.transform.localScale.z);
        strikRange.transform.Rotate(Vector3.back, currentStrikAngle - prevStrikAngle, Space.Self);

        prevStrikAngle = currentStrikAngle;
    }

    public void OnStrikFire()
    {
        endPoint = movingPoint;

        strikRange.SetActive(false);
        strikArrow.SetActive(false);
        strikAim.SetActive(false);
        strikPose.SetActive(false);

        strikerForce = (startPoint - endPoint) * forceMagnitude;

        ConnectionManager.player.playerVectors[0] = striker.transform.localPosition;
        ConnectionManager.player.playerVectors[1] = strikerForce;
        EventManager.current.SendData("Carrom Sync", "Fire Opponent");

        strikerRig.AddForce(strikerForce);
        Invoke("SetInMotion", 0.1f);
        strikPlateCollider.enabled = false;
    }

    void ToggleStrikerSetup(bool isTurn)
    {
        EventManager.current.ToggleStrikAlign(isTurn);
        strikPlateCollider.enabled = isTurn;
        striker.SetActive(isTurn);
        opponentStriker.SetActive(!isTurn);
        ConnectionManager.player.playerVectors[2] = new Vector3(playerScore, 0, 0);
    }

    void OnAlignStriker(float SliderValue)
    {
        striker.transform.localPosition = new Vector3(SliderValue * 0.18f, striker.transform.localPosition.y, striker.transform.localPosition.z);
        startPoint = striker.transform.position;
    }

    void OnResetStriker()
    {
        striker.transform.position = startPoint;
        striker.transform.rotation = startRotation;
    }

    void OnFireOpponentStriker()
    {
        oppStartPos = ConnectionManager.opponent.playerVectors[0];
        opponentStriker.transform.localPosition = new Vector3(-oppStartPos.x, oppStartPos.y, -oppStartPos.z);
        oppStrikRig.AddForce(ConnectionManager.opponent.playerVectors[1]);
        Invoke("SetInMotion", 0.1f);
    }

    void SetInMotion()
    {
        strikerInMotion = striker.activeSelf;
        oppStrikInMotion = opponentStriker.activeSelf;
    }

    void OnStartCarrom()
    {
        gameObject.transform.GetChild(5).gameObject.SetActive(false);
        strikPlate.SetActive(true);
        carromRunning = true;
        ConnectionManager.player.playerPlaying = true;
        playerScore = opponentScore = 0;

        ToggleStrikerSetup(ConnectionManager.player.playerTurn);

        EventManager.current.SendData("Play Response", "Accepted");
    }

    void OnWinCarrom()
    {
        OnQuitCarrom();
    }

    void OnLooseCarrom()
    {
        OnQuitCarrom();
    }

    void OnQuitCarrom()
    {
        carromRunning = false;
        GameManager.gameSelected = false;
        ConnectionManager.player.playerPlaying = false;
        Destroy(gameObject);
    }

    void OnDisable()
    {
        EventManager.current.gameStart -= OnStartCarrom;
        EventManager.current.gameWin -= OnWinCarrom;
        EventManager.current.gameLoose -= OnLooseCarrom;
        EventManager.current.gameQuit -= OnQuitCarrom;
        EventManager.current.strikerAlign -= OnAlignStriker;
        EventManager.current.carromSync -= OnFireOpponentStriker;
        strikerReset -= OnResetStriker;
    }
}