package com.pragma.orders.infrastructure.adapter;




import com.pragma.orders.domain.model.OrderStatus;
import com.pragma.orders.domain.model.OrderItem;
import com.pragma.orders.infrastructure.repository.SpringDataOrderRepository;
import com.pragma.orders.domain.model.Order;
import com.pragma.orders.domain.port.OrderRepository;
import com.pragma.orders.infrastructure.entity.OrderEntity;
import com.pragma.orders.infrastructure.entity.OrderItemEntity;
import org.springframework.stereotype.Component;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

@Component
public class OrderJpaRepository implements OrderRepository {

    private final SpringDataOrderRepository springDataOrderRepository;

    public OrderJpaRepository(SpringDataOrderRepository springDataOrderRepository) {
        this.springDataOrderRepository = springDataOrderRepository;
    }

    @Override
    public Order save(Order order) {
        OrderEntity entity = toEntity(order);
        OrderEntity savedEntity = springDataOrderRepository.save(entity);
        return toDomain(savedEntity);
    }

    @Override
    public Optional<Order> findById(UUID id) {
        return springDataOrderRepository.findById(id).map(this::toDomain);
    }

    @Override
    public void deleteById(UUID id) {
        springDataOrderRepository.deleteById(id);
    }

    private OrderEntity toEntity(Order order) {
        OrderEntity entity = new OrderEntity();
        entity.setId(order.getId());
        entity.setCustomerId(order.getCustomerId());
        entity.setStatus(order.getStatus().name());
        entity.setTotalAmount(order.getTotalAmount());
        entity.setCreatedAt(order.getCreatedAt());
        entity.setUpdatedAt(order.getUpdatedAt());

        List<OrderItemEntity> itemEntities = order.getItems().stream()
                .map(item -> {
                    OrderItemEntity itemEntity = new OrderItemEntity();
                    itemEntity.setOrder(entity);
                    itemEntity.setProductId(item.getProductId());
                    itemEntity.setProductName(item.getProductName());
                    itemEntity.setPrice(item.getPrice());
                    itemEntity.setQuantity(item.getQuantity());
                    return itemEntity;
                })
                .collect(Collectors.toList());

        entity.setItems(itemEntities);
        return entity;
    }

    private Order toDomain(OrderEntity entity) {
        List<Order.OrderItem> items = entity.getItems().stream()
                .map(item -> new Order.OrderItem(
                        item.getProductId(),
                        item.getProductName(),
                        item.getPrice(),
                        item.getQuantity()
                ))
                .collect(Collectors.toList());

        Order order = new Order(entity.getCustomerId(), items);
        order.setStatus(Order.OrderStatus.valueOf(entity.getStatus()));
        return order;
    }
}