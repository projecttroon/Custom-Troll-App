const { contextBridge, ipcRenderer } = require("electron");

contextBridge.exposeInMainWorld("launcher", {
    onProgress: (callback) =>
        ipcRenderer.on("download-progress", (e, value) => callback(value)),

    onComplete: (callback) =>
        ipcRenderer.on("download-complete", (e, filePath) => callback(filePath)),

    openFileLocation: (filePath) =>
        ipcRenderer.send("open-file-location", filePath)
});