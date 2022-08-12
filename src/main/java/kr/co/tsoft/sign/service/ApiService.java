package kr.co.tsoft.sign.service;

import kr.co.tsoft.sign.util.retrofit.RetrofitUtils;
import kr.co.tsoft.sign.vo.ApiRequest;
import kr.co.tsoft.sign.vo.ApiResponse;
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

  public ApiResponse processTsa(ApiRequest request) {

      Call<ApiResponse> call = retrofitApi.processTsa(request.getToken(), request.getFile());
      return retrofitUtils.responseSync(call).orElseThrow(RuntimeException::new);
    }

}
