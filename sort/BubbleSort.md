# 버블 정렬(Bubble Sort)

> 가장 앞에서 부터 인접한 두 요소를 비교하여, 큰 요소를 뒤로 보내는 것(swap)을 반복
> <br/>
> 선택 정렬보다 효율적으로 동작한다.

- 인접 요소를 매번 바꾸기 때문에, 가장 느린 알고리즘
- (선택정렬은 마지막에만 바꾼다)


<br/>
<br/>

## ⏳ 정렬 과정

정렬할 데이터를 준비 한다.

```
[5, 8, 0, 7]
```

### Step 1

```
[**0**, **8**, 5, 7]
```

배열의 처음부터 살펴보며 인접한 요소 `0(index: 0)`, `8(index: 1)` 을 비교한다.

둘중 작은 요소를 앞으로 보내지만, `0`, `8` 은 이미 정렬되어 있으므로 넘어간다.

### Step 2

```bash
[0, **8**, **5**, 7]
```

다음 요소인 `8`(index: 1), `5`(index: 2) 를 비교한다.

`5`가 더 작으므로 위치를 바꾼다. 

```swift
[0, **5**, **8**, 7]
```

### Step 3

```swift
[0, 5, **8**, **7**]
```

다음 요소인 `8`(index: 2), `7`(index: 3) 를 비교한다.

`7` 이 더 작으므로 위치를 바꾼다.

```swift
[0, 5, 7, 8]
```

이제 요소들중 가장 큰값인 `8`은 정렬이 완료되었다. 비교할 범위를 -1 줄인다.

⇒ [0, 5, 7] 만 정렬하면 된다.

### Step 4

```swift
[0, 5, 7| 8]
```

`0, 5` 와 `5, 7` 을 비교하는데  이미 정렬되어 있으므로 넘어간다.

비교 범위를 -1 줄인다.

### Step 5

```swift
[0, 5| 7, 8]
```

`0,5` 를 비교하는데 이미 정렬되어 있으므로 넘어간다. 

정렬이 완료되었다.

<br/>
<br/>

## 🖍 결론

- 탐색범위는 반복할때마다 줄어든다.
- 한번 반복할때마다 가장 큰값이 맨뒤로 이동한다. ⇒ 뒤에는 정렬되었으므로 한번 반복할때마다 범위가 1씩 줄어든다

그러므로 2중 반복문을 사용해 구현할 수 있다.

<br/>
<br/>

## 🕰 시간 복잡도

N 번 반복할때마다, 비교할 집합의 크기가 1씩 줄어든다.

N 이 10 이라면,

```
10 + 9 + 8 ... + 1
// 등차수열 형태
```

$N * (N + 1) / 2$ 로 표현할 수 있다.

빅오 표기법으로는 +1, /2 는 N 이 클때 의미가 없으므로 생략한다.

따라서 $O(N^2)$ 으로 나타낼 수 있다. (선택정렬, 삽입정렬과 같음)


<br/>
<br/>

---

## 참고 자료

- [정렬 알고리즘-동빈나](https://youtu.be/KGyK-pNvWos)
- `책` 알고리즘과 자료구조 입문-프로그래밍 인사이트