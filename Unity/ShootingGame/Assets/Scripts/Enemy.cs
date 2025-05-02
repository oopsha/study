using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Enemy : MonoBehaviour {
    Vector3 dir;

    public float speed = 5;

    // Start is called before the first frame update
    void Start() {
        int randValue = UnityEngine.Random.Range(0, 10);

        if (randValue < 3) {
            // 플레이어를 찾아 타겟으로 하고 싶다.
            GameObject target = GameObject.Find("Player");
            // 방향을 구하고 싶다 타겟쪽으로
            dir = target.transform.position - transform.position;
            // 방향의 크기를 1로 하고 싶다.
            dir.Normalize();
        } else {
            dir = Vector3.down;
        }
    }

    // Update is called once per frame
    void Update() {
        transform.position += dir * speed * Time.deltaTime;
    }

    private void OnCollisionEnter(Collision other) {
        // 너 죽고
        Destroy(other.gameObject);
        // 나 죽자
        Destroy(gameObject);
    }
}
