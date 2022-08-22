package kr.co.tsoft.sign.service;

import kr.co.tsoft.sign.util.retrofit.RetrofitUtils;
import kr.co.tsoft.sign.vo.ApiRequest;
import kr.co.tsoft.sign.vo.ApiResponse;
import kr.co.tsoft.sign.vo.ApiResponseData;
import kr.co.tsoft.sign.vo.ApiResponseData.Scrap;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import retrofit2.Call;

@Slf4j
@Service
@RequiredArgsConstructor
public class ApiService {
    private final RetrofitUtils retrofitUtils;
    private final RetrofitApi retrofitApi;

  public ApiResponse<ApiResponseData.Tsa> processTsa(ApiRequest.Tsa request) {

      Call<ApiResponse<ApiResponseData.Tsa>> call = retrofitApi.processTsa(request.getToken(), request.getFile());
      return retrofitUtils.responseSync(call).orElseThrow(RuntimeException::new);
    }

  public ApiResponse<ApiResponseData.Ocr> processOcr(ApiRequest.Ocr request) {
	  Call<ApiResponse<ApiResponseData.Ocr>> call = retrofitApi.processOcr(request.getToken(), request.getFile());
	  return retrofitUtils.responseSync(call).orElseThrow(RuntimeException::new);
  	}
  
  public ApiResponse<ApiResponseData.Scrap> processScrap(ApiRequest.Scrap request) {
	  Call<ApiResponse<ApiResponseData.Scrap>> call = retrofitApi.processScrap(request.getToken(), request.getType(), 
			  																request.getCol1(), request.getCol2(), request.getCol3(), 
			  																request.getCol4(), request.getCol5(), request.getCol6());
	  return retrofitUtils.responseSync(call).orElseThrow(RuntimeException::new);
  }
  

}
