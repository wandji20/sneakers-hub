import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets =  ['modal'];
  
  connect() {
    this.showModal()
  }
  
  showModal(){
    $(this.modalTarget).modal('show');
  }
}