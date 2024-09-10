import re
import pandas as pd
import matplotlib.pyplot as plt


def parse_docker_stats(file_path):
    with open(file_path, 'r') as f:
        lines = f.readlines()

    # Regex to extract the relevant columns
    regex = re.compile(
        r"([a-f0-9]+)\s+([^\s]+)\s+([\d\.]+%)\s+([\d\.]+MiB)\s+/\s+([\d\.]+GiB)\s+([\d\.]+%)\s+([^\s]+)\s+/\s+([^\s]+)\s+([^\s]+)\s+/\s+([^\s]+)\s+(\d+)")

    data = []

    # Extract data using regex
    for line in lines:
        match = regex.search(line)
        if match:
            data.append(match.groups())

    # Create a DataFrame
    columns = ['Container_ID', 'Name', 'CPU_Percent', 'Memory_Usage', 'Memory_Limit',
               'Memory_Percent', 'Net_IO_Received', 'Net_IO_Sent', 'Block_IO_Read', 'Block_IO_Write', 'PIDs']
    df = pd.DataFrame(data, columns=columns)

    # Convert percentage columns to numeric types
    df['CPU_Percent'] = df['CPU_Percent'].str.replace('%', '').astype(float)
    df['Memory_Percent'] = df['Memory_Percent'].str.replace('%', '').astype(float)

    return df


# Load and parse the docker stats data
df = parse_docker_stats('base5000.txt')

df['Time (s)'] = df.index // 2


# df[['Net_IO_Received', 'Net_IO_Sent']] = df['Net I/O'].str.split(' / ', expand=True)


def convert_to_mb(value):
    # Convert values like '20.1MB', '807kB', etc., into MB
    if 'kB' in value:
        return float(value.replace('kB', '')) / 1024  # Convert KB to MB
    elif 'MB' in value:
        return float(value.replace('MB', ''))
    elif 'GB' in value:
        return float(value.replace('GB', '')) * 1024  # Convert GB to MB
    return 0


def convert_memory(value):
    """Convert memory values to MB."""
    if 'MiB' in value:
        return float(value.replace('MiB', ''))
    elif 'GiB' in value:
        return float(value.replace('GiB', '')) * 1024  # Convert GiB to MB
    return 0


# Convert these columns to numeric values (MB)
df['Net_IO_Received_MB'] = df['Net_IO_Received'].apply(convert_to_mb)
df['Net_IO_Sent_MB'] = df['Net_IO_Sent'].apply(convert_to_mb)
df['Memory_Usage_MB'] = df['Memory_Usage'].apply(convert_memory)
df['Memory_Limit_MB'] = df['Memory_Limit'].apply(convert_memory)

# Split the DataFrame by container
container_1 = df[df['Name'] == 'crud_app-phoenix-1']
container_2 = df[df['Name'] == 'crud_app-postgres-1']


print(container_1.head())
container_1 = container_1.drop(columns=['Name', 'Container_ID', 'PIDs'])
container_2 = container_2.drop(columns=['Name', 'Container_ID', 'PIDs'])


# Plot for Container 1 (crud_app-phoenix-1)
plt.figure(figsize=(10, 6))
plt.plot(container_1['Time (s)'], container_1['CPU_Percent'], label='Phoenix', color='blue')
plt.xlabel('Time (seconds)')
plt.ylabel('CPU Usage (%)')
plt.title('CPU Usage Over Time for Phoenix Container')
plt.legend()
plt.grid(True)
plt.savefig('cpu_usage_phoenix.png')
print("Phoenix container CPU plot saved as 'cpu_usage_phoenix.png'")

# Plot for Container 2 (crud_app-postgres-1)
plt.figure(figsize=(10, 6))
plt.plot(container_2['Time (s)'], container_2['CPU_Percent'], label='Postgres', color='green')
plt.xlabel('Time (seconds)')
plt.ylabel('CPU Usage (%)')
plt.title('CPU Usage Over Time for Postgres Container')
plt.legend()
plt.grid(True)
plt.savefig('cpu_usage_postgres.png')
print("Postgres container CPU plot saved as 'cpu_usage_postgres.png'")


# Create a single figure and axes
plt.figure(figsize=(12, 8))

# Plot for Phoenix container
plt.plot(container_1['Time (s)'], container_1['Memory_Limit_MB'], label='Memory Limit (MB)', color='red')
plt.plot(container_1['Time (s)'], container_1['Memory_Usage_MB'], label='Phoenix Memory Usage (MB)', color='blue')

# Plot for Postgres container
plt.plot(container_2['Time (s)'], container_2['Memory_Usage_MB'],
         label='Postgres Memory Usage (MB)', color='green')

# Labeling
plt.xlabel('Time (seconds)')
plt.ylabel('Usage (MB)')
plt.title('Memory Usage and Memory Limit Over Time for Phoenix and Postgres Containers')
plt.legend()
plt.grid(True)

# Save the combined plot
plt.savefig('mem_usage.png')
print("Combined plot saved as 'mem_usage.png'")
