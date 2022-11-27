package member;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

public class ultraVioletAPI {
public HashMap<String, String> ultra = new HashMap<String, String>();

	
	// 일별 박스오피스 요청 함수
    public HashMap<String, String> RequestUltraViolet() throws IOException {
    	LocalDate nowDate = LocalDate.now();
    	String year=Integer.toString(nowDate.getYear());
    	String month;
    	if(nowDate.getMonthValue()<10) {
    		month="0"+Integer.toString(nowDate.getMonthValue());
    	}else {
    		month=Integer.toString(nowDate.getMonthValue());
    	}
    	String day;
    	if(nowDate.getDayOfMonth()-1<10) {
    		day="0"+Integer.toString(nowDate.getDayOfMonth()-1);
    	}else {
    		day=Integer.toString(nowDate.getDayOfMonth()-1);
    	}
    	String today=year+month+day+"18";
    	
    	String AnimalURL = "http://apis.data.go.kr/1360000/LivingWthrIdxServiceV2/getUVIdxV2"; /* 요청 주소  */
    	String page = "1";
    	String perPage = "10";
    	String apiKey = "x6pwOGjXBy0n3qkviXJtMtsAimz4Txno2f5W2KnH%2BbxeVmQuvx%2B4RIoCkVYyjg8gt5nP6hS4ew%2BKpnRHRvocOQ%3D%3D"; /*인증키 */
    	String areaNo="1100000000";
    	
    	// StringBuilder는 String에 String을 더할 때 연산을 조금 더 빠르게 해줄 수 있는 객체임
        StringBuilder urlBuilder = new StringBuilder(AnimalURL); /* 요청 주소 */
        
        // 기존 주소에 append 함수로 파라미터 추가
        urlBuilder.append("?" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode(page, "UTF-8")); /* 인증 키 */
        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode(perPage, "UTF-8")); /* 공공데이터포털에서 받은 인증키 */
        urlBuilder.append("&" + URLEncoder.encode("dataType","UTF-8") + "=" + URLEncoder.encode("JSON", "UTF-8")); /* 공공데이터포털에서 받은 인증키 */
        urlBuilder.append("&" + URLEncoder.encode("serviceKey","UTF-8") + "=" + apiKey); /* 공공데이터포털에서 받은 인증키 */
        urlBuilder.append("&" + URLEncoder.encode("areaNo","UTF-8") + "=" + areaNo);
        urlBuilder.append("&" + URLEncoder.encode("time", "UTF-8") + "=" + today);
        // 기존 주소에 모든 파라미터를 합쳤으면 주소 형태의 객체로 바꿔준다.
        URL url = new URL(urlBuilder.toString());
        
        //System.out.println(urlBuilder.toString());
        // URL 주소로 연결을 활성화 시킨다
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        
        // 방식은 GET 방식
        conn.setRequestMethod("GET");
        
        BufferedReader rd;
        // 만약 서버가 정상적으로 데이터를 받았으면 rd라는 버퍼에 응답한 결과 값을 담는다
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } 
        // 실패했으면 rd라는 버퍼에 응답한 에러 결과 값을 담는다.
        else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }
        StringBuilder sb = new StringBuilder();
        String line;
        // 버퍼에 담은 값을 String 형태로 만들어준다.
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }
        
        // 버퍼 종료 
        rd.close();
        // URL 연결 종료
        conn.disconnect();
   
        // 응답 받은 결과 값을 body 변수에 저장
        String pBody = sb.toString();
        
        // 응답 받은 결과를 파싱하기(나누기)위해 JSON Parser객체 생성
        JSONParser parser = new JSONParser();
        try {
        	// 파서로 응답 받은 결과 body를 쪼개기
			JSONObject obj = (JSONObject)parser.parse(pBody);
			JSONObject response=(JSONObject)obj.get("response");

			JSONObject body=(JSONObject)response.get("body");
			JSONObject allData = (JSONObject)body.get("items");
			JSONArray data = (JSONArray)allData.get("item");
			
			// 배열을 돌면서
			for(int i=0;i<data.size();i++){
				JSONObject tmp = (JSONObject)data.get(0);//인덱스 번호로 접근해서 첫번째 부터 가져오기

				String value_today = (String)tmp.get("tomorrow");
				String value_tomorrow = (String)tmp.get("tomorrow");


				ultra.put("value_today", value_today);
				ultra.put("value_tomorrow", value_tomorrow);
			}
			
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        
        
		return ultra;
    }
}
