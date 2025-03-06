bash
#!/bin/bash

#Define the instance deletion function
delete_instance() {
  instance_name=$1
  echo "Deleting instance $instance_name..."
  # Replace this with your actual instance deletion command
  sleep 2 # Simulate instance deletion time
  echo "Instance $instance_name deleted."
}

Delete the 3 instances in parallel
for i in {1..3}; do
  instance_name="instance-$i"
  delete_instance "$instance_name" &
done

Wait for all background jobs to finish
wait

echo "All instances deleted."
