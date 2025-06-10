FROM mcr.microsoft.com/dotnet/runtime:6.0 AS base
WORKDIR /app

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["SeminarskiRSII.RabbitMQConsumer.csproj", "SeminarskiRSII.RabbitMQConsumer/"]
RUN dotnet restore "SeminarskiRSII.RabbitMQConsumer/SeminarskiRSII.RabbitMQConsumer.csproj"

WORKDIR "/src/SeminarskiRSII.RabbitMQConsumer"
COPY . .

RUN dotnet build "SeminarskiRSII.RabbitMQConsumer.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "SeminarskiRSII.RabbitMQConsumer.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "SeminarskiRSII.RabbitMQConsumer.dll"]