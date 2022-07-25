import { Controller } from "stimulus"
import Rails from "@rails/ujs";

export default class extends Controller {
  static targets = [ "entries", "pagination"]

  initialize() {
    this.loading = false;
  }

  scroll(){
    const nextPage = this.paginationTarget.querySelector("a[rel='next']")
    if(this.loading || nextPage === null) {
      this.paginationTarget.hidden = true
      return
     }
    const url = nextPage.href
    const body = document.body
    const html = document.documentElement
    const height = Math.max(body.scrollHeight, body.offsetHeight, html.clientHeight, html.scrollHeight, html.offsetHeight)
    if(window.pageYOffset >= height - window.innerHeight -100){
      this.loadMore(url)
    }
  }

  loadMore(url){
    this.loading = true;
    Rails.ajax({
      type: 'GET',
      url: url,
      dataType: 'json',
      success: (data) => {
        this.entriesTarget.insertAdjacentHTML('beforeend', data.entries)
        this.paginationTarget.innerHTML = data.pagination
        this.loading = false;
      },
    })
  }
}