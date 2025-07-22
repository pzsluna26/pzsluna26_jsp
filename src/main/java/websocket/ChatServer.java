package websocket;

import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import jakarta.websocket.OnClose;
import jakarta.websocket.OnError;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;

import jakarta.websocket.server.ServerEndpoint;

@ServerEndpoint("/ChatingServer")
public class ChatServer {
	private static Set<Session> clients
		=Collections.synchronizedSet(new HashSet<Session>());
	
	//클라이언트 접속 시 실행
	@OnOpen
	public void onOpen(Session session) {
		clients.add(session); //세션추가
		System.out.println("웹소켓 연결:" + session.getId());
	}
	
	@OnMessage //메세지를 받으면 실행 
	public void onMessage(String message, Session session) throws IOException {
		System.out.println("메세지 전송: " + session.getId() + ":" + message);
		synchronized(clients) {
			for(Session client : clients) {
				if(!client.equals(session)) {
					client.getBasicRemote().sendText(message);
				}
			}
		}
	}
	
	@OnClose
	public void onClose(Session session) {
		clients.remove(session);
		System.out.println("웹 소켓 종료 : " + session.getId());
	}
	
	@OnError
	public void onError(Throwable e) {
		System.out.println("에러 발생");
		e.printStackTrace();
	}
}
