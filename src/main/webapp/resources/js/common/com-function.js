/*
 * 공통 function
 */

//페이징 - 번호 버튼 클릭 시
function pageChange(page){
	searchPgFunc(page);
}

//페이징 - 이전 버튼 클릭 시
function beforePageBtnClick(){
	if($("#beforePageBtn").val() != 0){
		searchPgFunc($("#beforePageBtn").val());
	}else{
		alert("첫 번째 페이지 입니다.");
	}
}

//페이징 - 다음 버튼 클릭 시
function afterPageBtnClick(){
	if($("#afterPageBtn").val() != 0){
		searchPgFunc($("#afterPageBtn").val());
	}else{
		alert("마지막 페이지 입니다.");
	}
}


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