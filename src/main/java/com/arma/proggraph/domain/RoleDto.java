package com.arma.proggraph.domain;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class RoleDto {
    private Long id;
    private String name;
    private String uniqueShorthand;
}
