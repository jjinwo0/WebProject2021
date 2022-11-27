<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="member.*"%>
<%@ page import="bbs.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
    <title>Dogether</title>
    <style>
        * {
            font-family: 'Jua', sans-serif;
        }
        html{
            overflow-y: scroll;
        }
        body {
            margin:0px;
        }
        header {
            display:flex;
            align-items: center;
            justify-content: center;
            height:50px;
            margin-left: 50px;
        }

        .header_left {
            display: flex;
            width:30%;
            padding-left:10px;
            justify-content: center;
        }
        .header_middle {
            display:flex;
            justify-content: center;
            width:50%;
        }
        .header_right {
            width:20%;
            margin-right: 5%;
            align-items:center;
            justify-content: center;
        }

        .header_right > ul {
            margin:0px;
            padding:0px;
            display:flex;
            justify-content: center;
        }

        .header_right > ul > li {
            list-style: none;
            margin-left:10px;
            margin-right:10px;
        }
        .header_right > ul > li:hover {
            text-decoration: underline;
            text-decoration-style: wavy;
            border-bottom: 15px;
            text-decoration-color: rgb(245,186,59);
        }
        nav {
            height:60px;
            border-bottom-style:solid;
            border-bottom-width:1px;
            border-top-style: solid;
            border-top-width:1px;
        }

        nav > ul {
            margin:0px;
            padding:0px;
            height: 100%;
            display:flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            margin-left:200px;
            margin-right:200px;
        }
        nav > ul > li {
            list-style: none;
        }
        nav > ul > li:hover {
            text-decoration: underline;
            text-decoration-style: wavy;
            border-bottom: 15px;
            text-decoration-color: rgb(245,186,59);
        }
        table.table_t{
            width: 70%;
            margin: auto;
            margin-bottom: -px;
        }
        table.table1{
            width: 70%;
            margin: auto;
        }
        .table1 > thead > tr > th{
            background-color: rgb(218, 143, 45);
          text-align: center;
        }
        .table1 > tbody > tr{
            border-bottom: 1px solid #e5e5e5;
          text-align: center;
        }
        
        .table1 > tbody > tr:hover{
            background-color: rgb(245,186,59);
        }
        footer{
            text-align: center;
            align-items: center;
        }
        footer > div > ul {
            margin:0px;
            padding:0px;
            height: 100%;
            display:flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            margin-left:200px;
            margin-right:200px;
        }
        footer > div > ul > li {
            list-style: none;
        }
        footer > div > ul > li:hover {
            text-decoration: underline;
            text-decoration-style: wavy;
            border-bottom: 15px;
            text-decoration-color: rgb(245,186,59);
        }

        @media screen and (max-width: 600px) {
        .header_right > ul > li {
            font-size:11px;
        }

        form {
            width:100%;
            display:flex;
        }
        form > input[type="submit"]{
            width:20%;
        }
        form > input[type="search"]{
            width:80%;
        }
    }
        
.slide_wrap{
            position: relative;
            width: 350px;
            margin: auto;
            padding-bottom: 30px;
     
        }
.slide_list{ 
         display: flex;
            width: 350px; 
            height: 500px; 
            margin: auto; 
            flex-direction: row;
            left: 50%;
            

        }
.slide_box {
            width: 100%; 
            margin: 30px; 
            
}
.slide_content {
            display: table; 
            width: 200px; 
            height: 320px; 
            margin: 20px;
            padding: 40px;
            border-radius: 2px;
            border: 1px solid #ddd; 
}
.slide_btn_box > button { 
            position: absolute;
            top: 50%; 
            margin-top: 150px; 
            width: 40px; 
            height: 40px; 
            font-size: 20px;
            color: #999; 
            background: white; 
            border: 1px solid #ddd; 
            cursor: pointer; }
.slide_btn_box > .slide_btn_prev {
            left: -150px; 
        }
.slide_btn_box > .slide_btn_next { 
            right: -150px; 
        }
.slide_pagination { 
            position: absolute; 
            left: 300px; 
            bottom: 0; 
            list-style: none; 
            margin: 0; 
            padding: 0; 
            transform: translateX(-50%); 
            transition: 0ms;
        }
.mydiv{
   margin:20px;
   padding: 40px;
   border-radius: 2px;
   border: 1px solid #ddd; 

}
        table.table_t{
            width: 70%;
            margin: auto;
            margin-bottom: -px;
        }
#typeImg{
      position: center;
      
}
.hashimg{
   width: 200px;
   
   
}
.hash_list{
    display:flex;
     align-items: center;
     justify-content: center;
}
.hash{
   margin: 50px;
   padding: 20px;
   border: 1px solid #ddd; 
   
}

