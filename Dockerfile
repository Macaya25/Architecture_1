# Use the official Elixir image
FROM elixir:latest

# Set environment variables
ENV MIX_ENV=dev
ENV PHOENIX_SERVER_PORT=4000

# Set the working directory inside the container
WORKDIR /app

# Copy mix.exs and mix.lock files to the container
COPY mix.exs mix.lock ./

# Install dependencies
RUN mix deps.get
RUN apt-get update && apt-get install -y inotify-tools

# Copy the rest of the application files
COPY . .

# Ensure that dependencies are up-to-date
RUN mix deps.get --force

# Compile the application
RUN mix compile

# Expose port 4000
EXPOSE 4000

# Start the Phoenix server
CMD ["mix", "phx.server"]
