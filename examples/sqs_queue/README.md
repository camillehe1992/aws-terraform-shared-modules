# SQS Queue Example

The example demonstrates how to use the shared modules to create SQS queues in AWS with various configurations including standard queues, FIFO queues, dead letter queues, and encryption.

The example uses the following shared modules:

| Shared Module | Description                    |
| ------------- | ------------------------------ |
| sqs_queue     | Create SQS queues with various configurations |

## SQS Queue Configurations

This example creates two types of SQS queues:

1. **Standard Queue**: A standard SQS queue with dead letter queue and encryption
2. **FIFO Queue**: A FIFO queue with content-based deduplication and dead letter queue

### Features Demonstrated

- **Standard Queue**: Basic queue with long polling, dead letter queue, and encryption
- **FIFO Queue**: First-In-First-Out queue with deduplication and dead letter queue
- **Dead Letter Queue**: Automatic message retry handling with DLQ configuration
- **Encryption**: Server-side encryption using AWS-managed KMS keys
- **Long Polling**: Reduced API calls and improved message delivery efficiency

## Queue Configuration

### Standard Queue Configuration
- **Name**: `example-standard-queue`
- **Message Retention**: 4 days (345,600 seconds)
- **Visibility Timeout**: 30 seconds
- **Long Polling**: 10 seconds
- **Dead Letter Queue**: Enabled with max 3 retries
- **Encryption**: Enabled with AWS-managed KMS key

### FIFO Queue Configuration
- **Name**: `example-fifo-queue.fifo`
- **Message Retention**: 4 days (345,600 seconds)
- **Visibility Timeout**: 30 seconds
- **Long Polling**: 10 seconds
- **Content-Based Deduplication**: Enabled
- **Dead Letter Queue**: Enabled with max 3 retries
- **Encryption**: Enabled with AWS-managed KMS key

## Provision Resources

In the `examples/sqs_queue` directory, run the following `just` commands:

```bash
# plan and apply resources
just quick-apply

# output resources
just output

# view queue URLs
just output | jq '.standard_queue_url'
just output | jq '.fifo_queue_url'
```

## Test the Queues

After deployment, you can test the queues using AWS CLI:

```bash
# Send a message to standard queue
aws sqs send-message --queue-url $(just output | jq -r '.standard_queue_url') --message-body "Hello World"

# Send a message to FIFO queue
aws sqs send-message --queue-url $(just output | jq -r '.fifo_queue_url') --message-body "Hello FIFO" --message-group-id "group1"

# Receive messages from standard queue
aws sqs receive-message --queue-url $(just output | jq -r '.standard_queue_url')

# Receive messages from FIFO queue
aws sqs receive-message --queue-url $(just output | jq -r '.fifo_queue_url')
```

## Clean up Resources

For cost saving, please clean up the resources after the demo.

```bash
just quick-destroy
```

## Additional Resources

- [AWS SQS Documentation](https://docs.aws.amazon.com/sqs/)
- [SQS Best Practices](https://docs.aws.amazon.com/sqs/latest/dg/sqs-best-practices.html)
- [FIFO Queues](https://docs.aws.amazon.com/sqs/latest/dg/FIFO-queues.html)
- [Dead Letter Queues](https://docs.aws.amazon.com/sqs/latest/dg/sqs-dead-letter-queues.html)