h2{
   text-align: center;
}
h3{
   text-align: center;
}
    </style>
</head>
<body>
<%MemberVO user=(MemberVO)session.getAttribute("user");
BbsDAO bbsDao = new BbsDAO();
ArrayList<Bbs> bbs = bbsDao.allList();
ultraVioletAPI ulApi = new ultraVioletAPI();
HashMap<String, String> hash = new HashMap<String, String>();
hash=ulApi.RequestUltraViolet();
pageContext.setAttribute("hash", hash);%>
    <header>
        <div class="header_left">
            <a href="index.jsp"><img src="img/dogether.PNG"></a>
        </div>
        <div class="header_middle">
            <form>
                <input type="search" style="border-color: rgb(245,186,59);">
                <input type="submit" value="검색" style="background-color: rgb(245,186,59); border-radius: 10px;">
            </form>
        </div>
        <% if(user != null){ %>
           <%@ include file="header_login.jsp" %>
        <% } else{%>
        <%@ include file="header.jsp" %>
        <% } %>
    </header>
    <nav>
        <ul>
            <li><a href="bbs1.jsp">도지스토리</a></li>
            <li><a href="map1.jsp">병원찾기</a></li>
            <li><a href="weather.jsp">기상정보</a></li>
        </ul>
    </nav>
    <br><br>
