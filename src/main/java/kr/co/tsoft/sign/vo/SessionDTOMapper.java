package kr.co.tsoft.sign.vo;

import org.mapstruct.InjectionStrategy;
import org.mapstruct.Mapper;
import org.mapstruct.MappingTarget;
import org.mapstruct.NullValueCheckStrategy;
import org.mapstruct.NullValueMappingStrategy;
import org.mapstruct.NullValuePropertyMappingStrategy;
import org.mapstruct.ReportingPolicy;

import kr.co.tsoft.sign.config.security.CommonUserDetails;
import kr.co.tsoft.sign.vo.ApiResponseData.Verify;

@Mapper(
        componentModel = "spring",
        injectionStrategy = InjectionStrategy.CONSTRUCTOR,
        unmappedTargetPolicy = ReportingPolicy.WARN,
        nullValueMapMappingStrategy = NullValueMappingStrategy.RETURN_DEFAULT,
        nullValueCheckStrategy = NullValueCheckStrategy.ALWAYS,
        nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE

)
public interface SessionDTOMapper {

    // target method(Source source)
	void updateUserDetails(@MappingTarget CommonUserDetails commonUserDetails, InfoDTO info);
	void updateUserDetails(@MappingTarget CommonUserDetails commonUserDetails, CertificationDTO cert);
	void updateUserDetails(@MappingTarget CommonUserDetails commonUserDetails, RequiredApiResponseDTO requiredApiResponse);
	void updateUserDetails(@MappingTarget CommonUserDetails commonUserDetails, ContractAttachmentDTO contractAttachment);
}
