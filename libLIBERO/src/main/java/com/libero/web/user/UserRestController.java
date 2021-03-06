package com.libero.web.user;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.UUID;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.http.HttpHost;
import org.apache.http.HttpResponse;
import org.apache.http.auth.AuthScope;
import org.apache.http.auth.UsernamePasswordCredentials;
import org.apache.http.client.AuthCache;
import org.apache.http.client.CredentialsProvider;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.protocol.HttpClientContext;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.auth.BasicScheme;
import org.apache.http.impl.client.BasicAuthCache;
import org.apache.http.impl.client.BasicCredentialsProvider;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.ibatis.annotations.Param;
import org.codehaus.jackson.JsonNode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.servlet.ModelAndView;

import com.libero.common.Page;
import com.libero.common.Search;
import com.libero.service.community.CommunityService;
import com.libero.service.domain.Post;
import com.libero.service.domain.Product;
import com.libero.service.domain.Publish;
import com.libero.service.domain.Report;
import com.libero.service.domain.User;
import com.libero.service.product.ProductService;
import com.libero.service.publish.PublishService;
import com.libero.service.report.ReportService;
import com.libero.service.user.UserService;

//==> 회원관리 RestController
@RestController
@RequestMapping("/user/*")
public class UserRestController {
	
	///Field
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	@Autowired
	private PublishService publishService;
	
	//Constructor
	public UserRestController(){
		System.out.println(this.getClass());
	}
	
	@Value("#{userProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{userProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	//method
	@RequestMapping( value="json/login", method=RequestMethod.POST )
	public User login(@RequestBody Map<String, Object> params, HttpSession session ) throws Exception{
	
		System.out.println("/user/json/login : POST");
		//Business Logic
		System.out.println("::"+params.get("userId"));
		User user = userService.getUser((String) params.get("userId"));
		
		if( ((String)params.get("password")).equals(user.getPassword())){
			session.setAttribute("user", user);
		}
		return user;
	}
	
	@RequestMapping( value="json/getUser", method=RequestMethod.POST )
	public User getUser(@RequestBody User user) throws Exception{
	
		System.out.println("/user/json/getUser : GET");
		//Business Logic
		user = userService.getUser(user.getUserId());
		
		return user;
	}
	
	@RequestMapping(value="json/emailSend",method=RequestMethod.GET)
	public Map<String, Object> emailSend(@RequestParam("userId") String userId) throws Exception{
		System.out.println(" ---------------------------------------");
		System.out.println("[ /user/json/emailCheck/"+userId+" : GET]");
		System.out.println(" ---------------------------------------");
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		////email보내는 함수 작성
		String verCode = mailSender(userId, "add");
		
		System.out.println("\n\n[ "+verCode+" ]\n\n");

		map.put("verifCode", verCode);

		
		////리턴 값 설정 해주기.
		return map;
	}
	
	public String mailSender(String userId, String isFind) throws AddressException, MessagingException {
		
		String host = "smtp.naver.com"; 
		int port=465; 
		final String username = "wjddbstp"; //네이버 아이이디 
		final String password = ""; //네이버 비번 
		String verCode=userService.getAlphaNumericString();
		String recipient = userId; //받는 사람 이메일 주소 
		Properties props = System.getProperties(); // 메일 제목, 내용을 담을 properties 만들기. 
		
		String subject = null;
		String body = null;
		
		if(isFind.equals("add")) {	
			subject = "[libLIBERO] 회원가입 이메일 인증"; //메일 제목 
			body = "libLIBERO Email Verification Code\n\t\t"+"[ "+ verCode+" ]"; //메일 내용		
		}else if(isFind.equals("find")) {
			subject = "[libLIBERO] 비밀번호 변경 안내"; //메일 제목 
			body = "임시 비밀번호 발급 \n\n 임시 비밀번호 :  "+"[ "+ verCode+" ] \n\n 회원님의 비밀번호를 변경해주세요."; //메일 내용		
		}
		
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", port);
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.ssl.enable", "true");
		props.put("mail.smtp.ssl.trust", host);
		
		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			String un=username; 
			String pw=password; 
			protected javax.mail.PasswordAuthentication getPasswordAuthentication() { 
				return new javax.mail.PasswordAuthentication(un, pw);
				} }); 
		session.setDebug(true); //for debug 
		Message messageContent = new MimeMessage(session); 
		//MimeMessage 
			
