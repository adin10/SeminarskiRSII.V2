FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base    
WORKDIR /app
EXPOSE 5001
ENV ASPNETCORE_URLS=http://+:5050

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["SeminarskiRSII.WebApi.csproj", "SeminarskiRSII.WebApi/"]
RUN dotnet restore "SeminarskiRSII.WebApi.csproj"
COPY . .
WORKDIR "/src/SeminarskiRSII.WebApi"
RUN dotnet build "SeminarskiRSII.WebApi.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "SeminarskiRSII.WebApi.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "SeminarskiRSII.WebApi.dll"]