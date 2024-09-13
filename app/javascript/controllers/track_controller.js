import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["addTrackButton", "removeTrackButton", "trackItem", "trackList"]

  connect() {
    this.addTrackButtonTarget.addEventListener('click', this.addNewTrackForm)
    this.bindRemoveTrackForm();
  }

  addNewTrackForm = () => {
    const newTrackForm = document.createElement('div');
    newTrackForm.classList.add('track-item', 'grid', 'grid-cols-1', 'md:grid-cols-10', 'gap-1', 'pb-2', 'border-b-2', 'mb-2');
    newTrackForm.setAttribute('data-track-target', 'trackItem');

    newTrackForm.innerHTML = `
      <input type="text" name="album[tracks_attributes][${this.trackItemTargets.length}][title]" placeholder="Track Title" class="shadow rounded-md border border-gray-200 outline-none px-3 py-2 col-span-4">
      <input type="text" name="album[tracks_attributes][${this.trackItemTargets.length}][artist]" placeholder="Artist Name" class="shadow rounded-md border border-gray-200 outline-none px-3 py-2 col-span-3">
      <input type="number" name="album[tracks_attributes][${this.trackItemTargets.length}][duration]" placeholder="Duration" class="shadow rounded-md border border-gray-200 outline-none px-3 py-2 col-span-2">
      <a class="remove-track col-span-1 flex justify-center items-center" data-track-target="removeTrackButton" href="javascript:void(0)">
        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trash" viewBox="0 0 16 16">
          <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5m2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5m3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0z"/>
          <path d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4zM2.5 3h11V2h-11z"/>
        </svg>
      </a>
    `
    this.trackListTarget.appendChild(newTrackForm);
    this.trackListTarget.scrollTop = this.trackListTarget.scrollHeight;

    newTrackForm.querySelector('.remove-track').addEventListener('click', this.removeTrackForm);
  }

  removeTrackForm = (e) => {
    e.currentTarget.closest('.track-item').remove();
  }

  bindRemoveTrackForm = () => {
    this.removeTrackButtonTargets.forEach(removeTrackButtonTarget => {
      removeTrackButtonTarget.addEventListener('click', this.removeTrackForm);
    })
  }
}
