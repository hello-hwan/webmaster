/**
 * reply.js
 * replyService 생성했던 메소드 활용
 */

svc.rlist(147//bno
	, function(result) {//successFnc
		console.log(result);
		/*
		for (let i = 0; i < result.length; i++) {
			for (let prop in obj) {
				console.log(result[i][prop]);
			}
		}
		*/
	}, function(err) {//errorFnc
		console.log('요기', err);

	})