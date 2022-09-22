using System.Collections;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;
#if PLATFORM_ANDROID
using UnityEngine.Android;
#endif

/**
 * Class <c>WorldSelector</c> is used in Main Scene to enter Virtual and Real World Scene.
 */
public class WorldSelector : MonoBehaviour
{
    [SerializeField] GameObject loadingScreen;
    [SerializeField] Slider slider;
    [SerializeField] Text percentageText;

    void Awake()
    {
#if PLATFORM_ANDROID
        if (!Permission.HasUserAuthorizedPermission(Permission.Camera)) Permission.RequestUserPermission(Permission.Camera); // Check and Ask for Camera Permission.
#endif
    }

    void Start()
    { 
        if (!Permission.HasUserAuthorizedPermission(Permission.Camera)) Application.Quit(); // Quit Application if permission denied.
    }

    /**
     * Loads Virtual or Real World Scene Asynchronously.
     * 
     * @param {int} sceneIndex
     * 
     */
    public void LoadLevel(int sceneIndex)
    {
        StartCoroutine(LoadAsynchronously(sceneIndex)); // Start Coroutine to load Virtual or Real World Scene and unload Main Scene at the same time without destroying loading screen.
    }

    IEnumerator LoadAsynchronously(int sceneIndex)
    {
        AsyncOperation operation = SceneManager.LoadSceneAsync(sceneIndex); // Load the Scene Asynchronously.

        loadingScreen.SetActive(true); // Enable loading screen.

        //
        // Display progress using While loop to capture progress and adjust the slider value in progress bar until loading is complete.
        // 
        while (!operation.isDone)
        {
            float progress = Mathf.Clamp01(operation.progress / 0.9f);
            slider.value = progress;
            percentageText.text = Mathf.Round(progress * 100) + "%";
            yield return null;
        }

        loadingScreen.SetActive(false); // Disable loading screen.
    }
}
