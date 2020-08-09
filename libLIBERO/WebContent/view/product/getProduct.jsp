<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<jsp:include page="/common/cdn.jsp"></jsp:include>
	
	
	<style>
									.number-input input[type="number"] {
							-webkit-appearance: textfield;
							-moz-appearance: textfield;
							appearance: textfield;
							}
							
							.number-input input[type=number]::-webkit-inner-spin-button,
							.number-input input[type=number]::-webkit-outer-spin-button {
							-webkit-appearance: none;
							}
							
							.number-input {
							  display: flex;
							  justify-content: space-around;
							  align-items: center;
							}
							
							.number-input button {
							-webkit-appearance: none;
							background-color: transparent;
							border: none;
							align-items: center;
							justify-content: center;
							cursor: pointer;
							margin: 0;
							position: relative;
							}
							
							.number-input button:before,
							.number-input button:after {
							display: inline-block;
							position: absolute;
							content: '';
							height: 2px;
							transform: translate(-50%, -50%);
							}
							
							.number-input button.plus:after {
							transform: translate(-50%, -50%) rotate(90deg);
							}
							
							.number-input input[type=number] {
							text-align: center;
							}
							
							.number-input.number-input {
							border: 1px solid #ced4da;
							width: 10rem;
							border-radius: .25rem;
							}
							
							.number-input.number-input button {
							width: 2.6rem;
							height: .7rem;
							}
							
							.number-input.number-input button.minus {
							padding-left: 10px;
							}
							
							.number-input.number-input button:before,
							.number-input.number-input button:after {
							width: .7rem;
							background-color: #495057;
							}
							
							.number-input.number-input input[type=number] {
							max-width: 4rem;
							padding: .5rem;
							border: 1px solid #ced4da;
							border-width: 0 1px;
							font-size: 1rem;
							height: 2rem;
							color: #495057;
							}
							
							@media not all and (min-resolution:.001dpcm) {
							@supports (-webkit-appearance: none) and (stroke-color:transparent) {
							
							.number-input.def-number-input.safari_only button:before,
							.number-input.def-number-input.safari_only button:after {
							margin-top: -.3rem;
							}
							}
							}

	</style>
	
	
	
