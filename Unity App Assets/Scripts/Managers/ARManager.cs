using System.Collections.Generic;
using UnityEngine;
using UnityEngine.XR.ARFoundation;
using UnityEngine.XR.ARSubsystems;

public class ARManager : MonoBehaviour
{
    public static bool placed;

    static List<ARRaycastHit> hits = new List<ARRaycastHit>();

    [SerializeField] ARPlaneManager aRPlaneManager;
    [SerializeField] ARRaycastManager aRRaycastManager;

    EventManager eventManager;

    void Awake()
    {
        eventManager = GetComponent<EventManager>();

        eventManager.arGamesAnchor += OnGamesAnchor;
        eventManager.arGamesLoose += OnGamesLoose;
        eventManager.gameWin += OnGameWin;
        eventManager.gameLoose += OnGameLoose;
        eventManager.gameQuit += OnGameQuit;
    }

    void Update()
    {
        if (GameManager.games == null && !GameManager.gameSelected)
        {
            foreach (var plane in aRPlaneManager.trackables)
            {
                eventManager.SpawnARGames(plane.center);
                return;
            }
        }
        else
        {
            if (!UIManager.UITouch && !placed && Input.touchCount == 1)
            {
                var touch = Input.GetTouch(0);
                if (touch.phase == TouchPhase.Moved || touch.phase == TouchPhase.Stationary || touch.phase == TouchPhase.Ended)
                {
                    if (aRRaycastManager.Raycast(touch.position, hits, TrackableType.PlaneWithinPolygon))
                    {
                        var hitPose = hits[0].pose;

                        GameManager.games.transform.position = hitPose.position;
                        GameManager.games.transform.rotation = hitPose.rotation;
                    }
                }
            }
        }
    }

    void OnGamesAnchor()
    {
        placed = true;
        ConnectionManager.player.playerReady = true;
        eventManager.SendData("Place Games", "Games Aligned");
    }

    void OnGamesLoose()
    {
        placed = false;
        ConnectionManager.player.playerReady = false;
        eventManager.SendData("Place Games", "Games Not Aligned");
    }

    void OnGameWin()
    {
        OnGameQuit();
    }

    void OnGameLoose()
    {
        OnGameQuit();
    }

    void OnGameQuit()
    {
        placed = false;
    }

    void OnDisable()
    {
        eventManager.arGamesAnchor -= OnGamesAnchor;
        eventManager.arGamesLoose -= OnGamesLoose;
        eventManager.gameWin -= OnGameWin;
        eventManager.gameLoose -= OnGameLoose;
        eventManager.gameQuit -= OnGameQuit;
    }
}