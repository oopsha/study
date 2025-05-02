using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerFire : MonoBehaviour {
    // 총알을 생산할 공장
    public GameObject bulletFactory;
    // 총구
    public GameObject firePosition;

    // Start is called before the first frame update
    void Start() {

    }

    // Update is called once per frame
    void Update() {
        if (Input.GetButtonDown("Fire1")) {
            GameObject bullet = Instantiate(bulletFactory);

            bullet.transform.position = firePosition.transform.position;
        }
    }
}
