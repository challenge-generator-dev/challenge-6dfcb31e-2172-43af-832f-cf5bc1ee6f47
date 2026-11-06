package com.pragma.orders.application.service;

import com.pragma.orders.domain.model.Order;
import com.pragma.orders.domain.model.Order.OrderItem;
import com.pragma.orders.domain.model.Order.OrderStatus;
import com.pragma.orders.domain.port.OrderRepository;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

public class OrderService {

    private final OrderRepository orderRepository;

    public OrderService(OrderRepository orderRepository) {
        this.orderRepository = orderRepository;
    }

    public Order createOrder(UUID customerId, List<OrderItem> items) {
        if (customerId == null) {
            throw new IllegalArgumentException("Customer ID cannot be null");
        }
        if (items == null || items.isEmpty()) {
            throw new IllegalArgumentException("Order must contain at least one item");
        }
        
        Order order = new Order(customerId, items);
        order.setStatus(OrderStatus.PENDING);
        return orderRepository.save(order);
    }

    public Optional<Order> getOrder(UUID orderId) {
        if (orderId == null) {
            throw new IllegalArgumentException("Order ID cannot be null");
        }
        return orderRepository.findById(orderId);
    }

    public Order updateOrder(UUID orderId, UUID customerId, List<OrderItem> items, OrderStatus status) {
        if (orderId == null) {
            throw new IllegalArgumentException("Order ID cannot be null");
        }
        
        Optional<Order> existingOrderOpt = orderRepository.findById(orderId);
        if (existingOrderOpt.isEmpty()) {
            throw new IllegalArgumentException("Order not found with id: " + orderId);
        }
        
        Order existingOrder = existingOrderOpt.get();
        
        if (customerId != null) {
            Order newOrder = new Order(customerId, items != null ? items : new ArrayList<>());
            newOrder.setStatus(status != null ? status : existingOrder.getStatus());
            newOrder.setId(orderId);
            newOrder.setCreatedAt(existingOrder.getCreatedAt());
            newOrder.setUpdatedAt(LocalDateTime.now());
            return orderRepository.save(newOrder);
        }
        
        if (status != null) {
            existingOrder.setStatus(status);
        }
        existingOrder.setUpdatedAt(LocalDateTime.now());
        return orderRepository.save(existingOrder);
    }

    public void deleteOrder(UUID orderId) {
        if (orderId == null) {
            throw new IllegalArgumentException("Order ID cannot be null");
        }
        orderRepository.deleteById(orderId);
    }

    public BigDecimal calculateOrderTotal(List<OrderItem> items) {
        if (items == null || items.isEmpty()) {
            return BigDecimal.ZERO;
        }
        return items.stream()
            .map(item -> item.getPrice().multiply(BigDecimal.valueOf(item.getQuantity())))
            .reduce(BigDecimal.ZERO, BigDecimal::add);
    }
}