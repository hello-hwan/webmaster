/**
 * json.js
 * {name: "홍길동", age: 20} => js의 object
 * {"name": "홍길동", "age": 20} =>json object : 서버에서 데이터를 주고받기 편함
 * json 문자열 => 자바스크립트 객체(파싱) => json문자열.(함수)
 * 
 * 	<table class="table">
		<thead>
			<tr>
				<th>ID</th><th>firstName</th><th>lastName</th><th>Email</th><th>Salary</th><th>삭제</th>
			</tr>
		</thead>
		<tbody></tbody>

	</table>
 */

let obj = { name: "홍길동", age: 20 }
let json = JSON.stringify(obj); // object -> string
obj = JSON.parse(json); //string -> object

// JSP => 페이지 출력.

// JASON 데이터 => 페이지 작성.



// http://localhost/FreeBoard/javascript.do 여기서 MOCK_DATA.json을 찾아와야함 :최상위폴더:webapp
fetch('js/MOCK_DATA.json')// 불러오고싶은 파일 경로
.then(function(resolve){ //문자열을 자바스크립트의 obj타입으로 변환 (배열)
	console.log(resolve);
	return resolve.json();
})// then 메소드안에 정의된 함수 실행
.then(function(result){// 반환된 값을 변수 result로 저장
	console.log(result);
	makeList(result);
})

//obj = JSON.parse(data); // mockaroo에서 생성한 데이터

//console.log(obj);
//console.log(json);
//obj 배열에 들어있는 건수만큼 tr 생성하고 tbody 하위요소.
function makeList(obj=[]) {
	let fields = ['id', 'first_name', 'last_name', 'email', 'salary'];

	for (let i = 0; i < obj.length; i++) {
		let tr = document.createElement('tr');
		tr.addEventListener('mouseover', function(e) { tr.style.backgroundColor = 'gray' });
		tr.addEventListener('mouseout', function(e) { tr.style.backgroundColor = '' });
		for (let j = 0; j < fields.length; j++) {
			let td = document.createElement('td');
			td.innerText = obj[i][fields[j]]; // obj.name , obj['name']
			// obj[0]번에서 fields 배열의 첫번째 id 속성을 가지는 값을 출력
			tr.appendChild(td);
		}//end of for 2
		document.querySelector('#show tbody').appendChild(tr);
		//삭제 버튼 만들기
		let td = document.createElement('td'); //td 태그로 만들어짐
		let button = document.createElement('button'); //이미 button 태그로 만들어짐
		button.innerHTML = '삭제';
		tr.appendChild(td);
		td.appendChild(button); // <button />
		button.addEventListener("click", function(e) { button.parentElement.parentElement.remove() });
		//button.addEventListener("click", function(e) { this.parentElement.parentElement.remove() });
		document.querySelector("#show tbody").appendChild(tr);

	}//end of for 1
}//end of makeList

makeList();



