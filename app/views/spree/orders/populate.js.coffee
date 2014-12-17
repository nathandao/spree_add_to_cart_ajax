Spree.fetch_cart()
($ '#cart-ajax-message').remove()

($ '<p id="cart-ajax-message">
    <%= Spree.t(:product_was_added_to_your_cart) %>
    </p>').insertAfter('#cart-form')