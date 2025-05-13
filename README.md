# Arduino Trail Camera - API Backend

This is the Ruby on Rails 8 API backend for the Arduino Trail Camera system. It handles user authentication, data management for photos, real-time communication, and media storage, serving as the core backend for its corresponding [React frontend](https://github.com/voscarmv/arduino_trailcam_frontend) and [Trailcam control subsystem](https://github.com/voscarmv/arduino_trailcam_cli).

## Overview

The Arduino Trailcam API provides a robust and secure backend for managing an Arduino-based trail camera. It leverages Rails 8's built-in authentication system, Solid Cable/Cache/Queue for efficient real-time features and background processing, and Cloudinary for media storage. The API is designed to be deployed via Docker using Kamal.

## Core Functionalities

*   **User Authentication:** Secure user registration, login, and session management using Rails 8's built-in authentication. Includes password reset functionality via email.
*   **Role-Based Access Control:** Differentiates between `admin` and `user` roles, with admins having extended privileges for user management.
*   **Project Management:** CRUD (Create, Read, Update, Delete) operations for "projects" (likely representing trail camera deployments or specific monitoring sessions).
*   **Photo/Media Management:** Handles uploading, storing (via Cloudinary), and serving photos/media captured by the trail camera.
*   **Real-time Communication:** Utilizes Action Cable (backed by Solid Cable) to potentially push real-time updates to connected frontend clients (e.g., new photo notifications, camera status).
*   **Background Job Processing:** Employs Solid Queue for handling asynchronous tasks.
*   **Caching:** Uses Solid Cache for improved performance.
*   **CORS Enabled:** Configured with `rack-cors` to allow cross-origin requests from the frontend application.

## Tech Stack

*   **Framework:** Ruby on Rails 8.0.2 (API-only mode)
*   **Language:** Ruby 3.3.4
*   **Web Server:** Puma (with Thruster for asset caching/compression)
*   **Database:** SQLite3 (with Solid Cache, Solid Queue, and Solid Cable leveraging it for persistent storage)
*   **Authentication:** Rails 8 built-in authentication, `bcrypt` for password hashing.
*   **Media Storage:** Cloudinary
*   **Real-time:** Action Cable (Solid Cable)
*   **Background Jobs:** Solid Queue
*   **Caching:** Solid Cache
*   **Deployment:** Docker, Kamal
*   **Development Tools:** Debug, Brakeman (security scanner), RuboCop (Rails Omakase style)

## Prerequisites

*   Ruby 3.3.4 (as specified in `.ruby-version` and `Dockerfile`)
*   Bundler (Ruby gem manager)
*   SQLite3
*   Node.js and Yarn (for JavaScript asset pipeline, if extended beyond API-only for admin interfaces, etc.)
*   A Cloudinary account (for media storage)
*   SMTP server credentials (for password reset emails)

## Getting Started

To get a local copy of the API up and running, follow these steps:

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/your-username/arduino_trailcam_api-main.git
    cd arduino_trailcam_api-main
    ```

2.  **Install Ruby dependencies:**
    ```bash
    bundle install
    ```

3.  **Set up Credentials:**
    Rails uses encrypted credentials to store sensitive information.
    *   **Master Key:** Ensure you have the `config/master.key` file. If not, and you are starting fresh, you can generate one (but if this is a shared project, obtain the key from the maintainer).
    *   **Development Credentials:**
        The application requires SMTP and Cloudinary credentials for development.
        You can set these by editing the encrypted credentials file:
        ```bash
        EDITOR=nano rails credentials:edit --environment=development
        ```
        Use the structure from `config/credentials/development.example.yml` as a template:
        ```yaml
        smtp:
          user_name: 'youremail@gmail.com'
          password: 'your_app_password_or_smtp_password' # e.g., for Gmail App Passwords
        cloudinary:
          url: 'cloudinary://YOUR_API_KEY:YOUR_API_SECRET@YOUR_CLOUD_NAME'
          key: 'YOUR_API_KEY'
          secret: 'YOUR_API_SECRET'
          name: 'YOUR_CLOUD_NAME'
          folder: 'your_trailcam_folder_name' # Optional: organize uploads in Cloudinary
        ```
        Replace the placeholder values with your actual credentials.

4.  **Prepare the Database:**
    This command will create your database, load the schema, and run any pending migrations and seed data.
    ```bash
    rails db:prepare
    ```
    Alternatively, to run migrations and seed separately:
    ```bash
    rails db:migrate
    rails db:seed # This will create a default admin user (admin@example.com / admin)
    ```

5.  **Start the Rails server:**
    ```bash
    rails server
    ```
    The API will typically be available at `http://localhost:3000`.

## API Endpoints & Testing

The API provides standard RESTful endpoints for managing users, projects, and photos.

*   **Authentication Endpoints:**
    *   User Registration
    *   Login (Session creation)
    *   Logout (Session destruction)
    *   Password Reset Request
    *   Password Update
*   **Project Endpoints:** CRUD operations for projects.
*   **Photo Endpoints:** Likely involves creating (uploading) and listing photos.

**For detailed API endpoint information and testing:**

*   **Postman Collection:** A Postman collection is available for testing the API: [Rails 8 Auth API Tester](https://team55-6229.postman.co/workspace/722dec53-df85-40a5-8244-4a7f428b1a8c/request/17376401-d068842a-992c-4626-9515-6a3ba888950a?action=share&source=copy-link&creator=17376401&ctx=documentation) (link from original README).
*   **API Tester Script:** The original README also mentions using [Rails 8 Auth Tester2](https://github.com/voscarmv/rails_8_auth_tester2) for changing passwords and signing up new users via Node.js scripts.

**Default Admin Credentials (after seeding):**
*   Email: `admin@example.com`
*   Password: `admin`

## Real-time Features (Action Cable)

This API is set up with Solid Cable, allowing for real-time features to be implemented. The frontend can connect to `/cable` endpoint to subscribe to channels and receive live updates.

## Media Handling (Cloudinary)

Uploaded photos and other media are stored using Cloudinary. Ensure your Cloudinary credentials are correctly configured in `config/credentials/development.yml` (or the appropriate environment's credentials file) and `config/storage.yml` is set to use the `:cloudinary` service.

## Deployment

### Render.com

The original README provided instructions for deploying on Render.com:

    Build Command: `bundle install;`

    Start Command: `rails db:setup && bundle exec rails server -b 0.0.0.0 -e production`

    Environment Variables:

        RAILS_MASTER_KEY: Set this to the content of your config/credentials/production.key (or config/master.key).

        Add Cloudinary and SMTP credentials as environment variables. (optional)

## Development

    Linting & Styling: Uses rubocop-rails-omakase for Ruby styling. Run bundle exec rubocop to check.

    Security Scanning: Uses brakeman for static security analysis. Run bundle exec brakeman.

    Database Migrations: Manage database schema changes with rails db:migrate.

    Background Jobs: Solid Queue is used. You can start a job worker process with bin/jobs start.

## Contributing

Contributions are welcome. Please adhere to the existing code style and ensure all tests pass.

    1. Fork the Project

    2. Create your Feature Branch (git checkout -b feature/NewApiFeature)

    3. Commit your Changes (git commit -m 'Add some NewApiFeature')

    4. Push to the Branch (git push origin feature/NewApiFeature)

    5. Open a Pull Request

## License

Distributed under the MIT License. See LICENSE.txt (if present) or assume MIT as is common for Rails projects.