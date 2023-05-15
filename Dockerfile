FROM mcr.microsoft.com/dotnet/aspnet:6.0-bullseye-slim AS base    
WORKDIR /app

FROM mcr.microsoft.com/dotnet/sdk:6.0-bullseye-slim AS build
WORKDIR /src
COPY . .

FROM build AS publish
RUN dotnet publish "SeminarskiRSII.WebApi" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "SeminarskiRSII.WebApi.dll"]