</head>
<body>
		<!-- ToolBar Start /////////////////////////////////////-->
		<jsp:include page="../toolbar.jsp" />
	   	<!-- ToolBar End /////////////////////////////////////-->
		<div class="container my-5 py-5 z-depth-0">


  <!--Section: Content-->
  <section class="text-center">

    <!-- Section heading -->
    <h3 class="font-weight-bold mb-5">Product Details</h3>

    <div class="row">
      <div class="col-lg-6">

        <!--Carousel Wrapper-->
        <div id="carousel-thumb1" class="carousel slide carousel-fade carousel-thumbnails mb-5 pb-4" data-ride="carousel" style="margin-bottom: 0px; padding-bottom: 0px">

          <!--Slides-->
          <div class="carousel-inner text-center text-md-left z-depth-1" style="width: 400px; height: 450px; margin-bottom: 0px; padding-bottom: 0px" role="listbox">
            <div class="carousel-item active">
              <img style="margin-bottom: 0px;" src="../../resources/images/publish/fileUpload/thumbnailFile/${product.prodThumbnail}"
                alt="First slide" class="img-fluid">
            </div>
            <div class="carousel-item">
              <img src="../../resources/images/publish/fileUpload/coverFile/${product.coverFile}"
                alt="Second slide" class="img-fluid">
            </div>
          </div>
          <!--/.Slides-->

          <!--Thumbnails-->
          <a class="carousel-control-prev" href="#carousel-thumb1" role="button" data-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
          </a>
          <a class="carousel-control-next" href="#carousel-thumb1" role="button" data-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
          </a>
          <!--/.Thumbnails-->

        </div>
        <!--/.Carousel Wrapper-->
        
        <div class="row mb-4">
          <div class="col-md-12">
            <div id="mdb-lightbox-ui"></div>
            <div class="row mdb-lightbox no-margin" style="width: 500px;">
              <figure class="col-md-4" style="margin: 22px; padding: 0px; height:200px;">
                <a href="../../resources/images/publish/fileUpload/thumbnailFile/${product.prodThumbnail}"
                  data-size="1600x1067">
                  <img src="../../resources/images/publish/fileUpload/thumbnailFile/${product.prodThumbnail}"
                    class="img-fluid z-depth-1" style="height: 200px; width:170px;">
                </a>
              </figure>
              <figure class="col-md-4" style="margin: 22px; padding: 0px;">
                <a href="../../resources/images/publish/fileUpload/coverFile/${product.coverFile}"
                  data-size="1600x1067">
                  <img src="../../resources/images/publish/fileUpload/coverFile/${product.coverFile}"
                    class="img-fluid z-depth-1" style="height: 200px; width:170px;">
                </a>
              </figure>
            </div>
          </div>
        </div>
        
      </div>

      <div class="col-lg-5 text-center text-md-left">

        <h2 class="h2-responsive text-center text-md-left product-name font-weight-bold dark-grey-text mb-1 ml-xl-0 ml-4">${product.prodName}</h2>
        			
        			<span>
        			<c:if test="${wish == 1}"><i class="fas fa-heart" id="wish"></i></c:if>
					<c:if test="${wish == 0}"><i class="far fa-heart" id="wish"></i></c:if>
					</span>
        			
        <span class="badge badge-danger product mb-4 ml-xl-0 ml-4">bestseller</span>
        <span class="badge badge-success product mb-4 ml-2">SALE</span>

        <h3 class="h3-responsive text-center text-md-left mb-5 ml-xl-0 ml-4">
          <span class="red-text font-weight-bold">
            <strong>${product.retailPrice}</strong>
          </span>
          <span class="grey-text">
            <small>
              <s>$1789</s>
            </small>
          </span>
        </h3>

        <div class="font-weight-normal">
          
          <p class="ml-xl-0 ml-4">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sapiente nesciunt atque nemo neque ut officiis nostrum incidunt maiores, magni optio et sunt suscipit iusto nisi totam quis, nobis mollitia necessitatibus.</p>

          <p class="ml-xl-0 ml-4">
            <strong>Page: </strong></p>
          <p class="ml-xl-0 ml-4">
            <strong>Size: </strong>9.6-inch</p>
          <p class="ml-xl-0 ml-4">
            <strong>Resolution: </strong>2048 x 1536</p>
          <p class="ml-xl-0 ml-4">
            <strong>등록일자: </strong>${product.regDate}</p>
          
          <div class="mt-5">
            <p class="grey-text">Choose your color</p>
            <div class="row text-center text-md-left">
              <div class="col-md-4 col-12 ">
                <div class="form-group">
                  <input class="form-check-input" name="group100" type="radio" id="radio100" checked="checked">
                  <label for="radio100" class="form-check-label dark-grey-text">White</label>
                </div>
              </div>
              <div class="col-md-4">
                <div class="form-group">
                  <input class="form-check-input" name="group100" type="radio" id="radio101">
                  <label for="radio101" class="form-check-label dark-grey-text">Silver</label>
                </div>
              </div>
              <div class="col-md-4">
                <div class="form-group">
                  <input class="form-check-input" name="group100" type="radio" id="radio102">
                  <label for="radio102" class="form-check-label dark-grey-text">Gold</label>
                </div>
              </div>
            </div>
            <div class="row mt-3 mb-4">
            
              <div class="col-6" style="padding:10px ;">
            
						                <span class="def-number-input number-input safari_only" style="margin-right:0px; padding-top:0px;">
										  <button onclick="this.parentNode.querySelector('input[type=number]').stepDown()" class="minus"></button>
										  <input class="quantity" min="0" name="quantity" value="1" type="number" id="buyAmount" >
										  <button onclick="this.parentNode.querySelector('input[type=number]').stepUp()" class="plus"></button>
										  </span>
              </div>
              							<span class="col-6">
										  <button class="btn btn-brown btn-rounded" onclick="addCart()" style="margin-top:5px;">
                 						  <i class="fas fa-cart-plus mr-2" aria-hidden="true"></i> Add to cart</button>
										</span>
            </div>
          </div>

        </div>

      </div>
    </div>

  </section>
  <!--Section: Content-->


