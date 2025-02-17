/*
 * 공통 function
 */

//팝업 열기
function openPop(param) {
	document.getElementById("popup_layer"+param).style.display = "block";
}

//팝업 닫기
function closePop(param) {
	//$("#userpw-error").remove();
	//id에 error가 포함된 모든 태그 삭제
	$("[id*='error']").remove();
	$("[id*='user']").val("");
	document.getElementById("popup_layer"+param).style.display = "none";
	
}