<body>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script>
let mainCity=["Seoul", "Busan", "Incheon", "Daejeon", "Daegu", "ChunCheon", "Gwangju", "Jeju"]
for (let i=0; i<mainCity.length; i++){
   var apiURI = "https://api.openweathermap.org/data/2.5/weather?q="+mainCity[i]+"&appid=8b6ca6b9e2c7445e326ce6be6c69ea2a";
   $.ajax({
       url: apiURI,
       dataType: "json",
       type: "GET",
       async: "false",
       success: function(resp) {
           console.log(resp);
           console.log("현재온도 : "+ (resp.main.temp- 273.15) );
           console.log("현재습도 : "+ resp.main.humidity);
           console.log("날씨 : "+ resp.weather[0].main );
           console.log("상세날씨설명 : "+ resp.weather[0].description );
           console.log("날씨 이미지 : "+ resp.weather[0].icon );
           console.log("바람   : "+ resp.wind.speed );
           console.log("나라   : "+ resp.sys.country );
           console.log("도시이름  : "+ resp.name );
           console.log("강수확률  : "+ (resp.clouds.all) +"%" );
         var $temp = resp.main.temp-273.15;
         var $humidity = resp.main.humidity;
         var $type = resp.weather[0].main;
         var $probability = resp.clouds.all;
         var $wind = resp.wind.speed
         var $city = resp.name
       var $typeImg = null;
         
         
         if($type == "Clouds"){
            $type = "구름";
            $typeImg = "img/clouds.jpg";
         }
         else if($type == "Rain"){
            $type = "비";
            $typeImg = "img/rain.jpg";
         }
         else{
            $type = "맑음";
            $typeImg = "img/sunny.jpg";
         }
            
         $('.ccity'+i).append("<div>도시 : "+($city));
         $('.ctemp'+i).append("<div>현재 기온 : "+($temp).toFixed(3) + "°C</div>");
         $('.chumidity'+i).append("<div>현재 습도 : "+$humidity + "%");
         $('.ctype'+i).append("<div>기상 상태 : "+($type));
         $('.cprobability'+i).append("<div>강수 확률 : " + ($probability) + "%");
         $('.cwind'+i).append("<div>풍속 : "+($wind)+"m/s");
         $('.ctypeImg'+i).append("<img src="+($typeImg)+"  width='200px' height='200px'>");
       }
   })
   
}
</script>

 
       <h2>자외선 지수</h2>
       <h3>2이하 : 매우 좋음 | 3~5 : 좋음 | 6~7 : 보통 | 8~10 : 나쁨 | 11이상 : 매우 나쁨</h3>
               <div class = "hash_list">
                  <div class = "hash">
                  <h3>오늘의 자외선</h3>
                  <%if(Integer.parseInt(hash.get("value_today"))<=2){%>
                  <img src = "img/veryhappy.png" class = "hashimg">
                  <h3>매우 좋음 (지수 : <%=Integer.parseInt(hash.get("value_today")) %>)</h3>
                  <h5>오늘은 산책하기 아주 좋은날!</h5>
                  <% }else if((Integer.parseInt(hash.get("value_today")))>=3 && (Integer.parseInt(hash.get("value_today"))<=5)){%>
                  <img src = "img/happy.png" class = "hashimg">
                  <h3>좋음 (지수 : <%=Integer.parseInt(hash.get("value_today")) %>)</h3>
                  <h5>오늘은 산책하기 좋은 날이에요~</h5>
                  <% }else if((Integer.parseInt(hash.get("value_today")))>=6 && (Integer.parseInt(hash.get("value_today"))<=7)){ %>
                  <img src = "img/soso.png" class = "hashimg">
                  <h3>보통 (지수 : <%=Integer.parseInt(hash.get("value_today")) %>)</h3>
                  <h5>오늘의 산책 지수는 soso! <br> 나쁘지 않아요!</h5>
                  <% }else if((Integer.parseInt(hash.get("value_today")))>=8 && (Integer.parseInt(hash.get("value_today"))<=10)){ %>
                  <img src = "img/sad.png" class = "hashimg">
                  <h3>나쁨 (지수 : <%=Integer.parseInt(hash.get("value_today")) %>)</h3>
                  <h5>오늘은 산책하기 조금 안좋아요 ㅠㅠ..</h5>
                  <% }else { %>
                  <img src = "img/verysad.png" class = "hashimg">
                  <h3>매우 나쁨 (지수 : <%=Integer.parseInt(hash.get("value_today")) %>)</h3>
                  <h5>오늘 산책은 다음으로 미룰까요ㅠㅠ<br>산책하기 아주 나빠요 ㅠㅠ</h5>
                  <% } %>
                  </div>
                  
                  <div class = "hash">
                  <h3>내일의 자외선</h3>
                  <%if(Integer.parseInt(hash.get("value_tomorrow"))<=2){%>
                  <img src = "img/veryhappy.png" class = "hashimg">
                  <h3>매우 좋음 (지수 : <%=Integer.parseInt(hash.get("value_tomorrow")) %>)</h3>
                  <h5>내일은 산책하기 아주 좋은날!</h5>
                  <% }else if((Integer.parseInt(hash.get("value_tomorrow")))>=3 && (Integer.parseInt(hash.get("value_tomorrow"))<=5)){%>
                  <img src = "img/happy.png" class = "hashimg">
                  <h3>좋음 (지수 : <%=Integer.parseInt(hash.get("value_tomorrow")) %>)</h3>
                  <h5>내일은 산책하기 좋은 날이에요~</h5>
                  <% }else if((Integer.parseInt(hash.get("value_tomorrow")))>=6 && (Integer.parseInt(hash.get("value_tomorrow"))<=7)){ %>
                  <img src = "img/soso.png" class = "hashimg">
                  <h3>보통 (지수 : <%=Integer.parseInt(hash.get("value_tomorrow")) %>)</h3>
                  <h5>내일의 산책 지수는 soso! <br> 나쁘지 않아요!</h5>
                  <% }else if((Integer.parseInt(hash.get("value_tomorrow")))>=8 && (Integer.parseInt(hash.get("value_tomorrow"))<=10)){ %>
                  <img src = "img/sad.png" class = "hashimg">
                  <h3>나쁨 (지수 : <%=Integer.parseInt(hash.get("value_tomorrow")) %>)</h3>
                  <h5>내일은 산책하기 조금 안좋아요 ㅠㅠ..</h5>
                  <% }else { %>
                  <img src = "img/verysad.png" class = "hashimg">
                  <h3>매우 나쁨 (지수 : <%=Integer.parseInt(hash.get("value_tomorrow")) %>)</h3>
                  <h5>내일 산책은 다음으로 미룰까요ㅠㅠ<br>산책하기 아주 나빠요 ㅠㅠ</h5>
                  <% } %>
                  </div>
               </div>

         <h2>오늘의 날씨</h2>

            <div class="slide_wrap">
            
               <div class="slide_box">
               <div class="slide_list">
               <%for(int i=0; i<8; i++){ %>
            
               <div class="slide_content">
                        <div class="ctypeImg<%=i %>" id="typeImg"></div>
                        <div class="ccity<%= i%>" id="city"></div>
                        <div class="ctemp<%= i%>" id="temp"></div>
                        <div class="ctype<%= i%>" id="type"></div>
                        <div class="cprobability<%= i%>" id="probability"></div>
                        <div class="chumidity<%= i%>" id="humidity"></div>
                        <div class="cwindflex-direction: column;"></div>
                  </div>
                  <% } %>
                  </div></div>
                  <div class="slide_btn_box">
                                   <button type="button" class="slide_btn_prev">◁</button>
                                   <button type="button" class="slide_btn_next">▷</button>
                  </div> 
            </div>

<script src="slide2.js"></script>
    <footer class="footer" style="height: 320px; border-top: gray; background-color: gray; margin-top: 50px;">
        <%@ include file="footer.jsp" %>
    </footer>

</body>
</html>