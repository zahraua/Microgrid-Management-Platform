;; Energy Trading Contract

(define-map energy-offers
  { offer-id: uint }
  { seller: principal, amount: uint, price: uint }
)

(define-data-var next-offer-id uint u1)

(define-public (create-offer (amount uint) (price uint))
  (let
    (
      (offer-id (var-get next-offer-id))
    )
    (asserts! (> amount u0) (err u400))
    (asserts! (> price u0) (err u400))
    (map-set energy-offers
      { offer-id: offer-id }
      { seller: tx-sender, amount: amount, price: price }
    )
    (var-set next-offer-id (+ offer-id u1))
    (ok offer-id)
  )
)

(define-public (accept-offer (offer-id uint))
  (let
    (
      (offer (unwrap! (map-get? energy-offers { offer-id: offer-id }) (err u404)))
    )
    (asserts! (not (is-eq (get seller offer) tx-sender)) (err u403))
    (try! (stx-transfer? (get price offer) tx-sender (get seller offer)))
    (map-delete energy-offers { offer-id: offer-id })
    (ok true)
  )
)

(define-read-only (get-offer (offer-id uint))
  (ok (unwrap! (map-get? energy-offers { offer-id: offer-id }) (err u404)))
)

