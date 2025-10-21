# Use the official ASP.NET runtime as base image
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 8080

# Use SDK image to build the app
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy the .csproj from repo root (this Dockerfile is at repo root)
COPY ["AdminServerStub.csproj", "./"]
RUN dotnet restore "AdminServerStub.csproj"

# Copy all source files
COPY . .

# Build the project
RUN dotnet build "AdminServerStub.csproj" -c Release -o /app/build

# Publish the app
FROM build AS publish
RUN dotnet publish "AdminServerStub.csproj" -c Release -o /app/publish --no-restore

# Final stage - copy published files and set entry point
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .

# Start the application (DLL name matches project name)
ENTRYPOINT ["dotnet", "AdminServerStub.dll"]