</div>			
					<div class="container my-5 w-400">

					  <section>
					    
					    <div class="card mb-4 z-depth-0 w-200">
					      
					      <div class="row">
					
					        <div class="col-md-6">
					          <img class="img-fluid rounded-left" src="../../resources/images/publish/fileUpload/thumbnailFile/${product.prodThumbnail}" alt="project image">
					        </div>
					
					        <div class="col-md-6 p-5 align-self-center ">
					
					          <h5 class="font-weight-normal mb-3">상품명</h5>
					
					          <p class="text-muted">${product.prodName}</p>
					
					          <ul class="list-unstyled font-small mt-5 mb-0">
					            <li>
					              <p class="text-uppercase mb-2"><strong>작가</strong></p>
					              <p class="text-muted mb-4">${product.creator}</p>
					            </li>
					
					            <li>
					              <p class="text-uppercase mb-2"><strong>등록일자</strong></p>
					              <p class="text-muted mb-4">${product.regDate}</p>
					            </li>
					
					            <li>
					              <p class="text-uppercase mb-2"><strong>Skills</strong></p>
					              <p class="text-muted mb-4">Design, HTML, CSS, Javascript</p>
					            </li>
					
					            <li>
					              <p class="text-uppercase mb-2"><strong>Address</strong></p>
					              
					            </li>
					
					            <li>
					              <p class="text-uppercase mt-4 mb-2"><strong>Share</strong></p>
					             		 
					              		<div class="def-number-input number-input safari_only">
										  <button onclick="this.parentNode.querySelector('input[type=number]').stepDown()" class="minus"></button>
										  <input class="quantity" min="0" name="quantity" value="1" type="number" id="buyAmount" >
										  <button onclick="this.parentNode.querySelector('input[type=number]').stepUp()" class="plus"></button>
										</div>
										<button type="button" class="btn btn-so" onclick="addCart()"><i class="fas fa-cart-plus" ></i></button>
					              
					            </li>
					
					          </ul>
					
					        </div>
					
					      </div>
					
					    </div>

  </section>

</div>
				

</body>

<script type="text/javascript">
	
	$(document).ready(function(){
	    //alert(${product.prodNo});
	   // alert("${sessionScope.user.userId}");
	});
	
// 	$(function(){
// 		$("input").attr("onclick","buyAmount()");
// 	})
	
// 	function buyAmount(){
// 		var buyAmount = $("#buyAmount").val();
// 	}
	
	$(document).ready(function(){
			$('#wish').on("click", function(){
				var userId = "${sessionScope.user.userId}";
				if (userId=="") {
					alert("로그인 해주세요.");
					return;
				}
				
				
			
				$.ajax({
					url : "/libero/product/json/addWish",
					type: "POST",
					dataType: "json",
					header : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
					},
					data: {"prodNo": ${product.prodNo}, "userId": "${sessionScope.user.userId}" },
					success : function(data){
						
						if(data.wish == "y"){
							var wishwish = "fas fa-heart";
						}else if(data.wish == "n"){
							var wishwish = "far fa-heart";
						}
						$('#wish').attr('class', wishwish);
					}//end success
				});//end ajax
			});//end click function
	});//end ready
	
	function addCart() {
		var userId = "${sessionScope.user.userId}";
		var phoneCode = "${sessionScope.user.phoneCode}";
		var buyAmount = $("#buyAmount").val();
		//alert(buyAmount);
		
		if (userId=="") {
			alert("로그인 해주세요.");
			return;
		}
		if (phoneCode!=1) {
			alert("휴대폰 본인인증을 완료한 회원만 가능합니다.");
			return;
		}
		if (buyAmount==0) {
			alert("수량을 선택해주세요.");
			return;
		}
		
		$.ajax({
			url : "/libero/product/json/addCart",
			type: "POST",
			dataType: "json",
			header : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
			},
			data: {"prodNo": ${product.prodNo}, "prodType": "${product.prodType}", "userId": "${sessionScope.user.userId}", "buyAmount": buyAmount, "from": "product"},
			success : function(data){
						var message = data.result
						alert(message);
			}
		});//end ajax
		
	}//end addCart
		
		//$("form").attr("method" , "POST").attr("action" , "/libero/product/json/addCart").submit();
	</script>
</html>