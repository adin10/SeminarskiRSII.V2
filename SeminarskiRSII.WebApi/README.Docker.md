### Building and running your application

When you're ready, start your application by running from the root folder where docker-compose.yaml file is located:
`docker compose up --build`.

Your application will be available at http://localhost:8080.

After running the docker compose up command, connect to the sql server via SSMS, add the backup to the server to be able to restore it.

First create backup folder in the sql server: docker exec -it ib210330_sqlserver mkdir -p /var/opt/mssql/backup

Then copy the backup file to the created folder: docker cp /your-local/path/backup_file ib210330_sqlserver:/var/opt/mssql/backup/

After backup is moved to the sql server, it can be restored via SSMS (Management Studio)

### Deploying your application to the cloud

First, build your image, e.g.: `docker build -t myapp .`.
If your cloud uses a different CPU architecture than your development
machine (e.g., you are on a Mac M1 and your cloud provider is amd64),
you'll want to build the image for that platform, e.g.:
`docker build --platform=linux/amd64 -t myapp .`.

Then, push it to your registry, e.g. `docker push myregistry.com/myapp`.

Consult Docker's [getting started](https://docs.docker.com/go/get-started-sharing/)
docs for more detail on building and pushing.

### References
* [Docker's .NET guide](https://docs.docker.com/language/dotnet/)
* The [dotnet-docker](https://github.com/dotnet/dotnet-docker/tree/main/samples)
  repository has many relevant samples and docs.
  
  
