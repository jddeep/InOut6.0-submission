using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MakeItRain : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public void ToggleRain()
    {
        print("Active?"+gameObject.activeSelf);
        if (gameObject.activeSelf)
        {
            gameObject.SetActive(!gameObject.activeSelf);
        }
    }

}
