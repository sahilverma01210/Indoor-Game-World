using UnityEngine;

public class DiceSide : MonoBehaviour
{
    public int diceValue;

    void OnTriggerEnter(Collider collider)
    {
        if (collider.tag == "Board") LudoManager.diceVal = SnakeAndLadderManager.diceVal = diceValue;
    }
}
