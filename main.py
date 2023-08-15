import time

def print_hello_world_and_sleep(iterations):
    for i in range(1, iterations + 1):
        print(f"Hello World {i}")
        

def main():
    iterations = 5
    sleep_duration = 120  # 2 minutes in seconds

    print_hello_world_and_sleep(iterations)
    time.sleep(sleep_duration)

if __name__ == "__main__":
    main()