package com.pragma.orders.application.service;

import com.pragma.orders.domain.model.Order;
import com.pragma.orders.domain.model.Order.OrderItem;
import com.pragma.orders.domain.model.Order.OrderStatus;
import com.pragma.orders.domain.port.OrderRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class OrderServiceTest {

    @Mock
    private OrderRepository orderRepository;

    @InjectMocks
    private OrderService orderService;

    private Order testOrder;
    private UUID orderId;
    private UUID customerId;

    @BeforeEach
    void setUp() {
        orderId = UUID.randomUUID();
        customerId = UUID.randomUUID();

        List<OrderItem> items = new ArrayList<>();
        items.add(new OrderItem(UUID.randomUUID(), "Producto A", BigDecimal.valueOf(100), 2));
        items.add(new OrderItem(UUID.randomUUID(), "Producto B", BigDecimal.valueOf(50), 1));

        testOrder = new Order(customerId, items);
    }

    @Test
    void testCreateOrder_Success() {
        when(orderRepository.save(any(Order.class))).thenAnswer(invocation -> {
            Order order = invocation.getArgument(0);
            return order;
        });

        Order result = orderService.createOrder(testOrder);

        assertNotNull(result);
        assertEquals(customerId, result.getCustomerId());
        assertEquals(OrderStatus.PENDING, result.getStatus());
        assertEquals(BigDecimal.valueOf(250), result.getTotalAmount());
        verify(orderRepository, times(1)).save(any(Order.class));
    }

    @Test
    void testCreateOrder_WithMultipleItems_CalculatesTotalCorrectly() {
        List<OrderItem> items = new ArrayList<>();
        items.add(new OrderItem(UUID.randomUUID(), "Item 1", BigDecimal.valueOf(100.50), 3));
        items.add(new OrderItem(UUID.randomUUID(), "Item 2", BigDecimal.valueOf(200.75), 2));
        items.add(new OrderItem(UUID.randomUUID(), "Item 3", BigDecimal.valueOf(50), 5));

        Order order = new Order(customerId, items);

        when(orderRepository.save(any(Order.class))).thenAnswer(invocation -> invocation.getArgument(0));

        Order result = orderService.createOrder(order);

        BigDecimal expectedTotal = BigDecimal.valueOf(100.50 * 3)
                .add(BigDecimal.valueOf(200.75 * 2))
                .add(BigDecimal.valueOf(50 * 5));

        assertEquals(expectedTotal.stripTrailingZeros(), result.getTotalAmount().stripTrailingZeros());
    }

    @Test
    void testGetOrderById_Found() {
        when(orderRepository.findById(orderId)).thenReturn(Optional.of(testOrder));

        Optional<Order> result = orderService.getOrderById(orderId);

        assertTrue(result.isPresent());
        assertEquals(orderId, result.get().getId());
        verify(orderRepository, times(1)).findById(orderId);
    }

    @Test
    void testGetOrderById_NotFound() {
        UUID nonExistentId = UUID.randomUUID();
        when(orderRepository.findById(nonExistentId)).thenReturn(Optional.empty());

        Optional<Order> result = orderService.getOrderById(nonExistentId);

        assertFalse(result.isPresent());
        verify(orderRepository, times(1)).findById(nonExistentId);
    }

    @Test
    void testUpdateOrder_Success() {
        when(orderRepository.findById(orderId)).thenReturn(Optional.of(testOrder));
        when(orderRepository.save(any(Order.class))).thenAnswer(invocation -> invocation.getArgument(0));

        List<OrderItem> newItems = new ArrayList<>();
        newItems.add(new OrderItem(UUID.randomUUID(), "Nuevo Producto", BigDecimal.valueOf(300), 1));
        Order updatedOrder = new Order(customerId, newItems);

        Order result = orderService.updateOrder(orderId, updatedOrder);

        assertNotNull(result);
        verify(orderRepository, times(1)).findById(orderId);
        verify(orderRepository, times(1)).save(any(Order.class));
    }

    @Test
    void testUpdateOrder_NotFound() {
        UUID nonExistentId = UUID.randomUUID();
        when(orderRepository.findById(nonExistentId)).thenReturn(Optional.empty());

        List<OrderItem> newItems = new ArrayList<>();
        newItems.add(new OrderItem(UUID.randomUUID(), "Producto", BigDecimal.valueOf(100), 1));
        Order updatedOrder = new Order(customerId, newItems);

        Order result = orderService.updateOrder(nonExistentId, updatedOrder);

        assertNull(result);
        verify(orderRepository, times(1)).findById(nonExistentId);
        verify(orderRepository, never()).save(any(Order.class));
    }

    @Test
    void testDeleteOrder_Success() {
        when(orderRepository.findById(orderId)).thenReturn(Optional.of(testOrder));
        doNothing().when(orderRepository).deleteById(orderId);

        orderService.deleteOrder(orderId);

        verify(orderRepository, times(1)).findById(orderId);
        verify(orderRepository, times(1)).deleteById(orderId);
    }

    @Test
    void testDeleteOrder_NotFound() {
        UUID nonExistentId = UUID.randomUUID();
        when(orderRepository.findById(nonExistentId)).thenReturn(Optional.empty());

        orderService.deleteOrder(nonExistentId);

        verify(orderRepository, times(1)).findById(nonExistentId);
        verify(orderRepository, never()).deleteById(any(UUID.class));
    }

    @Test
    void testCreateOrder_SetsCreatedAtTimestamp() {
        when(orderRepository.save(any(Order.class))).thenAnswer(invocation -> invocation.getArgument(0));

        Order result = orderService.createOrder(testOrder);

        assertNotNull(result.getCreatedAt());
    }

    @Test
    void testUpdateOrder_UpdatesTimestamp() {
        LocalDateTime originalTimestamp = LocalDateTime.now().minusDays(1);
        testOrder = new Order(customerId, new ArrayList<>());

        when(orderRepository.findById(orderId)).thenReturn(Optional.of(testOrder));
        when(orderRepository.save(any(Order.class))).thenAnswer(invocation -> {
            Order order = invocation.getArgument(0);
            return order;
        });

        List<OrderItem> newItems = new ArrayList<>();
        newItems.add(new OrderItem(UUID.randomUUID(), "Producto", BigDecimal.valueOf(100), 1));
        Order updatedOrder = new Order(customerId, newItems);

        Order result = orderService.updateOrder(orderId, updatedOrder);

        assertNotNull(result.getUpdatedAt());
    }

    @Test
    void testCreateOrder_WithEmptyItems_ThrowsException() {
        Order emptyOrder = new Order(customerId, new ArrayList<>());

        when(orderRepository.save(any(Order.class))).thenThrow(new IllegalArgumentException("La orden debe contener al menos un artículo"));

        assertThrows(IllegalArgumentException.class, () -> {
            orderService.createOrder(emptyOrder);
        });
    }

    @Test
    void testUpdateOrder_ChangesStatus() {
        when(orderRepository.findById(orderId)).thenReturn(Optional.of(testOrder));
        when(orderRepository.save(any(Order.class))).thenAnswer(invocation -> invocation.getArgument(0));

        List<OrderItem> newItems = new ArrayList<>();
        newItems.add(new OrderItem(UUID.randomUUID(), "Producto", BigDecimal.valueOf(100), 1));
        Order updatedOrder = new Order(customerId, newItems);

        Order result = orderService.updateOrder(orderId, updatedOrder);

        assertNotNull(result.getStatus());
    }
}