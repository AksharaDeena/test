import time

def print_hello_world_and_sleep(iterations):
    for i in range(1, iterations + 1):
        print(f"Hello World {i}")
def run_for_two_minutes():
    start_time = time.time()
    while time.time() - start_time < 60:  # Run for 2 minutes (120 seconds)
        # Your code here
     #   pass 
        print(f"Hi")

def main():
    iterations = 4
    sleep_duration = 120  # 2 minutes in seconds

    print_hello_world_and_sleep(iterations)
    run_for_two_minutes()
#    time.sleep(sleep_duration)

if __name__ == "__main__":
    main()