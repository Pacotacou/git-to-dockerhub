FROM docker:24.0.7-cli

# Install git
RUN apk add --no-cache git

# Copy the script
COPY builder.sh /builder.sh
RUN chmod +x /builder.sh

ENTRYPOINT ["/builder.sh"]
