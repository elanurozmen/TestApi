FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build-env
  WORKDIR /app

  COPY *.csproj .

  RUN dotnet restore

  COPY . ./

  RUN dotnet publish --no-restore -c Release -o out

  FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
  WORKDIR /app
  COPY --from=build-env /app/out  /app/
  ENTRYPOINT ["dotnet", "test.dll"]