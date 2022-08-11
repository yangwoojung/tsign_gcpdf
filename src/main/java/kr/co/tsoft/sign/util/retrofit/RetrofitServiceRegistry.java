package kr.co.tsoft.sign.util.retrofit;

import kr.co.tsoft.sign.service.RetrofitApi;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import retrofit2.Retrofit;

@Configuration
public class RetrofitServiceRegistry {

    @Value("${api.base.url}")
    private String baseUrl;

    @Bean
    public RetrofitApi retrofitOrderApi() {
        Retrofit retrofit = RetrofitUtils.initRetrofit(baseUrl);
        return retrofit.create(RetrofitApi.class);
    }
}
