package com.pragma.orders.infrastructure.config;

import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.dynamodbv2.AmazonDynamoDBAsync;
import com.amazonaws.services.dynamodbv2.AmazonDynamoDBAsyncClientBuilder;
import com.amazonaws.services.sqs.AmazonSQSAsync;
import com.amazonaws.services.sqs.AmazonSQSAsyncClientBuilder;
import java.net.URI;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class AwsConfig {

    @Value("${aws.access.key.id:}")
    private String accessKeyId;

    @Value("${aws.secret.access.key:}")
    private String secretAccessKey;

    @Value("${aws.region:us-east-1}")
    private String region;

    @Value("${aws.endpoint.override:}")
    private String endpointOverride;

    @Bean
    public BasicAWSCredentials awsCredentials() {
        if (accessKeyId == null || accessKeyId.isEmpty() || secretAccessKey == null || secretAccessKey.isEmpty()) {
            return null;
        }
        return new BasicAWSCredentials(accessKeyId, secretAccessKey);
    }

    @Bean
    public AmazonSQSAsync amazonSQSAsync() {
        AmazonSQSAsyncClientBuilder builder = AmazonSQSAsyncClientBuilder.standard()
            .withRegion(Regions.fromName(region));
        
        if (endpointOverride != null && !endpointOverride.isEmpty()) {
            builder.withEndpointConfiguration(
                new com.amazonaws.client.builder.AwsClientBuilder.EndpointConfiguration(
                    endpointOverride,
                    region
                )
            );
        }
        
        BasicAWSCredentials credentials = awsCredentials();
        if (credentials != null) {
            builder.withCredentials(new AWSStaticCredentialsProvider(credentials));
        }
        
        return builder.build();
    }

    @Bean
    public AmazonDynamoDBAsync amazonDynamoDBAsync() {
        AmazonDynamoDBAsyncClientBuilder builder = AmazonDynamoDBAsyncClientBuilder.standard()
            .withRegion(Regions.fromName(region));
        
        if (endpointOverride != null && !endpointOverride.isEmpty()) {
            builder.withEndpointConfiguration(
                new com.amazonaws.client.builder.AwsClientBuilder.EndpointConfiguration(
                    endpointOverride,
                    region
                )
            );
        }
        
        BasicAWSCredentials credentials = awsCredentials();
        if (credentials != null) {
            builder.withCredentials(new AWSStaticCredentialsProvider(credentials));
        }
        
        return builder.build();
    }
}