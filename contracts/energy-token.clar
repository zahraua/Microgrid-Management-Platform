;; Energy Token Contract

(define-fungible-token energy-token)

(define-data-var token-uri (string-utf8 256) u"https://example.com/energy-token-metadata.json")

(define-public (mint (amount uint) (recipient principal))
  (begin
    (ft-mint? energy-token amount recipient)
  )
)

(define-public (transfer (amount uint) (sender principal) (recipient principal))
  (begin
    (ft-transfer? energy-token amount sender recipient)
  )
)

(define-read-only (get-balance (account principal))
  (ok (ft-get-balance energy-token account))
)

(define-read-only (get-token-uri)
  (ok (var-get token-uri))
)

(define-public (set-token-uri (new-uri (string-utf8 256)))
  (ok (var-set token-uri new-uri))
)

