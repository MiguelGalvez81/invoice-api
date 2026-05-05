# Invoice API - Spring Boot + JWT

A comprehensive REST API for managing customers, invoices, and payments with JWT-based authentication.

## Features

✅ JWT Authentication & Authorization
✅ User Registration & Login
✅ Customer Management (CRUD)
✅ Invoice Tracking & Management
✅ Role-based Access Control
✅ Spring Security Integration
✅ MySQL Database Integration
✅ Lombok for Boilerplate Reduction

## Tech Stack

- **Java 17**
- **Spring Boot 3.2.0**
- **Spring Security**
- **Spring Data JPA**
- **JWT (JJWT 0.9.1)**
- **MySQL 8.0**
- **Lombok**
- **Maven**

## Project Structure

```
com.miguel.invoiceapi
├── controller/          # REST Controllers
├── service/             # Business Logic
├── repository/          # Data Access Layer
├── entity/              # JPA Entities
├── dto/                 # Data Transfer Objects
├── security/            # JWT & Security Configuration
├── config/              # Application Configuration
├── exception/           # Custom Exceptions
└── util/                # Utility Classes
```

## Installation & Setup

### Prerequisites

- Java 17 or higher
- MySQL 8.0
- Maven 3.6+

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/invoice-api.git
cd invoice-api
```

### 2. Create Database

```sql
CREATE DATABASE invoice_db;
USE invoice_db;
```

### 3. Configure Database Connection

Edit `src/main/resources/application.properties`:

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/invoice_db
spring.datasource.username=root
spring.datasource.password=your_password
```

### 4. Build the Project

```bash
mvn clean install
```

### 5. Run the Application

```bash
mvn spring-boot:run
```

The application will start on `http://localhost:8080`

## API Endpoints

### Authentication

| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/api/auth/login` | User Login |
| POST | `/api/auth/register` | User Registration |

### Customers

| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/api/customers` | Create Customer |
| GET | `/api/customers` | Get All Customers |
| GET | `/api/customers/{id}` | Get Customer by ID |
| PUT | `/api/customers/{id}` | Update Customer |
| DELETE | `/api/customers/{id}` | Delete Customer |

### Invoices

| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/api/invoices` | Create Invoice |
| GET | `/api/invoices` | Get All Invoices |
| GET | `/api/invoices/{id}` | Get Invoice by ID |
| GET | `/api/invoices/customer/{customerId}` | Get Invoices by Customer |
| PUT | `/api/invoices/{id}` | Update Invoice |
| DELETE | `/api/invoices/{id}` | Delete Invoice |

## Usage Examples

### 1. Register a New User

```bash
curl -X POST http://localhost:8080/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "username": "miguel",
    "password": "password123",
    "role": "ADMIN"
  }'
```

### 2. Login

```bash
curl -X POST http://localhost:8080/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "username": "miguel",
    "password": "password123"
  }'
```

Response:
```json
{
  "token": "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJtaWd1ZWwiLCJpYXQiOjE2ODM...",
  "message": "Login successful"
}
```

### 3. Create a Customer (with JWT Token)

```bash
curl -X POST http://localhost:8080/api/customers \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  -d '{
    "name": "John Doe",
    "email": "john@example.com"
  }'
```

### 4. Create an Invoice

```bash
curl -X POST http://localhost:8080/api/invoices \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  -d '{
    "amount": 1500.00,
    "status": "PENDING",
    "customer": {
      "id": 1
    }
  }'
```

### 5. Get All Invoices

```bash
curl -X GET http://localhost:8080/api/invoices \
  -H "Authorization: Bearer YOUR_JWT_TOKEN"
```

## JWT Configuration

The JWT token is configured with:
- **Algorithm**: HS512
- **Expiration**: 24 hours
- **Secret Key**: Configured in `JwtUtil.java`

⚠️ **IMPORTANT**: Change the secret key in production environment!

## Error Handling

The API returns proper HTTP status codes:

- `200 OK` - Successful request
- `201 Created` - Resource created
- `400 Bad Request` - Invalid input
- `401 Unauthorized` - Missing or invalid JWT
- `403 Forbidden` - Insufficient permissions
- `404 Not Found` - Resource not found
- `500 Internal Server Error` - Server error

## Security Considerations

1. ✅ CSRF protection disabled for stateless API
2. ✅ Password encryption using BCrypt
3. ✅ JWT token validation on each request
4. ✅ Role-based access control
5. ✅ Stateless session management

## Database Schema

### users table
```sql
CREATE TABLE users (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  username VARCHAR(255) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  role VARCHAR(50) NOT NULL
);
```

### customers table
```sql
CREATE TABLE customers (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL
);
```

### invoices table
```sql
CREATE TABLE invoices (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  amount DOUBLE NOT NULL,
  status VARCHAR(50) NOT NULL,
  customer_id BIGINT NOT NULL,
  FOREIGN KEY (customer_id) REFERENCES customers(id)
);
```

## Dependencies

- **spring-boot-starter-web**: Web application support
- **spring-boot-starter-security**: Security features
- **spring-boot-starter-data-jpa**: JPA repository support
- **mysql-connector-j**: MySQL database driver
- **jjwt**: JWT token creation and validation
- **lombok**: Boilerplate reduction

## Development

### Build

```bash
mvn clean build
```

### Run Tests

```bash
mvn test
```

### Package for Production

```bash
mvn clean package
```

This creates an executable JAR in `target/invoice-api-1.0.0.jar`

## Troubleshooting

### Database Connection Issues

```properties
# Ensure MySQL is running and credentials are correct
spring.datasource.url=jdbc:mysql://localhost:3306/invoice_db
spring.datasource.username=root
spring.datasource.password=your_password
```

### JWT Token Expired

Generate a new token by logging in again with `/api/auth/login`

### Port Already in Use

```bash
# Change port in application.properties
server.port=8081
```

## Future Enhancements

- [ ] Email notifications for invoice updates
- [ ] Payment gateway integration
- [ ] Invoice PDF generation
- [ ] Advanced reporting & analytics
- [ ] Two-factor authentication
- [ ] API rate limiting
- [ ] OpenAPI/Swagger documentation

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Author

**Miguel Galvez** - [GitHub Profile](https://github.com/MiguelGalvez81)

## Support

For support, email: miguel_galvez81@hotmail.com or open an issue on GitHub.

---

**Happy Coding! 🚀**
