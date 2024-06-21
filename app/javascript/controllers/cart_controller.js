import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  initialize() {
    console.log("cart controller initialized");
    const cart = JSON.parse(localStorage.getItem("cart")) || [];
    this.updateCart(cart);
  }

  updateCart(cart) {
    this.element.innerHTML = "";
    let total = 0;
    cart.forEach((item) => {
      total += item.price * item.quantity;
      const div = document.createElement("div");
      div.classList.add(
        "flex",
        "items-center",
        "justify-between",
        "border-b",
        "pb-2",
        "mb-2",
      );

      // Conteúdo do item
      const itemContent = document.createElement("div");
      itemContent.innerHTML = `
        <div class="flex items-center">
          <span class="font-medium">${item.name}</span>
          <span class="ml-2 text-gray-700">- R$${(item.price / 100).toFixed(2)}</span>
          <span class="ml-2 text-gray-700">- Quantity: ${item.quantity}</span>
        </div>
      `;
      div.appendChild(itemContent);

      // Botão de remoção (ícone de lixeira)
      const deleteButton = document.createElement("button");
      deleteButton.innerHTML = `<i class="fas fa-trash-alt text-red-500"></i>`;
      deleteButton.classList.add("ml-2", "text-sm", "focus:outline-none");
      deleteButton.addEventListener("click", () =>
        this.removeFromCart(item.id),
      );
      div.appendChild(deleteButton);

      this.element.appendChild(div);
    });

    // Atualização do total
    const totalEl = document.createElement("div");
    totalEl.innerHTML = `<strong>Total: R$${(total / 100).toFixed(2)}</strong>`;
    document.getElementById("total").innerHTML = "";
    document.getElementById("total").appendChild(totalEl);
  }

  addToCart(event) {
    const productId = event.target.dataset.productId;
    const productName = event.target.dataset.productName;
    const productPrice = parseInt(event.target.dataset.productPrice, 10);

    let cart = JSON.parse(localStorage.getItem("cart")) || [];
    const existingItem = cart.find((item) => item.id == productId);

    if (existingItem) {
      existingItem.quantity += 1;
    } else {
      cart.push({
        id: productId,
        name: productName,
        price: productPrice,
        quantity: 1,
      });
    }

    localStorage.setItem("cart", JSON.stringify(cart));
    this.updateCart(cart);
  }

  removeFromCart(event) {
    const cart = JSON.parse(localStorage.getItem("cart"));
    const values = JSON.parse(event.target.value);
    const index = cart.findIndex((item) => item.id === values.id);

    if (index >= 0) {
      cart.splice(index, 1);
    }

    localStorage.setItem("cart", JSON.stringify(cart));
    this.updateCart(cart);
  }

  clear() {
    localStorage.removeItem("cart");
    this.updateCart([]);
  }

  checkout() {
    const cart = JSON.parse(localStorage.getItem("cart"));
    const payload = {
      authenticity_token: document.querySelector("[name='csrf-token']").content,
      cart: cart,
    };

    fetch("/checkout", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": payload.authenticity_token,
      },
      body: JSON.stringify(payload),
    }).then((response) => {
      if (response.ok) {
        response.json().then((body) => {
          window.location.href = body.url;
        });
      } else {
        response.json().then((body) => {
          const errorEl = document.createElement("div");
          errorEl.innerText = `There was an error processing your order. ${body.error}`;
          document.getElementById("errorContainer").innerHTML = "";
          document.getElementById("errorContainer").appendChild(errorEl);
        });
      }
    });
  }
}
