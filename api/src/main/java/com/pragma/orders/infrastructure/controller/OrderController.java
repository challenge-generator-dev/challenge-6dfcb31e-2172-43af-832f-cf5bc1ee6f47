package com.pragma.orders.infrastructure.controller;

import com.pragma.orders.application.service.OrderService;
import com.pragma.orders.domain.model.Order;
import com.pragma.orders.domain.model.Order.OrderItem;
import com.pragma.orders.domain.model.Order.OrderStatus;
import com.pragma.orders.infrastructure.controller.dto.OrderRequest;
import com.pragma.orders.infrastructure.controller.dto.OrderResponse;
import com.pragma.orders.infrastructure.controller.dto.OrderItemRequest;
import com.pragma.orders.infrastructure.controller.dto.OrderItemResponse;
import java.net.URI;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.util.UriComponentsBuilder;

@RestController
@RequestMapping("/orders")
public class OrderController {

    private final OrderService orderService;

    public OrderController(OrderService orderService) {
        this.orderService = orderService;
    }

    @PostMapping
    public ResponseEntity<OrderResponse> createOrder(@RequestBody OrderRequest request) {
        List<OrderItem> items = request.getItems().stream()
            .map(this::mapToOrderItem)
            .collect(Collectors.toList());
        
        Order order = orderService.createOrder(request.getCustomerId(), items);
        OrderResponse response = mapToResponse(order);
        
        URI location = UriComponentsBuilder.fromPath("/orders/{id}")
            .buildAndExpand(response.getId())
            .toUri();
        
        return ResponseEntity.created(location).body(response);
    }

    @GetMapping("/{id}")
    public ResponseEntity<OrderResponse> getOrder(@PathVariable UUID id) {
        return orderService.getOrder(id)
            .map(order -> ResponseEntity.ok(mapToResponse(order)))
            .orElse(ResponseEntity.notFound().build());
    }

    @PutMapping("/{id}")
    public ResponseEntity<OrderResponse> updateOrder(
            @PathVariable UUID id,
            @RequestBody OrderRequest request) {
        
        List<OrderItem> items = request.getItems() != null 
            ? request.getItems().stream()
                .map(this::mapToOrderItem)
                .collect(Collectors.toList())
            : null;
        
        OrderStatus status = request.getStatus() != null 
            ? OrderStatus.valueOf(request.getStatus()) 
            : null;
        
        try {
            Order updatedOrder = orderService.updateOrder(id, request.getCustomerId(), items, status);
            return ResponseEntity.ok(mapToResponse(updatedOrder));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteOrder(@PathVariable UUID id) {
        orderService.deleteOrder(id);
        return ResponseEntity.noContent().build();
    }

    private OrderItem mapToOrderItem(OrderItemRequest request) {
        OrderItem item = new OrderItem(
            request.getProductId(),
            request.getProductName(),
            request.getPrice(),
            request.getQuantity()
        );
        return item;
    }

    private OrderResponse mapToResponse(Order order) {
        List<OrderItemResponse> itemResponses = order.getItems().stream()
            .map(item -> new OrderItemResponse(
                item.getProductId(),
                item.getProductName(),
                item.getPrice(),
                item.getQuantity()
            ))
            .collect(Collectors.toList());
        
        return new OrderResponse(
            order.getId(),
            order.getCustomerId(),
            itemResponses,
            order.getStatus().name(),
            order.getTotalAmount(),
            order.getCreatedAt(),
            order.getUpdatedAt()
        );
    }
}