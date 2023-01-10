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
            // �÷��̾ ã�� Ÿ������ �ϰ� �ʹ�.
            GameObject target = GameObject.Find("Player");
            // ������ ���ϰ� �ʹ� Ÿ��������
            dir = target.transform.position - transform.position;
            // ������ ũ�⸦ 1�� �ϰ� �ʹ�.
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
        // �� �װ�
        Destroy(other.gameObject);
        // �� ����
        Destroy(gameObject);
    }
}
