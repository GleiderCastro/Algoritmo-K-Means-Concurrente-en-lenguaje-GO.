# Usar una imagen base de Go
FROM golang:1.22.2 as build

# Establecer el directorio de trabajo
WORKDIR /app

# Copiar los archivos de go.mod y go.sum para descargar las dependencias
COPY go.mod go.sum ./

# Descargar dependencias
RUN go mod download

# Copiar el código fuente de la aplicación
COPY . .

# Compilar la aplicación
RUN go build -o main .

# Usar una imagen base más ligera para el contenedor final
FROM alpine:latest

# Instalar las dependencias necesarias
RUN apk --no-cache add ca-certificates

# Establecer el directorio de trabajo
WORKDIR C:/Users/Gleider/Documents/CICLO 2024-01/PROGRAMACION CONCURRENTE Y DISTRIBUIDA/TRABAJO FINAL/TFconcurrente_copia/main.go

# Copiar el binario compilado desde la fase de build
COPY --from=build /app/main .

# Copiar la carpeta static con los archivos HTML, CSS y JS
COPY --from=build /app/static ./static

# Exponer el puerto en el que la aplicación se ejecutará
EXPOSE 8080

# Comando para ejecutar la aplicación
CMD ["./main"]
