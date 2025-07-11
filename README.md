

# ScrapeGraphAI API Documentation

**Version:** 1.2.0
**Base URL:** `https://your-api-url.onrender.com` (Replace with your actual deployed URL)

Welcome to the ScrapeGraphAI REST API. This API provides a suite of powerful, AI-driven web scraping and data extraction tools through a simple and consistent interface.

## Authentication

All endpoints require an **OpenAI API key** to be included in the JSON request body for every call.

```json
{
  "api_key": "YOUR_OPENAI_API_KEY",
  "...other_parameters"
}
```

## Health Check

A simple endpoint to verify that the API is running and responsive.

*   **Endpoint:** `GET /health`
*   **Method:** `GET`
*   **Success Response (200 OK):**
    ```json
    {
      "status": "ok"
    }
    ```*   **cURL Example:**
    ```bash
    curl -X GET "https://your-api-url.onrender.com/health"
    ```

## Smart Scraper Endpoints

These endpoints are designed for intelligent data extraction from web pages.

### Run Smart Scraper

Extracts information from a single webpage based on a natural language prompt.

*   **Endpoint:** `POST /smart_scraper/run`
*   **Method:** `POST`
*   **Request Body:**
    ```json
    {
      "api_key": "YOUR_OPENAI_API_KEY",
      "prompt": "List me all the projects with their description",
      "source": "https://perinim.github.io/projects/"
    }
    ```
*   **cURL Example:**
    ```bash
    curl -X POST "https://your-api-url.onrender.com/smart_scraper/run" \
    -H "Content-Type: application/json" \
    -d '{
      "api_key": "YOUR_OPENAI_API_KEY",
      "prompt": "List me all the projects",
      "source": "https://perinim.github.io/projects/"
    }'
    ```

### Run Smart Scraper with Schema

Extracts structured information from a webpage that conforms to a predefined Pydantic schema.

*   **Endpoint:** `POST /smart_scraper/run_with_schema`
*   **Method:** `POST`
*   **Request Body:**
    ```json
    {
      "api_key": "YOUR_OPENAI_API_KEY",
      "prompt": "List me all the projects with their description",
      "source": "https://perinim.github.io/projects/",
      "schema_name": "Projects"
    }
    ```
    *Note: `schema_name` must be one of the predefined schemas: `Projects`, `Ceos`, `Dishes`.*

*   **cURL Example:**
    ```bash
    curl -X POST "https://your-api-url.onrender.com/smart_scraper/run_with_schema" \
    -H "Content-Type: application/json" \
    -d '{
      "api_key": "YOUR_OPENAI_API_KEY",
      "prompt": "List the projects",
      "source": "https://perinim.github.io/projects/",
      "schema_name": "Projects"
    }'
    ```

---

## Search Endpoints

These endpoints perform web searches to gather and extract information.

### Run Search

Searches the internet for information related to a prompt and scrapes the top results to generate a consolidated answer.

*   **Endpoint:** `POST /search/run`
*   **Method:** `POST`
*   **Request Body:**
    ```json
    {
      "api_key": "YOUR_OPENAI_API_KEY",
      "prompt": "What are the most famous dishes in Rome?"
    }
    ```
*   **cURL Example:**
    ```bash
    curl -X POST "https://your-api-url.onrender.com/search/run" \
    -H "Content-Type: application/json" \
    -d '{
      "api_key": "YOUR_OPENAI_API_KEY",
      "prompt": "What is ScrapeGraphAI?"
    }'
    ```

### Run Depth Search

Performs a deep web crawl starting from a source URL, following links up to a specified depth and extracting information relevant to the prompt.

*   **Endpoint:** `POST /depth_search/run`
*   **Method:** `POST`
*   **Request Body:**
    ```json
    {
      "api_key": "YOUR_OPENAI_API_KEY",
      "prompt": "List me all the projects with their description, crawling up to 2 levels deep.",
      "source": "https://perinim.github.io"
    }
    ```

---

## Omni Endpoints

Versatile endpoints designed to handle various data formats and multiple data sources.

### Run Omni Scraper

