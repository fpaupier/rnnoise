from pathlib import Path

from fastapi import FastAPI, File, UploadFile
from fastapi.responses import HTMLResponse

app = FastAPI()

local_path = '../backend/examples'


@app.post("/media/")
async def upload_file(file: UploadFile = File(...)):
    # Upload the file - make it available for the denoiser
    content: bytes = await file.read()
    fname: str = file.filename
    fpath = Path(local_path).joinpath(fname)
    with open(fpath, mode='wb+') as f:
        f.write(content)

    # Call the denoiser on the file
    # TODO
    return {"filename": file.filename}


@app.get("/")
async def main():
    content = """
<body>
<form action="/media/" enctype="multipart/form-data" method="post">
<input name="file" type="file">
<input type="submit">
</form>
</body>
    """
    return HTMLResponse(content=content)
