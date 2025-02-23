<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn"    uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<%-- <script src="${pageContext.request.contextPath}/resources/js/jquery-1.12.4.min.js"></script> --%>
	<!-- <script src="https://code.jquery.com/jquery-3.3.1.min.js"
		integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script> -->
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.3.1.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/common/com-function.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			
	    });
		
		$(function() {
			
		});
		
		//----------------------콜백-----------------------------
		//함수 전달 가능. 비동기 처리 내에서 순차적인 처리가 가능. 고차함수에 적용되는 개념
		function callbackFunc(a, b, c){
			
			console.log("--c : " + c);
			
			c(a,b); // 콜백
			
			//익명 화살표 콜백 함수 
			ex1(a, (name) => {
			  	console.log("Anonymous arrow function parameter : " + name);
			});
			
		}
		
		function conLogFunc(a,b){
			console.log("a : " + a + " || b : " + b);
		}
		
		function ex1(d,e){
			e(d);
		}
		
		///이런 함수들이 다 콜백함수다. 
		$(document).on('change', '#allCheck', function(e) {
			if($("#allCheck").is(":checked")){
				$("input[name=chk]").prop("checked", true);
			}else{
				$("input[name=chk]").prop("checked", false);
			}
			
		});
		
		
		//예시 numbers 배열의 각 요소에 대해 콜백 함수 실행 
		/*
		numbers.forEach(function (num) { 
		    doubled.push(num * 2); // 콜백 함수로 각 요소를 두 배로 곱해서 doubled 배열에 추가 
		});
		*/
		
		//---------------promise----------------------
		
		//promise 사용전 구조
		function promiseBeforeFunc(a, callback){
			var total = a;
			total = a+1;
			console.log("a : " + a);
			console.log("total : " + total);
			console.log("callBack : " + callback);
			
			if(callback){
				console.log("in callback");
				console.log("-------------")
				callback(total);
				console.log("------------------------------------------------");
			}
		}
		
		<!-- 화살표함수는 정상적으로 매개변수인 콜백함수로써 동작함 함수의 선언 이기때문에 콜백함수로써 동작함 -->
		function usePromiseBeforeFunc(){
			promiseBeforeFunc(0, (e)=>{
					promiseBeforeFunc(e,(abc)=>{
						console.log("----------total : " + abc);
					})
			});
			
		}
		
		/* 이건 그냥 일반 함수 호출이 되어버려서 promiseBeforeFunc()자체를 그냥 먼저 실행해버림. 
		그래서 부모 함수 내에서 매개변수를 콜백함수로 받지를 못하고 실행결과인 리턴값으로 받는 것. */
		function usePromiseBeforeFunc2(){
			var b=0;
			promiseBeforeFunc(b, 
					promiseBeforeFunc(b,(e)=>{
						console.log("----------total : " + e);
					})
				
			);
			
		}
		//-----------------
		
		//일반적인 promise 사용법 - promise factory function
		//promise를 만들고 resolv와 reject 경우에따라 로직 구성 후 넘길 파라미터 전달
		function promiseObjectFactory(){
			return new Promise((resolve,reject)=>{
				//비동기 작업 수행 - fetch
				//const data = fetch('서버로부터 요청할 URL');
				var data=100;
				console.log("init data : " + data);
				if(data){
					resolve(data); // 성공해서 데이터가 있으면
				}else{
					reject("error");// 실패한 경우
				}
			})
		}
		
		//promise 정적 메서드
		//이런식으로 비동기를 사용하지 않는  다른 함수나 이런곳에서 promise의 장점을 사용하고 싶은 경우에 사용할수도 있음
		//const p = promiseObjectFactory().resolve("aaa")
		//const p = Promise.reject(new Error('error'));
		//promise.all();
		//Promise.allSettled();
		
		//promise 사용
		//받은 파라미터를 than(ajax의 success), catch(ajax의 error), finally 에서 사용. 자바의 try catch구문과도 같다.
		function promiseAfterFunc(){
			
			/*promise 상태값 
			  pending - 아직 비동기 처리가 끝나지 않음
			  fullfield - 처리 성공 - ajax의 success
			  rejected - 처리 실패 - ajax의 error
			*/
			console.log(promiseObjectFactory());
			
			
			promiseObjectFactory()
		    .then((value) => { // 성공적으로 수행했을 때 실행될 코드
		    	value= value+100;
		    	console.log("Data1: ", value); // 위에서 return resolve(data)의 data값이 출력된다
		    	return value;
		    })
		    .then((a) => { 
		    	a= a+100;
		    	console.log("Data2: ", a); 
		    	return a;
		    })
		    .then(() => { //리턴을 안받아도 됨
		    	console.log("no return"); 
		    })
		    .catch((error) => { // 실패했을 때 실행될 코드
		     	console.error(error); // 위에서 return reject("Error")의 "Error"가 출력된다
		    })
		    .finally(() => { // 성공하든 실패하든 무조건 실행될 코드
		    	
		    });
		}
		
		// 직접 할당해도 됨.
		/*
		const myPromise = new Promise((resolve, reject) => {
			// 비동기 작업 수행
		    const data = fetch('서버로부터 요청할 URL');
		    if(data)
		    	resolve(data); // 만일 요청이 성공하여 데이터가 있다면
		    else
		    	reject("Error"); // 만일 요청이 실패하여 데이터가 없다면
		});
		
		myPromise.then ---
		*/
		
		//promise지옥을 좀더 간결하게 보여주는 async await. 비동기를 동기처럼 보이게 코드상으로만
		//위의 promiseAfterFunc와 같은 내용이지만 훨씬 간결하다.
		async function asyncAwaitFunc(){
			await promiseObjectFactory();
		}
		
		
		//-----------fetch--------------------
		
		function fetchFunc(){
			//첫번째 then에서 promise객체를 return해서 다음 then으로 보냄. 
			//response.json()과 response.text()를 사용해 응답을 얻었다면 다른코드는 사용불가.
			//fetch("https://jsonplaceholder.typicode.com/posts" /*, option*/)
			//  .then(res => res.text()) 
			//  .then(text =>console.log(text));

			fetch("<c:url value='/adminFileTest/adminFileList.do'/>")
			   .then(res => res.json()) 
			   .then(json111 =>{
				   console.log("--fetch json data");
				   console.log(json111);
				   
				   json111.forEach(function(data,idx){
					   console.log("-------------------------------------------------");
					   console.log("data.seq : " + data.seq);
					   console.log("data.real_file_name : " + data.real_file_name);
					   console.log("data.code_file_name : " + data.code_file_name);
				   });
				   
			   });
		}
		
	</script>
