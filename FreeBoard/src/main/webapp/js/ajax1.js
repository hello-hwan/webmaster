/**
 * ajax1.js //비 동기방식 처리
 * asynvhronous Javascript And Xml.
 */
//비동기방식 : 1초를 기다렸다가 function(){}을 처리
//setTimeout(func,1000)

//동기방식 : 1, 2, 3 순서대로 처리
/*
console.log("2");
console.log("3");
*/

let xhtp = new XMLHttpRequest(); //비동기방식처리 객체
xhtp.open('get', 'memberJson.do'); //서버상의 메소드 호출
xhtp.send(); //서버상의 resource 요청(호출).

let data = [];

xhtp.onload = function() { //시간이 조금 걸려서 2번보다 늦게처리돼서 늦게 나옴
	let obj = JSON.parse(xhtp.responseText);
	//console.log( xhtp.responseText );
	console.log(obj);
	data = obj;
	console.log('1', data);
	for (let i = 0; i < data.length; i++) {
		console.log(data[i]); //실행안되는건 데이터가 없어서 - 왜냐면 비동기라서 데이터가 들어가기전에실행되면 데이터 없음
	}
}

console.log('2', data); // 순서가 중요함 - 뒤에 있어도 먼저 처리됨






