from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel

app = FastAPI(title="Epic Coding Adventure API")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Allow all origins for development
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

class CodeSubmission(BaseModel):
    code: str
    language: str

@app.get("/")
def read_root():
    return {"message": "Welcome to the Kingdom of Code API"}

@app.post("/execute")
def execute_code(submission: CodeSubmission):
    lang = submission.language.lower()
    code = submission.code
    
    # Mock Execution Logic for different languages
    if lang == "python":
        if "print" in code and "Ssssalutations" in code:
            return {"status": "success", "output": "Ssssalutations!", "message": "The Python Guardian awakens!"}
        return {"status": "error", "output": "Syntax Error: The snake sleeps.", "message": "Hint: print('Ssssalutations!')"}
    
    elif lang == "javascript":
        if "console.log" in code and "Hello Web" in code:
            return {"status": "success", "output": "Hello Web", "message": "The Spider weaves a new web!"}
        return {"status": "error", "output": "ReferenceError: Web not found.", "message": "Hint: console.log('Hello Web')"}
    
    elif lang == "c#":
        if "Console.WriteLine" in code and "Shield Up" in code:
             return {"status": "success", "output": "Shield Up", "message": "The Golem salutes you!"}
        return {"status": "error", "output": "Compilation Error.", "message": "Hint: Console.WriteLine('Shield Up');"}
        
    return {
        "status": "error", 
        "output": f"Language '{lang}' not yet supported in this realm.",
        "message": "The Archmage is still scribing this scroll."
    }

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
