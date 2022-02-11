## HTTP Live Stream(HLS) 란?

HLS(HTTP 라이브 스트리밍)은 비디오 스트리밍 프로토콜로 Apple에서 만들었습니다.  
HTTP 라이브 스트리밍이라 불리지만 주문형 스트리밍(VOD) 이며 동시에 라이브 스트리밍입니다.  
프로토콜에서 스트리밍 데이터를 m3u8 의 확장자를 가진 재생목록 파일과 잘게 쪼개놓은 다수의 ts 파일들(동영상)을 HTTP 를 통해 전송하는 방식을 사용합니다.  
네트워크 상황에 따라 bitRate를 조절하며 끊김없는 원활한 영상 시청이 가능하도록 합니다.

- m3u8 : m3u 파일인데, UTF-8 로 인코딩 되어 있다는 의미.
- m3u : 멀티미디어 파일의 재생목록을 관리하는 파일
- ts : MPEG-2 의 Transport Stream 포맷

  
</br><br/>
### 여기서 잠깐! VOD란?
Video On Demand의 약어로 서비스 이용자의 요구에 따라 영화나 뉴스 등의 영상 기반 서비스를 전화선이나 케이블을 통해 제공하는 새로운 개념의 영상 서비스 사업을 말합니다.
핵심은 **"서비스 이용자의 요구에 따라 원하는 때에"** 입니다. VOD가 아닌 것은 그럼 지상파 TV 서비스 입니다.

### m3u8 파일
m3u8 확장자를 가진 파일 하나를 열어봤습니다.
```swift
#EXTM3U
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=551000,RESOLUTION=512x288,CODECS="avc1.66.30, mp4a.40.2",CLOSED-CAPTIONS=NONE
https://multiplatform-f.akamaihd.net/i/multi/april11/sintel/sintel-hd_,512x288_450_b,640x360_700_b,768x432_1000_b,1024x576_1400_m,.mp4.csmil/index_0_av.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=808000,RESOLUTION=640x360,CODECS="avc1.66.30, mp4a.40.2",CLOSED-CAPTIONS=NONE
https://multiplatform-f.akamaihd.net/i/multi/april11/sintel/sintel-hd_,512x288_450_b,640x360_700_b,768x432_1000_b,1024x576_1400_m,.mp4.csmil/index_1_av.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1117000,RESOLUTION=768x432,CODECS="avc1.66.30, mp4a.40.2",CLOSED-CAPTIONS=NONE
https://multiplatform-f.akamaihd.net/i/multi/april11/sintel/sintel-hd_,512x288_450_b,640x360_700_b,768x432_1000_b,1024x576_1400_m,.mp4.csmil/index_2_av.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1537000,RESOLUTION=1024x576,CODECS="avc1.77.30, mp4a.40.2",CLOSED-CAPTIONS=NONE
https://multiplatform-f.akamaihd.net/i/multi/april11/sintel/sintel-hd_,512x288_450_b,640x360_700_b,768x432_1000_b,1024x576_1400_m,.mp4.csmil/index_3_av.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=64000,CODECS="mp4a.40.2",CLOSED-CAPTIONS=NONE
https://multiplatform-f.akamaihd.net/i/multi/april11/sintel/sintel-hd_,512x288_450_b,640x360_700_b,768x432_1000_b,1024x576_1400_m,.mp4.csmil/index_0_a.m3u8

```
m3u8안에 또 여러개의 m3u8 url이 있네요.  
인덱스 0과 1 짜리 url 전체를 크롬 주소창에 붙여넣어 봤습니다.  
![image](https://user-images.githubusercontent.com/73683735/150309352-c828d518-b5a2-4a46-af46-4bffae462545.png)

이렇게 두개를 다운로드 받고 또 그 안을 살펴 봤습니다.
```swift
#EXTM3U
#EXT-X-TARGETDURATION:10
#EXT-X-ALLOW-CACHE:YES
#EXT-X-PLAYLIST-TYPE:VOD
#EXT-X-VERSION:3
#EXT-X-MEDIA-SEQUENCE:1
#EXTINF:10.000, // 옛날엔 10초 권장이었는데 애플 공홈 보니까 6초네요. ㅎㅎ 
https://multiplatform-f.akamaihd.net/i/multi/april11/sintel/sintel-hd_,512x288_450_b,640x360_700_b,768x432_1000_b,1024x576_1400_m,.mp4.csmil/segment1_0_av.ts
#EXTINF:10.000,
https://multiplatform-f.akamaihd.net/i/multi/april11/sintel/sintel-hd_,512x288_450_b,640x360_700_b,768x432_1000_b,1024x576_1400_m,.mp4.csmil/segment2_0_av.ts
#EXTINF:10.000,
https://multiplatform-f.akamaihd.net/i/multi/april11/sintel/sintel-hd_,512x288_450_b,640x360_700_b,768x432_1000_b,1024x576_1400_m,.mp4.csmil/segment3_0_av.ts

//너무 길어서 짤랐습니다.
```

<img src="https://user-images.githubusercontent.com/73683735/153635222-f42749d6-e796-48aa-976f-59655b00a954.png" width = "600">
이번엔 ts파일 여러개가 들어 있었습니다.  

이렇게 영상을 잘게 쪼개어 파일들로 나눠 담고 스트리밍 하는 기술을 HLS 이라고 합니다. 


### m3u8 메타데이터 명령어

<img src="https://user-images.githubusercontent.com/73683735/150315051-524a8711-cde5-42bb-8329-beddb2ef689c.png" width = "600">  
출처 : https://aciddust.github.io/blog/post/HLS-%EC%95%BC%EB%A7%A4%EB%A1%9C-%EC%95%8C%EC%95%84%EB%B3%B4%EB%8A%94-Http-Live-Streaming-A-to-Z/  


---

**참고 자료**   

HLS 성능 관련 영상 : https://developer.apple.com/documentation/http_live_streaming/hls_authoring_specification_for_apple_devices  

Apple 기기에 HLS을 사용하여 라이브 및 동영상을 재생하기 위한 요구사항 : https://developer.apple.com/documentation/http_live_streaming/hls_authoring_specification_for_apple_devices  

Free HLS m3u8 file : https://ottverse.com/free-hls-m3u8-test-urls/  

HLS란? : https://littlecarbb.tistory.com/entry/스트리밍Streaming-용어정리-1-HLSHttp-Live-Streaming [Shameless Simon] 


