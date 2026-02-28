const { app, BrowserWindow, ipcMain, shell } = require("electron");
const path = require("path");
const https = require("https");
const fs = require("fs");

let mainWindow;

function createWindow() {
    mainWindow = new BrowserWindow({
        width: 1100,
        height: 700,
        minWidth: 900,
        minHeight: 600,
        center: true,
        frame: false, 
        backgroundColor: "#0f1117",
        show: false,
        webPreferences: {
            preload: path.join(__dirname, "preload.js"),
            contextIsolation: true,
            nodeIntegration: false,
            sandbox: true
        }
    });

    mainWindow.loadFile("Soggs/index.html");

    mainWindow.once("ready-to-show", () => {
        mainWindow.show();

        
        startDownload(
            "", 
            ""
        );
    });
}

app.whenReady().then(createWindow);

app.on("window-all-closed", () => {
    if (process.platform !== "darwin") app.quit();
});

function startDownload(url, fileName) {

    const savePath = path.join(app.getPath("downloads"), fileName);
    const file = fs.createWriteStream(savePath);

    https.get(url, (response) => {

        if (response.statusCode !== 200) {
            mainWindow.webContents.send("download-error", "Error al descargar.");
            return;
        }

        const totalSize = parseInt(response.headers["content-length"], 10);
        let downloaded = 0;

        response.on("data", (chunk) => {
            downloaded += chunk.length;

            if (totalSize) {
                const progress = Math.round((downloaded / totalSize) * 100);
                mainWindow.webContents.send("download-progress", progress);
            }
        });

        response.pipe(file);

        file.on("finish", () => {
            file.close();
            mainWindow.webContents.send("download-complete", savePath);
        });

    }).on("error", (err) => {
        fs.unlink(savePath, () => {});
        mainWindow.webContents.send("download-error", err.message);
    });
}

ipcMain.on("open-location", (event, filePath) => {
    shell.showItemInFolder(filePath);
});