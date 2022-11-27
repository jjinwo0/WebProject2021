<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script type = "text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">


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
#typeImg{
      position: center;
      
}

</style>
</head>


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
<section>
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
   

</div> </section>
<script src="slide2.js"></script>
</body>
</html>