/**
 * freeboard_write 의 자바스크립트
 */
function trim(str){//자바스크립트에는 trim함수가없기때문에 직접만들어줌
	return str.replace(/^\s+|\s+$/g,"");//replace(/  /g," "); ->/ / 사이의 값을 " " 으로 교체한다!
			//g=>global 뜻 대소문자까지 구분
}

function check(){
	
	//alert(document.getElementByTagName("myText").value);
	//alert(document.msgwrite2.name.value);
	with(document.msgwrite){
		if(!trim(name.value)){
			alert("이름을 입력해주세요!!");
			name.focus();
			return false;
		}
	
		if(!trim(subject.value)){
			alert("제목을 입력해주세요!!");
			subject.focus();
			return false;
		}
		
		if(!trim(content.value)){
			alert("내용을 입력해주세요!!");
			content.focus();
			return false;
		}
		if(!trim(password.value)){
			alert("비밀번호를 입력해주세요!!");
			password.focus();
			return false;
		}
		
		document.msgwrite.submit();
	}
}