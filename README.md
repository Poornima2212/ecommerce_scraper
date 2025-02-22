# README

# **E-Commerce Product Scraper & Management System**

## **1. Project Overview**
This project is a full-stack web application that scrapes product details from an e-commerce webpage and displays them in a user-friendly interface. The backend is built with **Ruby on Rails**, and the frontend uses **HTML, CSS, and JavaScript**.

## **2. Design Choices**
### **Backend:**
- **Ruby on Rails**: Chosen for its rapid development capabilities and built-in support for RESTful APIs.
- **SQLite**: Used as the database for its scalability and reliability.
- **HTTParty & Nokogiri**: Used for web scraping to fetch product details.
- **Sidekiq & Redis**: Used for background jobs to update product details asynchronously.
- **RSpec**: Used for writing test cases to ensure application reliability.

### **Frontend:**
- **HTML & CSS**: Used for structuring and styling the UI.
- **JavaScript (Vanilla JS)**: Used for interactive elements like asynchronous search and filtering.

## **3. Core Features**
### **Web Scraping & Data Storage**
- Extracts **title, description, price, contact information, size, and category** from a given URL.
- Stores scraped data in a relational database.
- Associates products with categories to facilitate filtering and organization.

### **Product Display & Management**
- Users can **submit a URL** to scrape product details.
- Lists all products, grouped by **categories**.
- Allows users to **update product data** asynchronously if the data is **older than one week**.

### **Search & Interaction**
- Implements **search functionality** to filter products dynamically.

## **4. Assumptions**
- The e-commerce site’s structure remains **consistent** for scraping to work effectively.
- **JavaScript-rendered pages** are not handled (unless additional tools like Selenium or Puppeteer are integrated).
- Users provide **valid URLs** of product pages.
- Data updates are performed **asynchronously** to prevent UI blocking.

## **5. Installation & Setup**
### **Prerequisites**
- Install **Ruby 3.x** and **Rails 7.x**
- Install **Redis** (for background jobs)
- Install **Node.js & Yarn** (for frontend assets)

### **Steps to Run Locally**
1. **Clone the Repository**
   ```sh
   git clone <repository_url>
   cd project-directory
   ```
2. **Install Dependencies**
   ```sh
   bundle install
   yarn install  # If using JavaScript dependencies
   ```
3. **Set Up the Database**
   ```sh
   rails db:create
   rails db:migrate
   ```
4. **Start the Services**
   ```sh
   redis-server &  # Start Redis for background jobs
   bundle exec sidekiq &  # Start Sidekiq worker
   rails server  # Start Rails application
   ```
5. **Access the Application**
   Open `http://localhost:3000` in a web browser.

## **6. Testing**
### **Run RSpec Test Suite**
```sh
bundle exec rspec
```
### **Check Test Coverage**
```sh
open coverage/index.html
```

## **7. Incomplete Aspects & Next Steps**
### **Incomplete Features**
- More robust **error handling** for web scraping failures.
- Caching mechanisms to **reduce duplicate requests**.
- A more advanced **frontend UI using React or Angular**.

### **Potential Next Steps**
- Implement **user authentication** to manage product submissions.
- Enable support for **multiple e-commerce sites**.
- Implement **real-time updates** using WebSockets.

