using System;
using System.Collections.Generic;
using UnityEngine;

[Serializable]
public class Player
{
    public string playerName;

    public int playerCharNo = -1;

    public bool playerOnline;

    public bool playerPlaying;

    public string playerMessageType;

    public string playerMessage;

    public string playerWorld;

    public bool playerReady;

    public string playerChoice;

    public bool playerTurn;

    public List<Vector3> playerVectors = new List<Vector3>();
}
