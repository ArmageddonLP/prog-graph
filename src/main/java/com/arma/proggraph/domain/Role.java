package com.arma.proggraph.domain;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "roles")
public class Role {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "roles_generator")
    @SequenceGenerator(name = "roles_generator", sequenceName = "roles_seq", allocationSize = 1)
    @Column(name = "role_id")
    private Long id;
    @Column(name = "role_name")
    private String name;
    @Column(name = "role_unique_shorthand")
    private String uniqueShorthand;
}
