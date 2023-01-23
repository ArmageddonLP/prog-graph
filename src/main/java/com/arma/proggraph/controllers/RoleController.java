package com.arma.proggraph.controllers;

import com.arma.proggraph.ProgGraphContext;
import com.arma.proggraph.domain.Role;
import com.arma.proggraph.domain.RoleDto;
import com.arma.proggraph.services.RoleService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@Slf4j
@RestController
@RequestMapping(value = ProgGraphContext.ROLE_API, produces = MediaType.APPLICATION_JSON_VALUE)
@RequiredArgsConstructor
public class RoleController { //TODO Role to RoleDto
    private final RoleService roleService;

    @RequestMapping(value = "", method = RequestMethod.GET)
    public ResponseEntity<List<Role>> findAll() {
        List<Role> roles = roleService.findAll();
        if (roles.isEmpty()) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(roles);
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public ResponseEntity<Role> findById(@PathVariable(value = "id") Long id) {
        Optional<Role> optionalRole = roleService.findById(id);
        return optionalRole.map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build());
    }

    @RequestMapping(value = "/query", method = RequestMethod.GET)
    public ResponseEntity<Role> findByUniqueShorthand(@RequestParam(value = "shorthand") String shorthand) {
        Optional<Role> optionalRole = roleService.findByUniqueShorthand(shorthand);
        return optionalRole.map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build());
    }

    @RequestMapping(value = "", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<RoleDto> save(@RequestBody RoleDto roleDto) {
        Optional<RoleDto> optionalRoleDto = roleService.save(roleDto);
        return optionalRoleDto.map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.unprocessableEntity().build());
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
    public ResponseEntity<Role> deleteById(@PathVariable(value = "id") Long id) {
        if (roleService.deleteById(id)) {
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.notFound().build();
    }
}
