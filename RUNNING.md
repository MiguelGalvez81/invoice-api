# Invoice API - Running Guide

## Quick Start

### Step 1: Database Setup

Execute the SQL script to create the database:

```bash
mysql -u root -p < setup-database.sql
```

Or manually in MySQL:

```sql
CREATE DATABASE invoice_db;
```

### Step 2: Build & Run

```bash
# Build the project
mvn clean install

# Run the application
mvn spring-boot:run
```

The API will be available at: **http://localhost:8080**

## Testing the API

### 1️⃣ Register a User

```bash
curl -X POST http://localhost:8080/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "username": "admin",
    "password": "admin123"
  }'
```

### 2️⃣ Login

```bash
curl -X POST http://localhost:8080/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "username": "admin",
    "password": "admin123"
  }'
```

Copy the `token` from the response.

### 3️⃣ Create a Customer

Replace `YOUR_TOKEN` with the token from login response:

```bash
curl -X POST http://localhost:8080/api/customers \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -d '{
    "name": "John Company",
    "email": "john@company.com"
  }'
```

### 4️⃣ Get All Customers

```bash
curl -X GET http://localhost:8080/api/customers \
  -H "Authorization: Bearer YOUR_TOKEN"
```

### 5️⃣ Create an Invoice

```bash
curl -X POST http://localhost:8080/api/invoices \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -d '{
    "amount": 1500.00,
    "status": "PENDING",
    "customer": {
      "id": 1
    }
  }'
```

## Available Endpoints

### Auth
- `POST /api/auth/login` - Login
- `POST /api/auth/register` - Register

### Customers  
- `POST /api/customers` - Create
- `GET /api/customers` - List all
- `GET /api/customers/{id}` - Get by ID
- `PUT /api/customers/{id}` - Update
- `DELETE /api/customers/{id}` - Delete

### Invoices
- `POST /api/invoices` - Create
- `GET /api/invoices` - List all
- `GET /api/invoices/{id}` - Get by ID
- `GET /api/invoices/customer/{customerId}` - Get by customer
- `PUT /api/invoices/{id}` - Update
- `DELETE /api/invoices/{id}` - Delete

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Database connection error | Ensure MySQL is running and database exists |
| 401 Unauthorized | Check token is included in Authorization header |
| 404 Not Found | Verify resource ID exists |
| Port 8080 in use | Change `server.port` in application.properties |

## Environment Variables (Optional)

Create `application-local.properties`:

```properties
spring.datasource.username=root
spring.datasource.password=your_password
```

Then run with: `mvn spring-boot:run -Dspring.profiles.active=local`

---

**Enjoy! 🎉**
