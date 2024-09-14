import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["uploadCoverInput", "coverPreview", "uploadText"];

  connect() {
    this.uploadCoverInputTarget.addEventListener(
      "change",
      this.updateCoverPreview,
    );
  }

  updateCoverPreview = () => {
    const [file] = this.uploadCoverInputTarget.files;
    if (file) {
      this.coverPreviewTarget.src = URL.createObjectURL(file);
      this.coverPreviewTarget.classList.remove("hidden");
      this.uploadTextTarget.innerText = "Change cover";
    }
  };
}
