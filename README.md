# Task Management System
Full-stack ứng dụng quản lý công việc cá nhân với Laravel Backend + Vue.js Frontend.

## Live Demo
### **Production Links**
- **Frontend (Vue.js)**: https://hmn011104.github.io/TaskFrontend
- **Backend API (Laravel)**: https://taskbackend-vrp7.onrender.com/api
- **API Documentation**: https://taskbackend-vrp7.onrender.com/api/test

### **Database Info**  
- **Type**: PostgreSQL on Render
- **Connection**: `dpg-d2q06eidbo4c73bmouig-a.render.com:5432`
- **Database**: `taskbackend_db`

## Project Structure
```
TaskPJ/                   ← This repo (submodules)
├── README.md            ← This file
├── database.sql         ← Database schema & setup
├── Backend/             ← Laravel API (Submodule → TaskBackend)
└── Frontend/            ← Vue.js App (Submodule → TaskFrontend)
```

## Separate Repositories
This project uses **Git Submodules** to manage components:

### Backend Repository
- **GitHub**: https://github.com/HMN011104/TaskBackend
- **Technology**: Laravel 12 + PostgreSQL + Sanctum Auth
- **Deployment**: Render.com
- **Live API**: https://taskbackend-vrp7.onrender.com/api

### Frontend Repository  
- **GitHub**: https://github.com/HMN011104/TaskFrontend
- **Technology**: Vue.js 3 + Axios + CSS
- **Deployment**: GitHub Pages
- **Live App**: https://hmn011104.github.io/TaskFrontend

## Quick Start

### Option 1: Use Live Demo (Fastest)
1. Visit frontend: https://hmn011104.github.io/TaskFrontend
2. Register/Login to test full functionality
3. API automatically connects to backend

### Option 2: Clone with Submodules
```bash
# Clone with all submodules
git clone --recursive https://github.com/HMN011104/TaskPJ.git

# Or if already cloned
git submodule init
git submodule update
```

### Option 3: Run Database Script
```bash
# If you have PostgreSQL
psql -U postgres -d your_db -f database.sql
```

### Option 4: Full Local Setup
```bash
# Backend
cd Backend/
composer install
cp .env.example .env
php artisan key:generate
touch database/database.sqlite
php artisan migrate
php artisan serve

# Frontend (new terminal)
cd Frontend/
npm install
npm run dev
```

## Technology Stack

### Backend (Laravel)
- **Framework**: Laravel 12
- **Database**: PostgreSQL (Production), SQLite (Local)
- **Authentication**: Laravel Sanctum
- **API**: RESTful with JSON responses
- **Validation**: Form Request validation
- **Deployment**: Docker on Render.com

### Frontend (Vue.js)
- **Framework**: Vue.js 3 (Composition API)
- **HTTP Client**: Axios
- **Styling**: CSS
- **Routing**: Vue Router
- **State Management**: Local Storage + Reactive data
- **Deployment**: GitHub Pages

## Features Implemented

### Authentication
- User Registration
- User Login/Logout  
- Token-based authentication
- Protected routes

### Task Management
- Create new tasks
- View task list
- Edit task details
- Delete tasks
- Mark complete/incomplete
- Set deadlines
- User-specific tasks

### API Features
- RESTful endpoints
- JSON responses
- Input validation
- Error handling
- CORS support
- Token authentication

### Frontend Features
- Responsive design
- Form validation
- Loading states
- Error messages
- Intuitive UI/UX
- Mobile-friendly

## Database Schema
See `database.sql` for complete schema.

**Main Tables:**
- `users` - User accounts
- `tasks` - Task items
- `personal_access_tokens` - API authentication

## Testing

### API Testing (Postman)
Base URL: `https://taskbackend-vrp7.onrender.com/api`

**Authentication:**
- POST `/register` - Create account
- POST `/login` - Get auth token

**Tasks (Requires Bearer token):**
- GET `/tasks` - List user tasks
- POST `/tasks` - Create task
- PUT `/tasks/{id}` - Update task  
- DELETE `/tasks/{id}` - Remove task

### Sample API Usage
```javascript
POST /api/register
{
  "name": "John Doe",
  "email": "john@example.com", 
  "password": "password123"
}

POST /api/tasks
Headers: Authorization: Bearer YOUR_TOKEN
{
  "title": "Complete project",
  "description": "Finish the task app",
  "deadline": "2025-09-15"
}
```

## Submodule Management

### Update submodules to latest version:
```bash
git submodule update --remote
git add .
git commit -m "Update submodules to latest"
git push
```

### When cloning this repo:
```bash
git clone --recursive https://github.com/HMN011104/TaskPJ.git
```

## Contact & Support
**Student**: Huỳnh Minh Nhựt 
**MSSV**: 2251120371 
**Email**: 2251120371
**Class**: CN22G

*Last updated: September 2025*