using UnityEngine;
using UnityEngine.UI;

public class BackCamera : MonoBehaviour
{
    static WebCamTexture backCam;

    RawImage background;
    AspectRatioFitter fit;

    void Awake()
    {
        background = GetComponent<RawImage>();
        fit = GetComponent<AspectRatioFitter>();

        if (backCam == null) backCam = new WebCamTexture();
        background.texture = backCam;
        if (!backCam.isPlaying) backCam.Play();
    }

    void Update()
    {
        float ratio = (float)backCam.width / (float)backCam.height;
        fit.aspectRatio = ratio;
    }
}
