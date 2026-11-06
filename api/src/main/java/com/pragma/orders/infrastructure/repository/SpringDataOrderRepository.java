package com.pragma.orders.infrastructure.repository;

import com.pragma.orders.infrastructure.entity.OrderEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.UUID;

@Repository
public interface SpringDataOrderRepository extends JpaRepository<OrderEntity, UUID> {
}