const fillExpenseForm = (result, attributeIndex) => {
  console.log('hello')
  const amount = document.getElementById(`user_expenses_attributes_${attributeIndex}_amount`);
  const description = document.getElementById(`user_expenses_attributes_${attributeIndex}title`);
  const duration = Number.parseInt(document.getElementById('map').dataset.duration);
  if (attributeIndex === 0) {
    amount.value = result.offers[0].price.total * duration
    description.value = `${duration} days at ${result.hotel.name}`
  } else {
    amount.value = amount.value
    description.value = description.value
  }
}

export default fillExpenseForm;
