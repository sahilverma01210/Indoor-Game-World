using UnityEngine;
using System.Collections;

public class AnimationManager : MonoBehaviour
{
    [SerializeField] GameObject character;
    [SerializeField] Animator PlayerCameraAnimator;

    Animator characterAnimator;
    Animator playerAnimator;
    Animator opponentAnimator;
    EventManager eventManager;

    void Awake()
    {
        eventManager = GetComponent<EventManager>();

        eventManager.characterSelect += OnCharcterSelect;
        eventManager.characterUnselect += OnCharacterUnselect;
        eventManager.opponentEnter += OnOpponentEnter;
        eventManager.opponentExit += OnOpponentExit;
        eventManager.gameWin += OnGameWin;
        eventManager.gameLoose += OnGameLoose;
        eventManager.gameQuit += OnGameQuit;

        characterAnimator = character.GetComponent<Animator>();
        playerAnimator = character.transform.GetChild(CharacterControl.charNo).gameObject.GetComponent<Animator>();

        Invoke("DisableAnimator", 1);
    }

    void OnCharcterSelect()
    {
        playerAnimator = character.transform.GetChild(CharacterControl.charNo).gameObject.GetComponent<Animator>();
        ConnectionManager.player.playerCharNo = CharacterControl.charNo;

        StartCoroutine(EnterAnimation());

        eventManager.SendData("Character Select", playerAnimator.name);
    }

    void OnCharacterUnselect()
    {
        eventManager.SendData("Character Unselect", playerAnimator.name);
        StartCoroutine(QuitAnimations());
    }

    void OnOpponentEnter()
    {
        opponentAnimator = CharacterControl.opponentCharacter.GetComponent<Animator>();
        opponentAnimator.Play("Sitting Idle");
        eventManager.SendData("Character Select", playerAnimator.name);
    }

    void OnOpponentExit()
    {
        if (ConnectionManager.player.playerCharNo == ConnectionManager.opponent.playerCharNo) opponentAnimator = null;
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
        StartCoroutine(QuitAnimations());
    }

    void SetAnimator(bool state)
    {
        characterAnimator.enabled = state;
        PlayerCameraAnimator.enabled = state;
    }

    void DisableAnimator()
    {
        PlayerCameraAnimator.enabled = false;
    }

    IEnumerator EnterAnimation()
    {
        SetAnimator(true);
        StartCoroutine(PlayerEnter());
        yield return new WaitForSeconds(0.6f);
        SetAnimator(false);
    }

    IEnumerator WinAnimations()
    {
        SetAnimator(true);
        StartCoroutine(PlayerWin());
        yield return new WaitForSeconds(2);
        SetAnimator(false);
    }

    IEnumerator QuitAnimations()
    {
        SetAnimator(true);
        StartCoroutine(PlayerExit());
        yield return new WaitForSeconds(0.6f);
        SetAnimator(false);
    }

    IEnumerator PlayerEnter()
    {
        characterAnimator.Play("Enter " + ConnectionManager.player.playerName);
        PlayerCameraAnimator.Play("Enter " + ConnectionManager.player.playerName + " Cam");
        yield return new WaitForSeconds(0.3f);
        playerAnimator.Play("Sitting Idle");
    }

    IEnumerator PlayerWin()
    {
        PlayerCameraAnimator.Play("Win " + ConnectionManager.player.playerName + " Cam");
        playerAnimator.Play("Sitting Cheering");
        yield return null;
    }

    IEnumerator PlayerExit()
    {
        playerAnimator.Play("Standing Idle");
        PlayerCameraAnimator.Play("Exit " + ConnectionManager.player.playerName + " Cam");
        characterAnimator.Play("Exit " + ConnectionManager.player.playerName);
        yield return null;
    }

    void OnDisable()
    {
        eventManager.characterSelect -= OnCharcterSelect;
        eventManager.characterUnselect -= OnCharacterUnselect;
        eventManager.opponentEnter -= OnOpponentEnter;
        eventManager.opponentExit -= OnOpponentExit;
        eventManager.gameWin -= OnGameWin;
        eventManager.gameLoose -= OnGameLoose;
        eventManager.gameQuit -= OnGameQuit;
    }
}
