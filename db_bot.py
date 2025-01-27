import json
from openai import OpenAI
import os
import sqlite3
from time import time

print("Running db_bot.py!")

# Helper function to get file paths
fdir = os.path.dirname(__file__)
def getPath(fname):
    return os.path.join(fdir, fname)

# Paths for SQLite setup
sqliteDbPath = getPath("project_db.sqlite")
setupSqlPath = getPath("setup.sql")
setupSqlDataPath = getPath("setupData.sql")

# Erase previous database if it exists
if os.path.exists(sqliteDbPath):
    os.remove(sqliteDbPath)

# Set up the SQLite database
sqliteCon = sqlite3.connect(sqliteDbPath)  # Create a new database
sqliteCursor = sqliteCon.cursor()
with (
    open(setupSqlPath) as setupSqlFile,
    open(setupSqlDataPath) as setupSqlDataFile
):
    setupSqlScript = setupSqlFile.read()
    setupSqlDataScript = setupSqlDataFile.read()

sqliteCursor.executescript(setupSqlScript)  # Create tables and relationships
sqliteCursor.executescript(setupSqlDataScript)  # Populate tables with data

# Function to execute SQL queries
def runSql(query):
    result = sqliteCursor.execute(query).fetchall()
    return result

# Load OpenAI API configuration
configPath = getPath("config.json")
with open(configPath) as configFile:
    config = json.load(configFile)

openAiClient = OpenAI(api_key=config["openaiKey"])

# Function to get GPT responses
def getChatGptResponse(content):
    stream = openAiClient.chat.completions.create(
        model="gpt-4o-mini",  # Use GPT-4 model
        messages=[{"role": "user", "content": content}],
        stream=True,
    )

    responseList = []
    for chunk in stream:
        if chunk.choices[0].delta.content is not None:
            responseList.append(chunk.choices[0].delta.content)

    result = "".join(responseList)
    return result

# Prompt strategies for different scenarios
commonSqlOnlyRequest = " Give me a SQLite SELECT statement that answers the question. Only respond with SQLite syntax. If there is an error, do not explain it!"
strategies = {
    "zero_shot": setupSqlScript + commonSqlOnlyRequest,
    "few_shot": (
        setupSqlScript
        + " Who has multiple dogs? "
        + "\nSELECT owner_id, COUNT(dog_id) FROM ownership GROUP BY owner_id HAVING COUNT(dog_id) > 1;\n"
        + commonSqlOnlyRequest
    ),
}

# Example questions to query the database
questions = [
    "Which cities have the most customers?",
    "Who owns more than one dog?",
    "What are the names of all dogs who have won awards?",
    "List the top 3 dishes by sales in the restaurant database.",
    "Which employees have served the most customers?",
    "Who does not have an email address listed?",
]

# Function to sanitize GPT responses to extract raw SQL code
def sanitizeForJustSql(value):
    gptStartSqlMarker = "```sql"
    gptEndSqlMarker = "```"
    if gptStartSqlMarker in value:
        value = value.split(gptStartSqlMarker)[1]
    if gptEndSqlMarker in value:
        value = value.split(gptEndSqlMarker)[0]

    return value

# Process each strategy
for strategy in strategies:
    responses = {"strategy": strategy, "prompt_prefix": strategies[strategy]}
    questionResults = []
    for question in questions:
        print(f"Processing question: {question}")
        error = "None"
        try:
            # Get SQL syntax from GPT
            sqlSyntaxResponse = getChatGptResponse(strategies[strategy] + " " + question)
            sqlSyntaxResponse = sanitizeForJustSql(sqlSyntaxResponse)
            print(f"SQL Response: {sqlSyntaxResponse}")

            # Execute SQL and fetch raw results
            queryRawResponse = str(runSql(sqlSyntaxResponse))
            print(f"Query Raw Response: {queryRawResponse}")

            # Generate a friendly explanation of the results
            friendlyResultsPrompt = (
                "I asked a question '" + question +
                "' and the response was '" + queryRawResponse +
                "'. Please, just give a concise response in a more friendly way."
            )
            friendlyResponse = getChatGptResponse(friendlyResultsPrompt)
            print(f"Friendly Response: {friendlyResponse}")

        except Exception as err:
            error = str(err)
            print(f"Error: {error}")

        questionResults.append({
            "question": question,
            "sql": sqlSyntaxResponse,
            "queryRawResponse": queryRawResponse,
            "friendlyResponse": friendlyResponse,
            "error": error,
        })

    responses["questionResults"] = questionResults

    # Save results to a JSON file
    outputPath = getPath(f"response_{strategy}_{int(time())}.json")
    with open(outputPath, "w") as outFile:
        json.dump(responses, outFile, indent=2)

# Close database connection
sqliteCursor.close()
sqliteCon.close()
print("Done!")
