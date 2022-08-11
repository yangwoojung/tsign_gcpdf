package kr.co.tsoft.sign.service;

import kr.co.tsoft.sign.vo.ApiRequest;
import kr.co.tsoft.sign.vo.ApiResponse;
import okhttp3.MultipartBody;
import org.springframework.web.multipart.MultipartFile;
import retrofit2.Call;
import retrofit2.http.*;

public interface RetrofitApi {
    @Multipart
    @POST("api/tsa")
//    Call<ApiResponse> processTsa(@Body ApiRequest.Tsa request);
    Call<ApiResponse> processTsa(@Query("token") String token, @Part MultipartBody.Part file);

/*    @POST("api/v1/gift-orders/init")
    Call<CommonResponse<RetrofitOrderApiResponse.Register>> registerOrder(@Body OrderApiCommand.Register request);*/

    /*@POST("api/v1/gift-orders/{orderToken}/update-receiver-info")
    Call<Void> updateReceiverInfo(@Path("orderToken") String orderToken, @Body GiftCommand.Accept request);*/
}
