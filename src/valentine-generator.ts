import showValentinePs1 from './powershell/show-valentine.ps1?raw'

export interface ValentineProperties {
  title: string
  agreeButtonText: string
  phrases: string[]
  agreeDialogTitle: string
  agreeDialogText: string
}

export class ValentineGenerator {
  private properties: ValentineProperties

  constructor(properties: ValentineProperties) {
    this.properties = properties
  }

  public generateScript(): string {
    const command = this.toUtf16leBase64(showValentinePs1)

    const script = `@echo off
chcp 65001

set "TITLE=${this.properties.title}"
set "AGREE_BUTTON_TEXT=${this.properties.agreeButtonText}"
set "AGREE_DIALOG_TEXT=${this.properties.agreeDialogText}"
set "AGREE_DIALOG_TITLE=${this.properties.agreeDialogTitle}"
set "PHRASES=${this.properties.phrases.join(";")}"

powershell -NoProfile -WindowStyle Hidden -EncodedCommand ${command}`

    return script.replace(/\r?\n/g, "\r\n") // CRLF
  }

  // https://stackoverflow.com/a/61682259
  private toUtf16leBase64(text: string): string {
    const codePoints = text.split('').map(char => char.charCodeAt(0))
    const array = new Uint16Array(codePoints)

    return btoa(
      new Uint8Array(array.buffer)
        .reduce((data, byte) => data + String.fromCharCode(byte), '')
    )
  }
}
