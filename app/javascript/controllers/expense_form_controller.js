// Visit The Stimulus Handbook for more details
// https://stimulusjs.org/handbook/introduction
//
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "fields", 'form' ]

  connect() {
    console.log('coucou')
  }

  handleSubmit(event) {
    event.preventDefault();
    this.fieldsTargets.forEach(fields => {
      const amount = fields.querySelector('.offer_amount');
      if (amount.value === '') {
        fields.querySelectorAll('input').forEach(input => {
          input.value = '';
        })
      }
    })
    event.target.submit();
  }
}
