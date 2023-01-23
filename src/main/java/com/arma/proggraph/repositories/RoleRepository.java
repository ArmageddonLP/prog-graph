package com.arma.proggraph.repositories;

import com.arma.proggraph.domain.Role;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface RoleRepository extends JpaRepository<Role, Long> {
    Optional<Role> findByUniqueShorthand(String shorthand);
}
