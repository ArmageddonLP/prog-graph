package com.arma.proggraph.converters;

import com.arma.proggraph.domain.Role;
import com.arma.proggraph.domain.RoleDto;
import org.springframework.stereotype.Component;

@Component
public class RoleConverter {
    public RoleDto fromDomain(Role role) {
        if (role == null) {
            return null;
        }
        return RoleDto.builder()
                .id(role.getId())
                .name(role.getName())
                .uniqueShorthand(role.getUniqueShorthand())
                .build();
    }

    public Role toDomain(RoleDto roleDto) {
        if (roleDto == null) {
            return null;
        }
        Role role = new Role();
        role.setId(roleDto.getId());
        role.setName(roleDto.getName());
        role.setUniqueShorthand(roleDto.getUniqueShorthand());
        return role;
    }
}