</head>
<body>

	ajaxMain<br><br>
	<div>
		<div id="ajaxMainDiv">
		
			<button type="button" onclick="callbackFunc('hello','world',conLogFunc)">callback</button>
			
			<!-- 이건 그냥 일반 함수 호출이 되어버려서 conLogFunc()자체를 그냥 먼저 실행해버림. 그리고 callbackFunc()이함수 내에서 매개변수 콜백함수로 받지를 못함 -->
			<!-- <button type="button" onclick="callbackFunc('hello','world',conLogFunc())">callback1</button> -->
			<!-- 화살표함수는 정상적으로 매개변수인 콜백함수로써 동작함. 함수 선언이기때문 -->
			<!-- <button type="button" onclick="callbackFunc('hello','world',(e)=>{console.log('22222')})">callback2</button> -->
			<!-- 일반 함수 선언도 정상적으로 매개변수인 콜백함수로써 동작함. -->
			<!-- <button type="button" onclick="callbackFunc('hello','world',function a(){console.log('1111')})">callback3</button> -->
			
			<button type="button" onclick="usePromiseBeforeFunc()">promise before</button>
			<button type="button" onclick="promiseAfterFunc()">promise after</button>
			<button type="button" onclick="asyncAwaitFunc()">async await</button>
			<button type="button" onclick="fetchFunc()">fetch</button>
		</div>
		
	</div>
	
</body>
</html>