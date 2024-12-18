;; Microgrid Management Contract

(define-map prosumer-data
  { prosumer: principal }
  { production: uint, consumption: uint, last-updated: uint }
)

(define-map demand-response-events
  { event-id: uint }
  { start-time: uint, end-time: uint, target-reduction: uint }
)

(define-data-var next-event-id uint u1)

(define-public (update-energy-data (production uint) (consumption uint))
  (let
    (
      (current-time (unwrap-panic (get-block-info? time (- block-height u1))))
    )
    (map-set prosumer-data
      { prosumer: tx-sender }
      { production: production, consumption: consumption, last-updated: current-time }
    )
    (ok true)
  )
)

(define-public (create-demand-response-event (start-time uint) (end-time uint) (target-reduction uint))
  (let
    (
      (event-id (var-get next-event-id))
    )
    (asserts! (< start-time end-time) (err u400))
    (asserts! (> target-reduction u0) (err u400))
    (map-set demand-response-events
      { event-id: event-id }
      { start-time: start-time, end-time: end-time, target-reduction: target-reduction }
    )
    (var-set next-event-id (+ event-id u1))
    (ok event-id)
  )
)

(define-read-only (get-prosumer-data (prosumer principal))
  (ok (unwrap! (map-get? prosumer-data { prosumer: prosumer }) (err u404)))
)

(define-read-only (get-demand-response-event (event-id uint))
  (ok (unwrap! (map-get? demand-response-events { event-id: event-id }) (err u404)))
)

