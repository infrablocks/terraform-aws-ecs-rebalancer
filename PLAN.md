Plan
====

General Outline
---------------

- On a cron schedule
- Need environment variables indicating account ID, region, cluster
- Checking for whether re-balancing is required may be based on:
  - Number of containers per instance (count)
  - Remaining unreserved memory on each instance (mem-unreserved)
  - Remaining available memory on each instance (mem-available)
  - Remaining unreserved CPU on each instance (cpu-unreserved)
  - Remaining available CPU on each instance (cpu-available)
- Calculating whether to re-balance could be achieved with the following 
  approach:
  - Fetch all container instances
  - Calculate check parameter for each, potentially relative to the size of 
    the instance. This is easy enough for memory and CPU but more tricky for
    count. Need a proxy for total size of an instance. Could use memory + CPU 
    credits but that's a little strange if there a mix of instance classes,
    e.g., where ratios of mem:cpu are different.
  - Determine mean check parameter value.
  - Sort by check parameter, worst first
  - For each instance, if check parameter outside allowable variance execute 
    re-balance repeatedly until check parameter within allowable variance
- Performing re-balancing may be achieved through:
  - Redeploying services on overburdened instances through force redeploy 
    (redeploy-services)
  - Draining overburdened instances (drain-instances)

Questions
---------

- How do we handle existing placement constraints?
- How do we handle container instances of different sizes?

Links
-----

[https://people.richland.edu/james/ictcm/2001/descriptive/helpvariance.html](https://people.richland.edu/james/ictcm/2001/descriptive/helpvariance.html)
[https://github.com/maginetv/ecs-task-balancer](https://github.com/maginetv/ecs-task-balancer)
[https://docs.aws.amazon.com/AmazonECS/latest/developerguide/container-instance-draining.html](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/container-instance-draining.html)
[https://github.com/aws/containers-roadmap/issues/105](https://github.com/aws/containers-roadmap/issues/105)