			String email = "wjddbstp@naver.com";	
			InternetAddress emailAddr = new InternetAddress(email);
			emailAddr.validate();
			messageContent.setFrom(emailAddr); 
			 // 보내기 
		
			//발신자  이메일 세팅
			messageContent.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient)); //수신자 세팅 
			messageContent.setSubject(subject); //제목 세팅 
			messageContent.setText(body); //내용 세팅
			Transport.send(messageContent);	
		//javax.mail.Transport.send() 이용하는 거임
		return verCode;
	}
	
	
	@RequestMapping(value="json/duplicationCheck",method=RequestMethod.GET)
	public boolean duplicationCheck(@Param("userId") String userId) throws Exception{
		System.out.println(" ---------------------------------------");
		System.out.println("[ /user/json/duplicationCheck/"+userId+" : GET]");
		System.out.println(" ---------------------------------------");
		
		
		boolean	result = userService.duplicationCheck(userId);
	System.out.println("\n\n\n\n"+result+"\n\n\n");
		return result;
	}
	
	@RequestMapping(value="json/duplicationNick",method=RequestMethod.GET)
	public boolean duplicationNick(@Param("nickname") String nickname) throws Exception{
		System.out.println(" ---------------------------------------");
		System.out.println("[ /user/json/duplicationCheck/"+nickname+" : GET]");
		System.out.println(" ---------------------------------------");
		
		String decodednickname=URLDecoder.decode(nickname,"UTF-8");
		System.out.println("\n\n\n---------"+decodednickname+"\n\n\n\n\n");
		boolean result = userService.duplicationNick(decodednickname);
		
		
		return result;
	}
	
	@RequestMapping(value="json/getUserPublishList/{prodType}")
	public Map<String, Object> getUserPublishList(HttpSession session, @PathVariable("prodType") String prodType, Publish publish,@RequestBody Search search) throws Exception {
		
		System.out.println("/user/json/getUserPublishList : GET, POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		publish.setProdType(prodType);
		publish.setCreator(((User)session.getAttribute("user")).getUserId());
		
		Map<String , Object> map=publishService.getUserPublishList(publish, search);
		Page resultPage = new Page(search.getCurrentPage(),
				((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		Map<String, Object> map01 = new HashMap<String, Object>();
		map01.put("list", map.get("list"));
		map01.put("resultPage", resultPage);
		map01.put("search", search);
		return map01;
	}
	
	@RequestMapping(value = "json/kakaologin", produces = "application/json", method = { RequestMethod.GET, RequestMethod.POST }) 
	public ModelAndView kakaoLogin(@RequestParam("code") String code, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception { 
		System.out.println("/user/json/kakaologin");
		
		ModelAndView mav = new ModelAndView(); 
		
		User user = (User) session.getAttribute("user");	
		JsonNode node = SNSloginController.getAccessToken(code); 
		JsonNode accessToken = node.get("access_token");
		
		JsonNode userInfo = SNSloginController.getKakaoUserInfo(accessToken); 
		JsonNode kakaoAccount = userInfo.path("kakao_account");	
		JsonNode properties = userInfo.path("properties");	
		

		String kId = userInfo.path("id").asText();	
		String kEmail = kakaoAccount.path("email").asText();
		String kNickname = properties.path("nickname").asText(); 		
		if(userService.getUserNickname(kNickname) != null) {
			kNickname = (UUID.randomUUID().toString().replaceAll("-", "")).substring(0, 5)+"_"+kNickname;
		}
		String kGender = kakaoAccount.path("gender").asText();

		
		if(user == null) {
			user = new User();
			
			if(userService.getUserByKakao(kId) != null) {		
				user = userService.getUserByKakao(kId);
			}else if(userService.getUser(kEmail) != null) {
				user = userService.getUser(kEmail);
			}else if(userService.getUserByKakao(kId) == null && userService.getUser(kEmail) == null) {			
				user.setUserId(kEmail);	
				user.setPassword((UUID.randomUUID().toString().replaceAll("-", "")).substring(0, 14));
				user.setKakaoId(kId);
				user.setNickname(kNickname);
				user.setName(kNickname);
				user.setGenderCode(kGender.substring(0,1));		
				
				userService.addUser(user);				
				user = userService.getUser(user.getUserId());
			}		
		}else { 
			User kUser = userService.getUser(kEmail);
			if(kUser == null) {
				userService.addKakaoId(user.getUserId(), kId);				
			}else {			
				  userService.updateKakaoToUser(user.getUserId(), kEmail);
				  userService.delUser(kEmail);
				  userService.addKakaoId(user.getUserId(), kId);	  			 
			}
		}
					
		session.setAttribute("user", user);
		session.setAttribute("kakao", "true"); 
		mav.setViewName("redirect:/view/user/loginView.jsp");
		
		return mav; 
		}
	
	@RequestMapping(value = "json/kakaoLogout", produces = "application/json", method = { RequestMethod.GET, RequestMethod.POST }) 
	public ModelAndView kakaoLogout(HttpSession session) throws Exception {
		System.out.println("/user/json/kakaoLogout");
		
		ModelAndView mav = new ModelAndView();
		
		session.invalidate();
		
		mav.setViewName("redirect:/");
		
		return mav; 			
	}
	
	@RequestMapping(value="json/sendSms",method=RequestMethod.POST)
	public int sendSms(String receiver) {
		// 6자리 인증 코드 생성 
		int randomNo = userService.randomNumber();
		// 인증 코드를 데이터베이스에 저장하는 코드는 생략했습니다. 
		// 문자 보내기 
		String hostname = "api.bluehouselab.com";
		String url = "https://" + hostname + "/smscenter/v1.0/sendsms";
		CredentialsProvider credsProvider = new BasicCredentialsProvider();
		credsProvider.setCredentials(new AuthScope(hostname, 443, AuthScope.ANY_REALM),// 청기와랩에 등록한 Application Id 와 API key 를 입력합니다. 
				new UsernamePasswordCredentials("libero", "79087a92ddfc11eaaa100cc47a1fcfae"));
		AuthCache authCache = new BasicAuthCache(); 
		authCache.put(new HttpHost(hostname, 443, "https"), new BasicScheme());
		HttpClientContext context = HttpClientContext.create();
		context.setCredentialsProvider(credsProvider);
		context.setAuthCache(authCache);
		DefaultHttpClient client = new DefaultHttpClient();
		try {
			HttpPost httpPost = new HttpPost(url);
		httpPost.setHeader("Content-type", "application/json; charset=utf-8");//문자에 대한 정보 
		String json = "{\"sender\":\"01042796268\",\"receivers\":[\"" + receiver + "\"],\"content\":\""+randomNo+"\"}"; 
		StringEntity se = new StringEntity(json, "UTF-8"); 
		httpPost.setEntity(se); 
		HttpResponse httpResponse = client.execute(httpPost, context);
		InputStream inputStream = httpResponse.getEntity().getContent();
		if (inputStream != null) {
			BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(inputStream)); 
		String line = ""; 
		while ((line = bufferedReader.readLine()) != null) 
			inputStream.close(); 
		}else {
			return 0;
		}
		
		} catch (Exception e) { 
			System.err.println("Error: " + e.getLocalizedMessage()); 
			}finally { 
				client.getConnectionManager().shutdown();
				}
		return randomNo;
	}
		
	@ResponseBody
	@RequestMapping(value="json/updatePhoneCode",method=RequestMethod.POST)
	public int updatePhoneCode(HttpSession session,boolean phoneCode ) throws Exception{
		System.out.println(" ---------------------------------------");
		System.out.println("[ /user/json/updatePhoneCode  :: POST]");
		System.out.println(" ---------------------------------------");
		User user = (User)session.getAttribute("user");
		
		return userService.updatePhoneCode(user.getUserId());
	}
	
	
		
	@RequestMapping(value="json/findId",method=RequestMethod.POST)
	public Map<String, Object> findId(String receiver) {
		System.out.println("/user/json/findId : POST");
	
		String userId = userService.findUserIdByPhone(receiver);
		
		Map<String, Object> map = new HashMap<String, Object>();		
		
		if(userId == null) {			
			map.put("certifiNum", 1111111);
			return map;
		}
		
		
		map.put("certifiNum", sendSms(receiver));
		map.put("userId", userId);
		return map;
	}
	
	@RequestMapping(value="json/findPassword",method=RequestMethod.GET)
	public void findPassword(@RequestParam("findPassword") String userId) throws Exception, MessagingException {
		System.out.println("/user/json/findPassword : POST");
		
		System.out.println(">>"+userId);
		
		String verCode = mailSender(userId, "find");			
		userService.updatePassword(userId, verCode);
		
	}
	
}