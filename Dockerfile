FROM sonatype/nexus3:3.68.0

EXPOSE 8081/tcp 8082/tcp 8083/tcp

# Optional: Create a volume to store Nexus data
VOLUME /nexus-data

# Optional: Set environment variables
ENV NEXUS_HEAP_MIN=1024M
ENV NEXUS_HEAP_MAX=1024M
