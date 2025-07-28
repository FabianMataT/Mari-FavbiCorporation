# Etapa 1: Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copiar la solución y el proyecto (carpeta incluida)
COPY *.sln ./
COPY MariFabiCorporation/*.csproj ./MariFabiCorporation/

# Copiar el resto del código
COPY . ./

# Restaurar y publicar
WORKDIR /app/MariFabiCorporation
RUN dotnet restore
RUN dotnet publish -c Release -o /app/out

# Etapa 2: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/out ./

ENTRYPOINT ["dotnet", "MariFabiCorporation.dll"]
