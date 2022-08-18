package kr.co.tsoft.sign.service;

import kr.co.tsoft.sign.vo.ApiResponse;
import kr.co.tsoft.sign.vo.ApiResponseData;
import kr.co.tsoft.sign.vo.ApiResponseData.Ocr;
import okhttp3.MultipartBody;
import retrofit2.Call;
import retrofit2.http.Multipart;
import retrofit2.http.POST;
import retrofit2.http.Part;
import retrofit2.http.Query;

public interface RetrofitApi {
    @Multipart
    @POST("api/tsa")
    Call<ApiResponse<ApiResponseData.Tsa>> processTsa(@Query("token") String token, @Part MultipartBody.Part file);
    
    @Multipart
    @POST("api/ocr")
	Call<ApiResponse<ApiResponseData.Ocr>> processOcr(@Query("token") String token, @Part MultipartBody.Part file);

    /*@POST("api/v1/gift-orders/{orderToken}/update-receiver-info")
    Call<Void> updateReceiverInfo(@Path("orderToken") String orderToken, @Body GiftCommand.Accept request);*/
}
