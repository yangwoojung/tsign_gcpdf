package kr.co.tsoft.sign.vo;

import kr.co.tsoft.sign.config.security.CommonUserDetails;
import org.mapstruct.*;

@Mapper(
        componentModel = "spring",
        injectionStrategy = InjectionStrategy.CONSTRUCTOR,
        unmappedTargetPolicy = ReportingPolicy.WARN,
        nullValueMapMappingStrategy = NullValueMappingStrategy.RETURN_DEFAULT,
        nullValueCheckStrategy = NullValueCheckStrategy.ALWAYS,
        nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE

)
public interface InfoDtoMapper {

    // target method(Source source)

    void updateUserDetails(@MappingTarget CommonUserDetails commonUserDetails, InfoDTO info);
}
