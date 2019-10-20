using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Swapper : MonoBehaviour
{

    // Start is called before the first frame update
    void Start()
    {
        StartCoroutine(ExecuteAfterTime(100));
    }

    // Update is called once per frame
    void Update()
    {


    }
    IEnumerator ExecuteAfterTime(float time)
    {
        yield return new WaitForSeconds(time);

        // Code to execute after the delay
        SwapPlantsWithFruits();
       

    }

    private void SwapPlantsWithFruits()
    {
        GameObject[] plants = GameObject.FindGameObjectsWithTag("Plants");
        GameObject[] fruits = GameObject.FindGameObjectsWithTag("Fruits");
        for(int i = 0; i<fruits.Length; i++)
        {
            fruits[i].SetActive(true);
            fruits[i].transform.position = new Vector3(plants[i].transform.position.x,plants[i].transform.position.y + 0.3f,plants[i].transform.position.z);
            fruits[i].transform.rotation = Quaternion.identity;

            Destroy(plants[i]);
        }
    }

    private void SwapFruitsWithPlants()
    {
        //GameObject[] plants = GameObject.FindGameObjectsWithTag("Plants");
        //GameObject[] fruits = GameObject.FindGameObjectsWithTag("Fruits");
        //for (int i = 0; i < plants.Length; i++)
        //{
        //    Instantiate(plants[i], fruits[i].transform);
        //    Destroy(fruits[i]);
        //}

    }
}
