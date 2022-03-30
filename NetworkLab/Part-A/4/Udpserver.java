import java.util.*;
import java.net.*;
import java.io.*;
public class Udpserver {
	public static void main(String[] args) {
		DatagramSocket aSocket = null;
		Scanner scan = new Scanner(System.in);
		int Serverport = 7561;
		System.out.println("Server ready\n waiting for connection\n");
		try {
			aSocket = new DatagramSocket(Serverport);
			byte[] buffer = new byte[1000];
			byte[] buff = new byte[1000];
			DatagramPacket data1 = new DatagramPacket(buff,buff.length);
			aSocket.receive(data1);
			byte[] msg = new byte[1000];
			msg = data1.getData();
			System.out.println(new String(msg,0,data1.getLength()));
			System.out.println("\n Enter message to be sent: ");
			String str = scan.nextLine();
			buffer = str.getBytes();
			DatagramPacket data = new DatagramPacket(buffer,buffer.length,InetAddress.getLocalHost(),7560);
			aSocket.send(data);
		}
		catch(SocketException e) {
			System.out.println("socket" + e.getMessage());
		}
		catch(IOException o) {
			System.out.println("IO: " + o.getMessage());
		}
		finally{
			System.out.println("\n Message sent\n Connection terminated\n");
			if(aSocket!=null)
				aSocket.close();
			scan.close();
		}
	}
}