/** 
 * members.js
 * 
*/

// json 형태의 회원목록을 출력하는 데이터.
// "등록" 버튼에 이벤트 추가
document.querySelector('#addBtn').addEventListener('click', function(e) {
	let id = document.querySelector('#mid').value; //jsp의 id = "mid"
	let name = document.querySelector('#mname').value;
	let phone = document.querySelector('#mphone').value;

	fetch('addMemberJson.do?id=' + id + '&name=' + name + '&phone=' + phone)
		//.then(resolve => {return resolve.json()})
		.then(resolve => resolve.json())
		.then(result => {
			console.log(result)
			if (result.retCode == 'OK') {
				let tr = makeRow({ memberId: id, memberName: name, phone: phone });
				document.querySelector('#show tbody').appendChild(tr);
			} else if (result.retCode == 'FAIL') {
				alert('처리중 에러가 발생.');
			}
		})
		.catch(err => {
			console.log(err)
		})
})

//1.목록출력
fetch('memberJson.do')
	.then(resolve => { return resolve.json(); })
	.then(result => {
		console.log(result);
		makeList(result);
	})
	.catch(err => { console.log(err); })

function makeList(obj = []) {
	//작성.
	for (let i = 0; i < obj.length; i++) {
		let tr = makeRow(obj[i]);
		document.querySelector('#show tbody').appendChild(tr);
	}
	/*
	let fields = ['memberId', 'memberName', 'phone'];

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
		//삭제 버튼 만들기
		let td = document.createElement('td');
		let button = document.createElement('button');
		button.innerHTML = '삭제';
		tr.appendChild(td);
		td.appendChild(button);
		button.addEventListener("click", function(e) { button.parentElement.parentElement.remove() });
		*/

}//end of for 1

function makeRow(obj = {}) {
	let fields = ['memberId', 'memberName', 'phone'];

	let tr = document.createElement('tr');

	tr.setAttribute('data-id', obj.memberId);
	tr.addEventListener('mouseover', function(e) { tr.style.backgroundColor = 'gray' });
	tr.addEventListener('mouseout', function(e) { tr.style.backgroundColor = '' });
	for (let j = 0; j < fields.length; j++) {
		let td = document.createElement('td');
		td.innerText = obj[fields[j]]; // obj.name , obj['name']
		// obj[0]번에서 fields 배열의 첫번째 id 속성을 가지는 값을 출력
		tr.appendChild(td);
	}//end of for 2
	//삭제 버튼 만들기
	let td = document.createElement('td');
	let button = document.createElement('button');
	button.innerHTML = '삭제';
	tr.appendChild(td);
	td.appendChild(button);
	button.addEventListener("click", deleteRowFnc); //()하면 바로 실행이라서 넣으면 안됨
	return tr;
}

function deleteRowFnc(e) {
	//console.dir(e.target.parentElement.parentElement.firstElementChild.innerText);//firstChild는 노드까지 계산해야돼서 복잡해진다
	console.dir(e.target.parentElement.parentElement.dataset.id);//firstChild는 노드까지 계산해야돼서 복잡해진다
	let id = e.target.parentElement.parentElement.dataset.id;
	fetch('removeMemberJson.do?id=' + id)
		.then(resolve => resolve.json())
		.then(result => {
			if (result.retCode == "OK") {
				alert('성공.');
				e.target.parentElement.parentElement.remove();
			} else if (result.retCode == "FAIL"){
				alert('처리중 에러가 발생.');
			}
	})
		.catch(err => console.log(err))
}
