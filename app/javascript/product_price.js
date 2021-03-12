window.addEventListener('load', () => {
  const price  = document.getElementById("item-price");
  const addTax = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");

  price.addEventListener("input", () => {
    const inputValue = document.getElementById("item-price").value;
      let tax = inputValue * 0.1 ; 
      addTax.innerHTML = tax ;
      profit.innerHTML = inputValue * 0.9 ;
  })
})