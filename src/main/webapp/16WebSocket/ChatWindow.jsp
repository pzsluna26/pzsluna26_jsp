<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>웹소켓 채팅</title>
<script>
	var webSocket = new WebSocket(
			"<%= application.getInitParameter("CHAT_ADDR")%>/ChatingServer");
	var chatWindow, chatMessage, chatId;
	
	//채팅창이 열리면 대화창, 메시지 입력창, 대화명 표시란으로 사용할 dom 객체 저장
	window.onload = function(){
		chatWindow = document.getElementById("chatWindow");
		chatMessage = document.getElementById("chatMessage");
		chatId = document.getElementById("chatId").value;
	}
	
	//메세지 전송
	function sendMessage(){
		//대화창에 표시
		chatWindow.innerHTML += "<div class='myMsg'>"+chatMessage.value + "</div>"
		webSocket.send(chatId + '|' + chatMessage.value); //서버로 전송
		chatMessage.value = ""; //메세지 입력창 내용 지우기
		chatWindow.scrollTop = chatWindow.scrollHeight; //대화창 스크롤
	}
	
	//서버와의 연결 종료
	function disconnect(){
		webSocket.close();
	}
	
	//엔터 키 입력 처리
	function enterKey(){
		if(window.event.keyCode == 13){ //13은 엔터 키의 코드값
			sendMessage();
		}
	}
	webSocket.onopen = function(event){
		chatWindow.innerHTML += "웹소켓 서버에 연결되었습니다. <br/>";
		
	}
	
	//에러 발생 시 실행
	webSocket.onerror = function(event){
		alert(event.data);
		chatWindow.innerHTML += "채팅 중 에러가 발생하였습니다. <br/>";
	}
	
	//메시지를 받았을 때 실행
	webSocket.onmessage = function(event){
		var message = event.data.split("|");
		var sender = message[0];
		var content = message[1];
		if(content != ""){
			if(content.match("/")){ //귓속말
				if(content.match(("/"+chatId))) {
				
				var temp = content.replace(("/"+chatId), "[귓속말] : ");
				chatWindow.innerHTML += "<div>" + sender + "" + temp +"</div>";
				}
			}
			else { //일반대화
				chatWindow.innerHTML += "<div>"+sender +":" +content + "</div>";
			}
		}
		chatWindow.scorllTop = chatWindow.scrollHeight;
	}
</script>
<style>
#chatWindow{border:1px solid black; width:270px; height:310px; overflow:scroll; padding:5px;}
#chatMessage{width: 236px; height:30px;}
#sendBtn{height:30px; position:relative; top:2px; left:-2px;}
#closeBtn{margin-bottom:3px; position:relative; top:2px; left:-2px;}
#chatId{width:158px; height:24px; border:1px solid #AAAAAA; background-color:#EEEEEE;}.myMsg{text-align:right;}
</style>
</head>
<body>
	대화명 : <input type="text" id="chatId" value="${param.chatId}" readonly />
	<button id="closeBtn" onclick="disconnect();">채팅 종료</button>
	<div id="chatWindow"></div>
	<div>
		<input type="text" id="chatMessage" onkeyup="enterKey();">
		<button id="sendBtn" onclick="sendMessage();">전송</button>
	</div>
</body>
</html>