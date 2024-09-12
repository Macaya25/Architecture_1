# CrudApp

To start the app you can use docker, the usual command will execute the compose file that has the Phoenix app itself along the Postgre instance.

```bash
docker compose up -d
```



# Graphs
For building the graphs on the report document we used the visualize_data.py file, which reads a file specified on line 35. This file was made using:

```bash
docker stats > 'file_name'
```

After that the the python scripts generates 3 graphs, the first one has the CPU usage of both the server and the db containers while the other 2 graphs are for the memory usage of each container. The file must be run with Python

```bash
python visualize_data.py
```
