# 선택 정렬(Selection Sort)

> 처리되지 않은 데이터 중에서 가장 작은 데이터를 선택해
> <br/>
> (처리되지 않은 데이터의) 맨 앞에 있는 데이터와 바꾸는 것을 반복

<br/>
<br/>

## ⏳ 정렬 과정

정렬할 데이터를 준비 한다.

```
[5, 8, 0, 7]
```

### Step 1

처리하지 않은 데이터는 시작부터 끝까지가 된다`5,8,0,7`

이중 가장 작은 데이터인 `0` 을 선택해,

처리하지 않은 데이터의 가장 앞인 `5` 와 바꾼다.

```bash
[**0**, 8, 5, 7]
```

이제 0은 정렬이 수행되었으므로, 이제 처리하지 않은 데이터는 `8,5,7` 이다.

### Step 2

처리하지 않은 데이터들중 가장 작은 값을 고른다. ⇒ `5`

`5` 를 처리하지 않은 데이터 중에 가장 앞의 값 `8` 과 바꾼다.

```bash
[**0**, **5**, 8, 7]
```

### Step 3

다음으로 처리되지 않은 데이터 중 가장 작은 값을 고른다 ⇒ `7`

`7` 과 처리 안된 데이터중 가장 앞의 `8` 과 자리를 바꾼다.

```bash
[**0**, **5**, **7**, 8]
```

### Step 4

`8` 은 비교할 데이터가 없으므로, 이대로 종료한다

<br/>
<br/>

## 🖍 결론

- 탐색범위는 반복할때마다 줄어든다.
- 매번 정렬이 되지 않은 데이터들을 확인해서 가장 작은 데이터를 찾아야 한다 ⇒ 매번 선형탐색을 수행

그러므로 2중 반복문을 사용해 구현할 수 있다.

<br/>
<br/>

## 🕰 시간 복잡도

매번 N 번 만큼 가장 작은수를 찾아서 맨 앞으로(i번째) 보내야 한다.

전체 연산 횟수는 다음과 같다.

```
N + (N - 1) + (N - 2) + ... + 2
// 마지막은 표현 해 주지 않아도 되기때문에 + 2 까지 등차수열 형태로 연산횟수가 구성된다
```

등차수열 공식에 따라 $(N^2 + N - 2) / 2$ 로 표현할 수 있다.

빅오 표기법을 나타내면, 갯수에 해당하는 1/2 은 생략 되고 가장 차수가 높은 항만 고려한다.

따라서 $O(N^2)$ 라고 작성한다.

<br/>
<br/>

---

## 참고 자료

- [정렬 알고리즘-동빈나](https://youtu.be/KGyK-pNvWos)
- `책` 알고리즘과 자료구조 입문-프로그래밍 인사이트
