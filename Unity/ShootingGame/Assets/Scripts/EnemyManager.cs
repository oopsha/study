using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyManager : MonoBehaviour {
    // 최소 시간
    float minTime = 1;
    // 최대 시간
    float maxTime = 5;
    // 현재 시간
    float currentTime;
    // 일정 시간
    public float createTime = 1;
    // 적 공장
    public GameObject enemyFactory;

    // Start is called before the first frame update
    void Start() {
        createTime = UnityEngine.Random.Range(minTime, maxTime);
    }

    // Update is called once per frame
    void Update() {
        currentTime += Time.deltaTime;

        if (currentTime > createTime) {
            GameObject enemy = Instantiate(enemyFactory);
            enemy.transform.position = transform.position;
            currentTime = 0;

            createTime = UnityEngine.Random.Range(minTime, maxTime);
        }
    }
}