A universal scraper that can extract textual and visual information (image descriptions) from a single webpage.

*   **Endpoint:** `POST /omni_scraper/run`
*   **Method:** `POST`
*   **Request Body:**
    ```json
    {
      "api_key": "YOUR_OPENAI_API_KEY",
      "prompt": "List me all the projects with their titles, image links, and descriptions.",
      "source": "https://perinim.github.io/projects/"
    }
    ```

### Run Omni Search

Performs a web search and then uses the OmniScraper on the top results to provide a comprehensive answer including text and image analysis.

*   **Endpoint:** `POST /omni_search/run`
*   **Method:** `POST`
*   **Request Body:**
    ```json
    {
      "api_key": "YOUR_OPENAI_API_KEY",
      "prompt": "List me all Chioggia's famous dishes and describe their pictures."
    }
    ```

---

## Generator Endpoints

These endpoints generate Python code for scraping.

### Run Code Generator

Generates a Python function (`extract_data`) to scrape a given webpage based on a prompt and a required output schema.

*   **Endpoint:** `POST /code_generator/run`
*   **Method:** `POST`
*   **Request Body:**
    ```json
    {
      "api_key": "YOUR_OPENAI_API_KEY",
      "prompt": "List me all the projects with their description",
      "source": "https://perinim.github.io/projects/",
      "schema_name": "Projects"
    }
    ```
*   **Success Response (200 OK):**
    ```json
    {
      "code": "import re\nfrom bs4 import BeautifulSoup\n\ndef extract_data(html: str) -> dict:\n    # Generated python code...\n    return data"
    }
    ```

---

## Other Graph Endpoints

### Run Speech Graph

Scrapes a webpage, generates a summary based on a prompt, and converts that summary into an MP3 audio file.

*   **Endpoint:** `POST /speech/run`
*   **Method:** `POST`
*   **Request Body:**
    ```json
    {
      "api_key": "YOUR_OPENAI_API_KEY",
      "prompt": "Make a detailed audio summary of the projects.",
      "source": "https://perinim.github.io/projects/",
      "output_path": "api_generated_summary.mp3"
    }
    ```
*   **Success Response (200 OK):**
    ```json
    {
      "summary": { "key": "value", "...": "..." },
      "audio_file": "api_generated_summary.mp3"
    }
    ```
    *Note: The audio file is saved inside the running Docker container, not returned in the response.*

### Run XML Scraper

Extracts information from raw XML content based on a prompt.

*   **Endpoint:** `POST /xml_scraper/run`
*   **Method:** `POST`
*   **Request Body:**
    ```json
    {
      "api_key": "YOUR_OPENAI_API_KEY",
      "prompt": "List all book authors and their titles.",
      "source": "<?xml version=\"1.0\"?><catalog><book id=\"bk101\"><author>Gambardella, Matthew</author><title>XML Developer's Guide</title></book><book id=\"bk102\"><author>Ralls, Kim</author><title>Midnight Rain</title></book></catalog>"
    }
    ```

### Run CSV Scraper

Extracts information from raw CSV content based on a prompt.

*   **Endpoint:** `POST /csv_scraper/run`
*   **Method:** `POST`
*   **Request Body:**
    ```json
    {
      "api_key": "YOUR_OPENAI_API_KEY",
      "prompt": "List me all the last names from the CSV data",
      "source": "Username;Identifier;First name;Last name\nbooker12;9012;Rachel;Booker\ngrey07;2070;Laura;Grey"
    }
    ```

### Run Document Scraper

Extracts information from raw document text (e.g., from a `.txt` or `.md` file) based on a prompt.

*   **Endpoint:** `POST /document_scraper/run`
*   **Method:** `POST`
*   **Request Body:**
    ```json
    {
      "api_key": "YOUR_OPENAI_API_KEY",
      "prompt": "Summarize this text about The Divine Comedy.",
      "source": "The Divine Comedy, Italian La Divina Commedia, is a long narrative poem written by Dante Alighieri."
    }
    ```


docker build -t scrapegraphai-api .
docker run -p 8000:8000 scrapegraphai-api