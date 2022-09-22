using System.Collections.Generic;
using UnityEngine;
using System;

public class CarromNet : MonoBehaviour
{
    static int whiteCoinIndx;
    static int blackCoinIndx;
    static Queue<GameObject> whiteCoinsScored = new Queue<GameObject>();
    static Queue<GameObject> blackCoinsScored = new Queue<GameObject>();

    [SerializeField] GameObject coinsScored;

    GameObject colliderObj;

    void OnTriggerEnter(Collider collider)
    {        
        colliderObj = collider.gameObject;
        
        if (colliderObj.CompareTag("CarromStriker"))
        {
            /**
             * Did Not implemented the below code due to physics tweek requirements on friction b/w coins, striker and board
             * so that foul does not happens whenever a coin hits the net along with the striker
             */
            /*
            if (CarromManager.queenScore)
            {
                queenCoin.SetActive(true);
                CarromManager.queenScore = false;
            }

            if (blackCoinIndx != 0)
            {
                coinsScored.transform.Find("CB" + blackCoinIndx.ToString()).gameObject.SetActive(false);
                blackCoinsScored.Dequeue().SetActive(true);
                CarromManager.playerScore -= 10;
                blackCoinIndx--;
            }            
            else if (whiteCoinIndx != 0)
            {
                coinsScored.transform.Find("CW" + whiteCoinIndx.ToString()).gameObject.SetActive(false);
                whiteCoinsScored.Dequeue().SetActive(true);
                CarromManager.playerScore -= 20;
                whiteCoinIndx--;
            }
            else return;

            EventManager.current.UpdateCarromScore(new Tuple<bool, int>(true, CarromManager.playerScore));
            */
            CarromManager.strikerReset?.Invoke();
            CarromManager.strikerFoul = true;
        }
        
        if (colliderObj.CompareTag("CarromCoin"))
        {
            if (CarromManager.queenScore)
            {
                CarromManager.playerScore += 50;
                coinsScored.transform.Find("CQ0").gameObject.SetActive(true);
                CarromManager.queenScore = false;
            }

            switch (colliderObj.name[5])
            {
                case 'Q':
                    CarromManager.queenScore = true;
                    break;
                case 'W':
                    whiteCoinIndx++;
                    CarromManager.playerScore += 20;
                    //whiteCoinsScored.Enqueue(colliderObj);
                    coinsScored.transform.Find("CW" + whiteCoinIndx.ToString()).gameObject.SetActive(true);
                    break;
                case 'B':
                    blackCoinIndx++;
                    CarromManager.playerScore += 10;
                    //blackCoinsScored.Enqueue(colliderObj);
                    coinsScored.transform.Find("CB" + blackCoinIndx.ToString()).gameObject.SetActive(true);
                    break;
            }

            EventManager.current.UpdateCarromScore(new Tuple<bool, int>(true, CarromManager.playerScore));
            colliderObj.transform.localPosition = new Vector3(0, 0.04f, 0);
            colliderObj.SetActive(false);
            CarromManager.playerScored = true;
        }        
    }
}
