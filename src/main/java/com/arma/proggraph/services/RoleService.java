package com.arma.proggraph.services;

import com.arma.proggraph.converters.RoleConverter;
import com.arma.proggraph.domain.Role;
import com.arma.proggraph.domain.RoleDto;
import com.arma.proggraph.repositories.RoleRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Slf4j
@Service
@RequiredArgsConstructor
public class RoleService { //TODO Role to RoleDto
    private final RoleRepository roleRepository;
    private final RoleConverter roleConverter;

    public Optional<RoleDto> save(RoleDto roleDto) {
        Optional<RoleDto> optionalRoleDto;
        try {
            optionalRoleDto = Optional.of(roleConverter.fromDomain(roleRepository.save(roleConverter.toDomain(roleDto))));
        } catch (Exception e) {
            optionalRoleDto = Optional.empty();
        }
        return optionalRoleDto;
    }

    public Optional<Role> findByUniqueShorthand(String shorthand) {
        return roleRepository.findByUniqueShorthand(shorthand);
    }

    public Optional<Role> findById(Long id) {
        return roleRepository.findById(id);
    }

    public List<Role> findAll() {
        return roleRepository.findAll();
    }

    public Boolean deleteById(Long id) {
        boolean deleted;
        try {
            roleRepository.deleteById(id);
            deleted = true;
        } catch (Exception e) {
            deleted = false;
        }
        return deleted;
    }

}
