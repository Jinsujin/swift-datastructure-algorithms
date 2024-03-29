# 삽입 정렬(Insertion Sort)

> 처리되지 않은 데이터 중에서 가장 작은 데이터를 선택해 적절한 위치에 삽입한다.
> <br/>
> 선택 정렬보다 효율적으로 동작한다.

- 가장 앞의 원소는 정렬된 부분이라고 가정한다.
- 아직 정렬되지 않은 부분이 없어질 때까지 다음 처리를 반복한다.

<br/>
<br/>

## ⏳ 정렬 과정

정렬할 데이터를 준비 한다.

```
[5,2,4,6,1,3]
```

### Step 1

첫번째 데이터 `5` 는 이미 정렬되어 있다고 가정한다.

두번째 데이터인 `2`를 왼쪽에 있는 `5`와 비교해 어떤 위치로 들어갈 것인지 판단한다.

`5`의 왼쪽으로 삽입할지, 오른쪽으로 삽입할 지 두 가지 경우만 존재한다.

```
[ ✓ 5 ✓ ]
```

두번째 데이터 `2` 는 `5` 보다 작으므로, 왼쪽에 끼워넣고 그 결과 다음과 같다:

```
[*2*,*5*,4,6,1,3]
```

### Step 2

`[2,5,4,6,1,3]` 중 현재 데이터 `4`가 어느 위치로 들어갈 것인지 판단한다.

`4` 가 들어갈 수 있는 위치는 3군데 이다:

```
[ ✓ 2 ✓ 5 ✓ ]
```

`4`와 `4`의 왼쪽에 있는 데이터 `5`을 비교해, 작다면 왼쪽 크다면 오른쪽으로 위치를 바꿔준다.

`4` 는 `5` 보다 작으므로 5의 왼쪽에 삽입한다.

### Step 3

현재까지 완료된 정렬은 다음과 같다:

```
[*2*,*4,*5*,6,1,3]
```

현재 선택된 `6` 은 왼쪽 데이터인 `5` 보다 크다.

`5` 의 오른쪽은 `6` 의 원래 위치므로, 그자리에 멈춰 있으면 된다.

### Step 4

현재까지 완료된 정렬은:

```
[*2*,*4*,*5*,*6*,1,3]
```

그 다음 순서인 `1` 을 고른다.

`1` 이 들어갈 수 있는 위치는 다음과 같다:

```
[ ✓ 2 ✓ 4 ✓ 5 ✓ 6 ✓ ]
```

`1` 은 `1` 의 왼쪽 방향으로 데이터를 하나씩 비교해 나간다.

매번 왼쪽의 원소와 위치를 바꿔나가며, `2` 의 왼쪽으로 자리할 수 있도록 한다.

정렬한 결과:

```
[*1*,*2*,*4*,*5*,*6*,3]
```

### Step 5

이 과정을 반복하면 정렬이 완료 된다:

```
[1,2,3,4,5,6]
```

<br/>
<br/>

## 🖍 결론

- 탐색범위 `i` 는 반복할때마다 줄어든다.
- 현재 원소와, 현재원소 앞의 원소들을 비교해 삽입될 위치를 찾아야 한다.

그러므로 2중 반복문을 사용해 구현할 수 있다.

<br/>
<br/>

## 🕰 시간 복잡도

선택정렬처럼 반복문이 두번 중첩되어 사용된다.

그러므로 시간 복잡도는 $`O(N^2)`$ 라고 할 수 있다.

(반복문안에서 단순히 swap 연산, 비교문만 있기 때문. 다른 연산이 들어가 있다면 추가)

- 현재 리스트의 데이터가 거의 정렬되어 있는 상태라면 빠르게 동작한다.
  - 최선의 경우 $O(N)$ 의 시간 복잡도를 가진다.
  - 이미 정렬되어 있는 상태라면, 각 원소가 들어갈 위치를 고르는 연산이 상수시간이 되기때문이다.

<br/>
<br/>

---

## 참고 자료

- [정렬 알고리즘-동빈나](https://youtu.be/KGyK-pNvWos)
- `책` 알고리즘과 자료구조 입문-프로그래밍 인사이트
