# Build a Batch Job Definition

The example shows how to build a Batch Job Definition and submit a job to the Batch Job Queue. After the job is submitted, it will check the job status until it is completed.

In the exmaple, we will provision a Batch Compute Environment, a Batch Job Queue, and a Batch Job Definition. We will use another two shared-modules `batch_compute_environment` and `batch_job_queue` to provision the Batch Compute Environment and Batch Job Queue.

## Provision Batch Resources

Use below `just` recipes from current directory:

### Provision Batch Compute Environment

You can provision a Batch Compute Environment by running the following commands:

```bash
just plan batch_compute_environment
just apply batch_compute_environment
```

### Provision Batch Job Queue

You can provision a Batch Job Queue by running the following commands:

```bash
just plan batch_job_queue
just apply batch_job_queue
```

### Provision Batch Job Definition

Then you can provision a Batch Job Definition by running the following commands:

```bash
just plan batch_job_definition
just apply batch_job_definition
```

## Submit a Batch Job and Check Job Status

Now, you can submit a Batch Job and check the job status by running the following commands:

```bash
just submit-job
```

## Clean Up

After you finish the example, you can clean up the resources by running the following commands in order:

```bash
just destroy-apply batch_job_definition
just destroy-apply batch_job_queue
just destroy-apply batch_compute_environment
```
