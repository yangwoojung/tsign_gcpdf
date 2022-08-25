package kr.co.tsoft.sign.service;

import kr.co.tsoft.sign.vo.ApiResponse;
import kr.co.tsoft.sign.vo.ApiResponseData;
import kr.co.tsoft.sign.vo.ApiResponseData.Ocr;
import kr.co.tsoft.sign.vo.ApiResponseData.Verify;
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
    
    @POST("api/scrap")
    Call<ApiResponse<ApiResponseData.Scrap>> processScrap(@Query("token") String token, @Query("type") String type,
    													  @Query("col1") String col1, @Query("col2") String col2, @Query("col3") String col3,
														  @Query("col4") String col4, @Query("col5") String col5, @Query("col6") String col6);
    
    @Multipart
    @POST("api/verify")
	Call<ApiResponse<ApiResponseData.Verify>> processVerify(@Query("token") String token, @Part MultipartBody.Part file);
    
    /*@POST("api/v1/gift-orders/{orderToken}/update-receiver-info")
    Call<Void> updateReceiverInfo(@Path("orderToken") String orderToken, @Body GiftCommand.Accept request);*/
}
