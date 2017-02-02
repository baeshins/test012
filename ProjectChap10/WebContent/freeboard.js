/**
 *  단원 10에 사용하는 javascript
 */
function trim(str) {
	return str.replace(/^\s*|\s*$/g,"");
}

function check() {
	alert(document.msgwrite.name.value);
	with (document.msgwrite) {
		
		if (!trim(name.value)) {
			alert("이름을 입력하시오!!");
		
			name.focus();
			return false;
		}
		if (!trim(subject.value)) {
			alert("제목을 입력하시오!!");
			subject.focus();
			return false;
		}
		if (!trim(content.value)) {
			alert("내용을 입력하시오!!");
			content.focus();
			return false;
		}
		if (!trim(password.value)) {
			alert("비밀번호를 입력하시오!!");
			password.focus();
			return false;
		}
		document.msgwrite.submit();
	}
}

function pwcheck(id,p){

	if(!trim(document.msgwrite.password.value)){
		alert("비밀번호를 입력해주세요!!");
		password.focus();
		return false;
	}
	
	if(confirm("정말로 삭제하시겠습니까?")){
		document.msgwrite.action="freeboard_delete.jsp?id="+id + "&page="+p;
		document.msgwrite.submit();
	}
}