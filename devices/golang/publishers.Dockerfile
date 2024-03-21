FROM golang:alpine AS build

ARG DEVICE_NAME

WORKDIR /build

# First install library dependencies
# (These are expensive to download and change rarely;
# doing this once up front saves time on rebuilds)
COPY go.mod go.sum ./
RUN go mod download

# Copy the whole application tree in
COPY . .

# Build the specific component we want to run
RUN go build -o device ./cmd/${DEVICE_NAME}

# Final runtime image:
FROM alpine
# Get the built binary
COPY --from=build /build/device /usr/bin
# And set it as the main container command
CMD ["device"]