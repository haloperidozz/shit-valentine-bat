<script setup lang="ts">
import { ref } from 'vue'

import { ValentineGenerator } from '../valentine-generator'
import { type ValentineProperties } from '../valentine-generator'

const SCRIPT_FILENAME = "shit-valentine.bat"

const properties = ref<ValentineProperties>({
  title: "Will you be my Valentine?",
  agreeButtonText: "Yes",
  phrases: ["No", "Are you sure?", ":(((("],
  agreeDialogTitle: "Will you be my Valentine?",
  agreeDialogText: "You can't say no! ❤️"
})

function download(): void {
  const generator = new ValentineGenerator(properties.value)
  const script = generator.generateScript()
  
  const scriptBlob = new Blob([script], { type: 'text/plain' })
  const scriptObjectUrl = URL.createObjectURL(scriptBlob)

  const scriptLinkElement = document.createElement('a')
  scriptLinkElement.href = scriptObjectUrl
  scriptLinkElement.download = SCRIPT_FILENAME

  document.body.appendChild(scriptLinkElement)
  
  scriptLinkElement.click()

  URL.revokeObjectURL(scriptObjectUrl)
  scriptLinkElement.remove()
}
</script>

<template>
  <div class="container">
    <div class="form-group">
      <label for="title">Title:</label>
      <input
        id="title"
        v-model="properties.title"
        class="form-control"
      />
    </div>

    <div class="form-group">
      <label for="agreeButtonText">Agree Button Text:</label>
      <input
        id="agreeButtonText"
        v-model="properties.agreeButtonText"
        class="form-control"
      />
    </div>

    <div class="form-group">
      <label>Phrases:</label>
      <div 
        class="phrase-item"
        v-for="(_, index) in properties.phrases" 
        :key="index"
      >
        <input
          v-model="properties.phrases[index]"
          class="form-control phrase-input"
        />
        <button
          @click="properties.phrases.splice(index, 1)"
          class="btn-remove"
        >
          X
        </button>
      </div>
      <button @click="properties.phrases.push('')" class="btn-add">
        Add Phrase
      </button>
    </div>

    <div class="form-group">
      <label for="dialogTitle">Agree Dialog Title:</label>
      <input
        id="dialogTitle"
        v-model="properties.agreeDialogTitle"
        class="form-control"
      />
    </div>

    <div class="form-group">
      <label for="dialogText">Agree Dialog Text:</label>
      <input
        id="dialogText"
        v-model="properties.agreeDialogText"
        class="form-control"
      />
    </div>

    <button @click="download" class="btn-download">Download</button>
  </div>
</template>

<style scoped>
.container {
  max-width: 600px;
  margin: 0 auto;
  padding: 20px;
  font-family: sans-serif;
}

.form-group {
  margin-bottom: 20px;
}

label {
  display: block;
  margin-bottom: 5px;
  font-weight: bold;
}

.form-control {
  width: 100%;
  padding: 8px 12px;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
}

.phrase-item {
  display: flex;
  align-items: center;
  margin-bottom: 10px;
}

.phrase-input {
  flex-grow: 1;
}

.btn-remove {
  margin-left: 10px;
  background-color: #e74c3c;
  border: none;
  color: #fff;
  padding: 8px 12px;
  border-radius: 4px;
  cursor: pointer;
}

.btn-remove:hover {
  background-color: #c0392b;
}

.btn-add,
.btn-download {
  background-color: #3498db;
  border: none;
  color: #fff;
  padding: 10px 15px;
  border-radius: 4px;
  cursor: pointer;
  margin-top: 10px;
}

.btn-add:hover,
.btn-download:hover {
  background-color: #2980b9;
}
</style>
